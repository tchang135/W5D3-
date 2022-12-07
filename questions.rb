require 'sqlite3'
require 'singleton'

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
        data = QuestionsDB.instance.execute(SELECT * FROM users WHERE users.id = id )
        User.new(data)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create 
        raise "#{self} already in database" if @id
        QuestionsDB.instance.execute (<<-SQL, @fname, lname)
            INSERT INTO 
                users (fname, lname)
            VALUES 
                (?, ?)     
        SQL
        @id = QuestionsDB.instance.last_insert_row_id
    end

    def update 
        raise "#{self} not in database" unless @id 
        QuestionsDB.instance.execute (<<-SQL, @fname, @lname)
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

end