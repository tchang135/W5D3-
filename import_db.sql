PRAGMA foreign_keys = ON;

CREATE TABLE users (
    id INTEGER PRIMARY KEY, 
    fname TEXT NOT NULL, 
    lname TEXT NOT NULL 

); 

CREATE TABLE questions (
    id INTEGER PRIMARY KEY, 
    title TEXT NOT NULL, 
    body TEXT NOT NULL, 
    associated_author_id INTEGER NOT NULL  

FOREIGN KEY (associated_author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    user_id INTEGER,
    question_id INTEGER

);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    subject INTEGER NOT NULL,
    parent INTEGER,
    body TEXT NOT NULL;
    user_id INTEGER not NULL;

FOREIGN KEY (parent) REFERENCES (id)
);

CREATE TABLE question_like (
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    likes INTEGER
);