PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_like;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY, 
    fname TEXT NOT NULL, 
    lname TEXT NOT NULL 

); 

CREATE TABLE questions (
    id INTEGER PRIMARY KEY, 
    title TEXT NOT NULL, 
    body TEXT NOT NULL, 
    associated_author_id INTEGER NOT NULL,  

FOREIGN KEY (associated_author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY, 
    user_id INTEGER,
    question_id INTEGER,

FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_id INTEGER,
    body TEXT NOT NULL,
    user_id INTEGER not NULL,

FOREIGN KEY (parent_id) REFERENCES replies(id),
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_like (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
    users (fname, lname)
VALUES 
    ('Timothy', 'Chang'),
    ('Wilson', 'Wu');


INSERT INTO 
    questions (title, body, associated_author_id)
VALUES 
    ('What is Big O?', 'Im having trouble understanding the concept of Big O, could someone explain it to me?', 1),
    ('What is Recursion', 'Im stuck on the rescursion HW, could someone help me with question 5?', 2);
    

INSERT INTO 
    question_follows (user_id, question_id)
VALUES
    (1, 2),
    (1, 1),
    (2, 1);


INSERT INTO 
    replies (question_id, parent_id, body, user_id)
VALUES  
    (1, NULL, 'you should try googling it', 2),
    (1, 1, 'i found it, thanks', 1);

INSERT INTO
    question_like(user_id, question_id)
VALUES
    (1, 1),
    (2, 1),
    (2, 2);