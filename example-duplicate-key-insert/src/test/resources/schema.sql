CREATE DATABASE local1;
use local1;

CREATE TABLE `person` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `name` varchar(45) NOT NULL,
  `val` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `person_basic` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `name` varchar(45) NOT NULL,
   FOREIGN KEY fk_pb_id(id)
   REFERENCES person(id)
   ON UPDATE CASCADE
   ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `person_attr` (
  `id` int(11) NOT NULL PRIMARY KEY,
  `val` varchar(45) NOT NULL,
   FOREIGN KEY fk_pa_id(id)
   REFERENCES person(id)
   ON UPDATE CASCADE
   ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*
CREATE TABLE `person-changed` (
  `person-id` varchar(45) NOT NULL UNIQUE, -- the id of record that has changed
  PRIMARY KEY (`person-id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
*/
#select row_count();
select * from person;
select * from person_basic;
select * from person_attr;

delete from person;
delete from person_basic;
delete from person_attr;

drop table person;
drop table person_basic;
drop table person_attr;



insert into person(id, name, val) values (1,'Curly1','v1') on duplicate key update id=1, name='Curly1', val='v1'; 
-- returns 1
insert into person(id, name, val) values (1,'Curly','v1') on duplicate key update id=1, name='Curly', val='v1'; 
-- returns 2
insert into person(id, name, val) values (1,'Curly','v1') on duplicate key update id=1, name='Curly', val='v1'; 
-- returns 0
-- -1 is a valid return, when the table is not queried at all

