
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

---------------------------------------------------------------------------------------

I have inserted 4 rows into the db, and got the right response as 1.

INFO  2015-02-20 12:18:17,338 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=1, Name=Curly}
INFO  2015-02-20 12:18:18,022 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:18:18,031 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=2, Name=Larry}
INFO  2015-02-20 12:18:18,089 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:18:18,090 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=3, Name=Moe}
INFO  2015-02-20 12:18:18,149 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:18:18,150 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=4, Name=Shemp}
INFO  2015-02-20 12:18:18,300 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1

I tried with the same dataset THE SECOND TIME and I should have received 0. However, I got a 1 from logs

INFO  2015-02-20 12:04:12,664 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=1, Name=Curly}
INFO  2015-02-20 12:04:13,635 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:04:13,691 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=2, Name=Larry}
INFO  2015-02-20 12:04:13,735 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:04:13,736 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=3, Name=Moe}
INFO  2015-02-20 12:04:13,777 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:04:13,778 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=4, Name=Shemp}
INFO  2015-02-20 12:04:13,822 [batch-job-example-upsertBatch-work-manager.08] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1



-----------------------------------------------------------------------------------------------

I updated the dataset to edit the name for the 4th , which got updated and returned a 2. The error is that the code does not return 
the difference between a new row and a row that was never updated ( i never get a 0 )

INFO  2015-02-20 12:25:03,528 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=1, Name=Curly}
INFO  2015-02-20 12:25:03,554 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:25:03,555 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=2, Name=Larry}
INFO  2015-02-20 12:25:03,580 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:25:03,581 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=3, Name=Moe}
INFO  2015-02-20 12:25:03,601 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:25:03,602 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=4, Name=Joe}
INFO  2015-02-20 12:25:03,655 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 2
INFO  2015-02-20 12:25:03,657 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=5, Name=Curly Joe}
INFO  2015-02-20 12:25:03,720 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
INFO  2015-02-20 12:25:03,721 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: in B.S.1 {Id=6, Name=Shemp}
INFO  2015-02-20 12:25:03,763 [batch-job-example-upsertBatch-work-manager.03] org.mule.api.processor.LoggerMessageProcessor: Affected-Rows / UpdatedCount : 1
