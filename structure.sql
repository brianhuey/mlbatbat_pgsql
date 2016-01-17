CREATE TABLE IF NOT EXISTS `atbats` (
  `ab_id` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `game_id` smallint(6) unsigned NOT NULL,
  `inning` tinyint(2) unsigned NOT NULL,
  `half` tinyint(1) unsigned DEFAULT '0',
  `num` tinyint(3) unsigned NOT NULL,
  `ball` tinyint(1) unsigned NOT NULL,
  `strike` tinyint(1) unsigned NOT NULL,
  `outs` tinyint(1) unsigned NOT NULL,
  `batter` mediumint(6) unsigned NOT NULL,
  `pitcher` mediumint(6) unsigned NOT NULL,
  `stand` varchar(1) NOT NULL,
  `des` varchar(400) NOT NULL,
  `event` varchar(50) NOT NULL,
  `hit_x` float DEFAULT NULL,
  `hit_y` float DEFAULT NULL,
  `hit_type` varchar(1) DEFAULT NULL,
  `bbtype` varchar(2) DEFAULT NULL,
  `pitcher_seq` int(2) unsigned NOT NULL,
  `pitcher_ab_seq` int(2) unsigned NOT NULL,
  `def2` mediumint(6) unsigned NOT NULL,
  `def3` mediumint(6) unsigned NOT NULL,
  `def4` mediumint(6) unsigned NOT NULL,
  `def5` mediumint(6) unsigned NOT NULL,
  `def6` mediumint(6) unsigned NOT NULL,
  `def7` mediumint(6) unsigned NOT NULL,
  `def8` mediumint(6) unsigned NOT NULL,
  `def9` mediumint(6) unsigned NOT NULL,
  PRIMARY KEY (`ab_id`),
  KEY `game_id` (`game_id`),
  KEY `num` (`num`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Play-by-play data';

CREATE TABLE IF NOT EXISTS `games` (
  `game_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `home` varchar(7) NOT NULL,
  `away` varchar(7) NOT NULL,
  `game` tinyint(3) unsigned NOT NULL,
  `umpire` varchar(30) DEFAULT NULL,
  `wind` tinyint(4) unsigned DEFAULT NULL,
  `wind_dir` varchar(20) DEFAULT NULL,
  `temp` tinyint(4) DEFAULT NULL,
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `runs_home` tinyint(3) unsigned DEFAULT NULL,
  `runs_away` tinyint(3) unsigned DEFAULT NULL,
  `local_time` time DEFAULT NULL,
  PRIMARY KEY (`game_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `game_types` (
  `id` tinyint(3) unsigned NOT NULL,
  `type` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `pitches` (
  `pitch_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ab_id` mediumint(8) unsigned NOT NULL,
  `des` varchar(30) NOT NULL,
  `type` varchar(1) NOT NULL,
  `id` smallint(5) unsigned NOT NULL,
  `x` float unsigned NOT NULL,
  `y` float unsigned NOT NULL,
  `start_speed` float unsigned DEFAULT NULL,
  `end_speed` float unsigned DEFAULT NULL,
  `sz_top` float unsigned DEFAULT NULL,
  `sz_bot` float unsigned DEFAULT NULL,
  `pfx_x` float DEFAULT NULL,
  `pfx_z` float DEFAULT NULL,
  `px` float DEFAULT NULL,
  `pz` float DEFAULT NULL,
  `x0` float DEFAULT NULL,
  `y0` float DEFAULT NULL,
  `z0` float DEFAULT NULL,
  `vx0` float DEFAULT NULL,
  `vy0` float DEFAULT NULL,
  `vz0` float DEFAULT NULL,
  `ax` float DEFAULT NULL,
  `ay` float DEFAULT NULL,
  `az` float DEFAULT NULL,
  `break_y` float DEFAULT NULL,
  `break_angle` float DEFAULT NULL,
  `break_length` float DEFAULT NULL,
  `ball` tinyint(3) unsigned DEFAULT NULL,
  `strike` tinyint(3) unsigned DEFAULT NULL,
  `on_1b` mediumint(8) unsigned DEFAULT NULL,
  `on_2b` mediumint(8) unsigned DEFAULT NULL,
  `on_3b` mediumint(8) unsigned DEFAULT NULL,
  `sv_id` varchar(13) DEFAULT NULL,
  `pitch_type` varchar(2) DEFAULT NULL,
  `type_confidence` double DEFAULT NULL,
  `my_pitch_type` tinyint(2) DEFAULT NULL,
  `nasty` tinyint(3) unsigned DEFAULT NULL,
  `cc` varchar(300) DEFAULT NULL,
  `pitch_seq` int(3) unsigned NOT NULL,
  `ball_count` tinyint(3) unsigned DEFAULT NULL,
  `strike_count` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`pitch_id`),
  KEY `ab_id` (`ab_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `pitch_types` (
  `id` tinyint(2) NOT NULL,
  `pitch` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='list of pitch types';

CREATE TABLE IF NOT EXISTS `players` (
  `eliasid` mediumint(6) unsigned NOT NULL,
  `first` varchar(20) NOT NULL,
  `last` varchar(20) NOT NULL,
  `lahmanid` varchar(10) DEFAULT NULL,
  `throws` varchar(1) DEFAULT NULL,
  `height` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`eliasid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='MLB Player IDs and names';

CREATE TABLE IF NOT EXISTS `umpires` (
  `ump_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `first` varchar(20) NOT NULL,
  `last` varchar(20) NOT NULL,
  PRIMARY KEY (`ump_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Home plate umpire names';
