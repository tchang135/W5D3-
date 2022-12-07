require 'sqlite3'
require 'singleton'
require 'byebug'

class QuestionsDB < SQLite3::Database
    include Singleton 

    def initialize 
        super('questions.db')
        self.type_translation = true 
        self.results_as_hash = true 
    end
end


class User
    attr_accessor :id, :fname, :lname 

    def self.find_by_id(id)
        data = QuestionsDB.instance.execute('SELECT * FROM users WHERE users.id = id')
        User.new(data.last)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create 
        raise "#{self} already in database" if @id
        QuestionsDB.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO 
                users (fname, lname)
            VALUES 
                (?, ?)     
        SQL
        @id = QuestionsDB.instance.last_insert_row_id
    end

    def update 
        raise "#{self} not in database" unless @id 
        QuestionsDB.instance.execute(<<-SQL, @fname, @lname)
            UPDATE
                users 
            SET 
                fname = ?, lname = ? 
            WHERE 
                id = ? 
        SQL
    end

end



class Question 
    attr_accessor :id, :title, :body, :author_id
    
    def self.find_by_id(id)
        data = QuestionsDB.instance.execute('SELECT * FROM questions WHERE questions.id = id' )
        Question.new(data.first)
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDB.instance.execute(<<-SQL, author_id)
        SELECT 
            * 
        FROM 
            questions 
        WHERE 
            author_id = ?

        SQL
        return nil if data.length == 0 
        Question.new(data.first)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def create 
        raise "#{self} already in database" if @id
        QuestionsDB.instance.execute(<<-SQL, @title, @body, @author_id)
            INSERT INTO 
                questions (title, body, author_id)
            VALUES 
                (?, ?, ?)     
        SQL
        @id = QuestionsDB.instance.last_insert_row_id
    end

    def update 
        raise "#{self} not in database" unless @id 
        QuestionsDB.instance.execute(<<-SQL, @title, @body, @author_id)
            UPDATE
                questions
            SET 
                title = ?, body = ?, author_id = ?
            WHERE 
                id = ? 
            SQL
    end

end


