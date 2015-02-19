
Test to get mysql database affected-rows count from mule's database connector. Data files are in /test/resources.

CREATE DATABASE local1;

use local1;

CREATE TABLE `person` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

select row_count();

select * from person;

truncate table person;



insert into person(id, name) values (1,'Curly1') on duplicate key update id=1, name='Curly1';

-- returns 1

insert into person(id, name) values (1,'Curly') on duplicate key update id=1, name='Curly'; 

-- returns 2

insert into person(id, name) values (1,'Curly') on duplicate key update id=1, name='Curly';

-- returns 0

-- -1 is a valid return, when the table is not queried at all

