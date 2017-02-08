DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,
  question_id INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Hyun', 'Kim'),
  ('Fariba', 'Massah'),
  ('AppAcademy', 'Student'),
  ('Mickey', 'Mouse'),
  ('Sponge', 'Bob');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('SQL', 'TEXT VS VARCHAR', 2), --1
  ('Null', 'Does it automatically insert NULL into the table', 1),
  ('Ruby', 'What is Ruby?', 5),
  ('Javascript', 'What is Javascript?', 4),
  ('Test', 'Assessment question', 2), --5
  ('Lunch', 'When is lunch?', 3),
  ('Ruby1', 'What is Ruby?', 5),
  ('Javascript2', 'What is Javascript?', 4),
  ('Test3', 'Assessment question', 2), --9
  ('Lunch4', 'When is lunch?', 3);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (2, 1),
  (1, 1),
  (2, 2),
  (1, 5),
  (2, 5),
  (3, 5),
  (4, 5),
  (5, 5),
  (1, 2),
  (3, 2),
  (3, 3),
  (3, 4);


INSERT INTO
  replies (user_id, question_id, body, parent_id)
VALUES
  (1, 1, 'Text is very outdated so we don''t use it anymore.', NULL),
  (2, 1, 'Thanks!!', 1),
  (1, 1, 'No problem', 2),
  (1, 3, 'I wish I knew...', NULL),
  (4, 3, 'Come to Disneyland and experience the Ruby magic', NULL),
  (1, 3, 'I wish I could go, but it''s too expensive', 5);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 1),
  (2, 1),
  (1, 5),
  (2, 5),
  (3, 5),
  (4, 5),
  (5, 5),
  (2, 3),
  (1, 3),
  (1, 4),
  (5, 4),
  (5, 3),
  (2, 6),
  (4, 6),
  (5, 7),
  (2, 8),
  (1, 8),
  (1, 9),
  (5, 10),
  (5, 1);
