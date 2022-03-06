#做一个粗略的统计，有多少条有效的跟驰数据。
#Do a rough statistic about how many valid pieces of car-following data are in forth table.
SET UNIQUE_CHECKS = 0;

SET foreign_key_checks = 0;

SET SESSION BULK_INSERT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;

SET SESSION MYISAM_SORT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;
DROP TABLE
IF
	EXISTS step_sixth;
CREATE TABLE
IF
	NOT EXISTS step_sixth AS SELECT
	eventDevice,count(*)
FROM
	step_fifth 
GROUP BY
	eventDevice
having 
count(*)>=50;

SET UNIQUE_CHECKS = 1;

SET foreign_key_checks = 1;