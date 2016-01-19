CREATE TABLE IF NOT EXISTS games (
  game_id char(26) PRIMARY KEY,
  date date NOT NULL,
  home varchar(7) NOT NULL,
  away varchar(7) NOT NULL,
  game smallint  NOT NULL,
  umpire varchar(30) DEFAULT NULL,
  wind smallint  DEFAULT NULL,
  wind_dir varchar(20) DEFAULT NULL,
  temp smallint DEFAULT NULL,
  type smallint  NOT NULL DEFAULT '1',
  runs_home smallint  DEFAULT NULL,
  runs_away smallint  DEFAULT NULL,
  local_time time DEFAULT NULL,
  completion varchar(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS atbats (
  ab_id char(30) PRIMARY KEY,
  game_id char(26) NOT NULL,
  inning smallint NOT NULL,
  half smallint  DEFAULT '0',
  num smallint NOT NULL,
  ball smallint  NOT NULL,
  strike smallint  NOT NULL,
  outs smallint  NOT NULL,
  batter integer  NOT NULL,
  pitcher integer  NOT NULL,
  stand varchar(1) NOT NULL,
  des varchar(500) NOT NULL,
  event varchar(50) NOT NULL,
  hit_x float DEFAULT NULL,
  hit_y float DEFAULT NULL,
  hit_type varchar(1) DEFAULT NULL,
  bbtype varchar(2) DEFAULT NULL,
  play_result smallint DEFAULT NULL,
  /* 
  pitcher_seq integer DEFAULT NULL,
  pitcher_ab_seq integer DEFAULT NULL,
  */
  def2 integer  DEFAULT NULL,
  def3 integer  DEFAULT NULL,
  def4 integer  DEFAULT NULL,
  def5 integer  DEFAULT NULL,
  def6 integer  DEFAULT NULL,
  def7 integer  DEFAULT NULL,
  def8 integer  DEFAULT NULL,
  def9 integer  DEFAULT NULL,
  FOREIGN KEY (game_id) REFERENCES games(game_id)
);

CREATE TABLE IF NOT EXISTS actions (
  ac_id char(30) PRIMARY KEY,
  game_id char(26) NOT NULL,
  inning smallint NOT NULL,
  half smallint DEFAULT '0',
  event_num smallint NOT NULL,
  des varchar(400) NOT NULL,
  ball smallint DEFAULT NULL,
  strike smallint DEFAULT NULL,
  outs smallint DEFAULT NULL,
  pitch_num smallint DEFAULT NULL,
  event varchar(50) DEFAULT NULL,
  FOREIGN KEY (game_id) REFERENCES games(game_id)
);

CREATE TABLE IF NOT EXISTS runners (
  run_id char(37) PRIMARY KEY,
  game_id char(26) NOT NULL,
  inning smallint NOT NULL,
  half smallint DEFAULT '0',
  event_num smallint NOT NULL,
  runner_id integer DEFAULT NULL,
  start_b char(2) DEFAULT NULL,
  end_b char(2) DEFAULT NULL,
  event varchar(30) DEFAULT NULL,
  FOREIGN KEY (game_id) REFERENCES games(game_id)
);

CREATE TABLE IF NOT EXISTS game_types (
  id smallint PRIMARY KEY,
  type varchar(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS pitches (
  pitch_id char(30) PRIMARY KEY,
  ab_id char(30) NOT NULL,
  des varchar(30) NOT NULL,
  type varchar(1) NOT NULL,
  id smallint  NOT NULL,
  x float  NOT NULL,
  y float  NOT NULL,
  start_speed float  DEFAULT NULL,
  end_speed float  DEFAULT NULL,
  sz_top float  DEFAULT NULL,
  sz_bot float  DEFAULT NULL,
  pfx_x float DEFAULT NULL,
  pfx_z float DEFAULT NULL,
  px float DEFAULT NULL,
  pz float DEFAULT NULL,
  x0 float DEFAULT NULL,
  y0 float DEFAULT NULL,
  z0 float DEFAULT NULL,
  vx0 float DEFAULT NULL,
  vy0 float DEFAULT NULL,
  vz0 float DEFAULT NULL,
  ax float DEFAULT NULL,
  ay float DEFAULT NULL,
  az float DEFAULT NULL,
  break_y float DEFAULT NULL,
  break_angle float DEFAULT NULL,
  break_length float DEFAULT NULL,
  ball smallint  DEFAULT NULL,
  strike smallint  DEFAULT NULL,
  on_1b integer  DEFAULT NULL,
  on_2b integer  DEFAULT NULL,
  on_3b integer  DEFAULT NULL,
  sv_id varchar(13) DEFAULT NULL,
  pitch_type varchar(2) DEFAULT NULL,
  type_confidence double precision DEFAULT NULL,
  my_pitch_type smallint DEFAULT NULL,
  nasty smallint  DEFAULT NULL,
  cc varchar(300) DEFAULT NULL,
  /*
  pitch_seq integer DEFAULT NULL,
  */
  ball_count smallint  DEFAULT NULL,
  strike_count smallint  DEFAULT NULL,
  /* New Fields */
  spin_dir float DEFAULT NULL,
  spin_rate float DEFAULT NULL,
  zone smallint DEFAULT NULL,
  /* New Statcast Fields */
  bb_vel integer DEFAULT NULL,
  bb_dist integer DEFAULT NULL,
  event_num smallint NOT NULL,
  FOREIGN KEY (ab_id) REFERENCES atbats(ab_id)
);

CREATE TABLE IF NOT EXISTS pitch_types (
  id smallint NOT NULL,
  pitch varchar(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS players (
  eliasid integer  PRIMARY KEY,
  first varchar(20) NOT NULL,
  last varchar(20) NOT NULL,
  lahmanid varchar(10) DEFAULT NULL,
  throws varchar(1) DEFAULT NULL,
  height smallint  DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS umpires (
  ump_id serial PRIMARY KEY,
  first varchar(20) NOT NULL,
  last varchar(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS statcast (
  game_id char(26) PRIMARY KEY,
  event_num smallint NOT NULL,
  distance smallint DEFAULT NULL,
  speed smallint DEFAULT NULL,
  FOREIGN KEY (game_id) REFERENCES atbats(game_id)
);
