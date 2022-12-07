_-- Create your tables, views, functions and procedures here!
CREATE SCHEMA destruction;
USE destruction;

CREATE TABLE players (
  player_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL, 
  last_name VARCHAR(30) NOT NULL, 
  email VARCHAR(50) NOT NULL
);


CREATE TABLE characters (
  character_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  player_id INT UNSIGNED NOT NULL, 
  name VARCHAR(30) NOT NULL, 
  level TINYINT UNSIGNED NOT NULL,
  CONSTRAINT characters_fk_players
    FOREIGN KEY(player_id)
      REFERENCES players(player_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
  
);

CREATE TABLE character_stats (
  character_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  health INT UNSIGNED NOT NULL, 
  armor TINYINT UNSIGNED NOT NULL,
  CONSTRAINT characters_stats_fk_players
    FOREIGN KEY(character_id)
      REFERENCES characters (character_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
  
);

CREATE TABLE teams (
  team_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR (30) NOT NULL
);

CREATE TABLE team_members(
  team_member_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  team_id INT UNSIGNED NOT NULL,
  character_id INT UNSIGNED NOT NULL,
  CONSTRAINT team_members_fk_teams
    FOREIGN KEY(team_id)
    REFERENCES teams (team_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT team_members_fk_characters
    FOREIGN KEY(character_id)
    REFERENCES characters (character_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE items (
  item_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL, 
  armor INT UNSIGNED NOT NULL, 
  damage INT UNSIGNED NOT NULL
);


CREATE TABLE inventory (
  inventory_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  character_id INT UNSIGNED NOT NULL,
  item_id INT UNSIGNED NOT NULL,
  CONSTRAINT inventory_fk_characters
    FOREIGN KEY(character_id)
    REFERENCES characters (character_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT inventory_fk_teams
    FOREIGN KEY(item_id)
    REFERENCES items (item_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE equipped (
  equipped_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  character_id INT UNSIGNED NOT NULL,
  item_id INT UNSIGNED NOT NULL,
  CONSTRAINT equipped_fk_characters
    FOREIGN KEY(character_id)
    REFERENCES characters (character_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT equipped_fk_teams
    FOREIGN KEY(item_id)
    REFERENCES items (item_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

CREATE TABLE winners (
  character_id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(30) NOT NULL, 
  CONSTRAINT winners_fk_character
      FOREIGN KEY(character_id)
      REFERENCES characters (character_id)
      ON UPDATE CASCADE
      ON DELETE CASCADE
  
);

CREATE OR REPLACE VIEW character_items AS
  SELECT c.character_id, c.name AS character_name, i.name AS item_name, i.armor, i.damage
  FROM characters c
    INNER JOIN inventory iv
    ON c.character_id = iv.character_id
    INNER JOIN items i
    ON iv.item_id = i.item_id
    UNION
    SELECT c.character_id, c.name AS character_name, i.name AS item_name, i.armor, i.damage
    FROM characters c
    INNER JOIN equipped e
    ON c.character_id = e.character_id
    INNER JOIN items i
    ON e.item_id = i.item_id
    ORDER BY character_name, item_name;
    
    
CREATE OR REPLACE VIEW team_items AS
    SELECT t.team_id, t.name AS team_name, i.name AS item_name, i.armor, i.damage
    FROM teams t
    INNER JOIN team_members te
    ON t.team_id = te.team_id
    INNER JOIN characters c
    ON c.character_id = te.character_id
    UNION
   SELECT c.character_id, c.name AS character_name, i.name AS item_name, i.armor, i.damage
    FROM characters c
    INNER JOIN team_members te
    ON t.team_id = te.team_id
    INNER JOIN characters c
    ON c.character_id = te.character_id
    INNER JOIN equipped e
    ON c.character_id = e.character_id
    INNER JOIN items i
    ON e.items_id = i.item_id
    ORDER BY team_name, item_name ASC;

