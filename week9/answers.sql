-- Create your tables, views, functions and procedures here!
CREATE SCHEMA social;
USE social;


CREATE TABLE users (
  user_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL, 
  last_name VARCHAR(30) NOT NULL, 
  email VARCHAR(50) NOT NULL
  created_on ....DATEANDTIMECODE
);

CREATE TABLE sessions (
  session_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL, 
  created_on DATEANDTIMETIMEOFINSERT 
  updated_on DATEANDTIMEOFINSERTORLASTUPDATE
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
  CONSTRAINT friends_fk_teams
    FOREIGN KEY(user_id)
    REFERENCES users (user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT friends_fk_characters
    FOREIGN KEY(user_id)
    REFERENCES users (user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE posts (
  post_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL, 
  created_on ....
  updated_on ....
  content VARCHAR(30) NOT NULL, 
  level TINYINT UNSIGNED NOT NULL,
  CONSTRAINT users_fk_players
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
