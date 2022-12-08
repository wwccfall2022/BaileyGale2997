-- Create your tables, views, functions and procedures here!
CREATE SCHEMA social;
USE social;


CREATE TABLE users (
  user_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL, 
  last_name VARCHAR(30) NOT NULL, 
  email VARCHAR(50) NOT NULL,
  created_on TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE sessions (
  session_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL, 
  created_on TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_on TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  CONSTRAINT sessions_fk_users
    FOREIGN KEY(user_id)
      REFERENCES users (user_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
  
);

CREATE TABLE friends(
  user_friend_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  CONSTRAINT friends_fk_characters
    FOREIGN KEY(user_id)
    REFERENCES users (user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE posts(
  post_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL, 
  content VARCHAR(50) NOT NULL,
  created_on TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_on TIMESTAMP NOT NULL DEFAULT NOW() ON UPDATE NOW(), 
  CONSTRAINT users_fk_posts
    FOREIGN KEY(user_id)
      REFERENCES users(user_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
  
);


CREATE TABLE notifications(
  notification_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  post_id INT UNSIGNED NOT NULL,
  CONSTRAINT notificatons_fk_users
    FOREIGN KEY(user_id)
    REFERENCES users (user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT notifications_fk_post
    FOREIGN KEY(post_id)
    REFERENCES posts (post_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);


CREATE OR REPLACE VIEW notification_posts AS
  SELECT n.user_id, u.first_name AS first_name, u.last_name AS last_name, p.post_id, p.content
  FROM notifications n
    INNER JOIN posts p
    ON n.user_id = p.user_id
    INNER JOIN users u
    ON p.item_id = u.item_id
    UNION
    SELECT n.user_id, u.first_name AS first_name, u.last_name AS last_name, p.post_id, p.content
    FROM notifications n
    INNER JOIN posts p
    ON n.user_id = p.user_id
    INNER JOIN users u
    ON p.item_id = u.item_id
    ORDER BY first_name, last_name ASC ;


