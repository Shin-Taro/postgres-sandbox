CREATE DATABASE mahjong_db;

\c mahjong_db;

CREATE SCHEMA IF NOT EXISTS mahjong_records;
SET search_path = mahjong_records;

CREATE ROLE mahjong_records_user WITH LOGIN PASSWORD 'mahjong_records_user';

GRANT ALL PRIVILEGES ON SCHEMA mahjong_records TO mahjong_records_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA mahjong_records GRANT ALL PRIVILEGES ON TABLES TO mahjong_records_user;

CREATE TABLE IF NOT EXISTS mahjong_records.player (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mahjong_records.game (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  played_at TIMESTAMP,
  player1_id UUID NOT NULL REFERENCES player(id),
  player1_score INT NOT NULL,
  player1_point INT NOT NULL,
  player2_id UUID NOT NULL REFERENCES player(id),
  player2_score INT NOT NULL,
  player2_point INT NOT NULL,
  player3_id UUID NOT NULL REFERENCES player(id),
  player3_score INT NOT NULL,
  player3_point INT NOT NULL,
  player4_id UUID NOT NULL REFERENCES player(id),
  player4_score INT NOT NULL,
  player4_point INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mahjong_records.total_score (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  player_id UUID NOT NULL REFERENCES player(id),
  score INT NOT NULL,
  point INT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO mahjong_records.player (name) VALUES ('しんたろ'), ('えび'), ('つん'), ('たまご');
