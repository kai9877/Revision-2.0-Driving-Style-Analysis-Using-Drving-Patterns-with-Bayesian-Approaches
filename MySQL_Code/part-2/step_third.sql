#将第一二步所得表格整合在一起。
#Get tables that we've got earlier unioned up.

SET UNIQUE_CHECKS = 0;

SET foreign_key_checks = 0;

SET SESSION BULK_INSERT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;

SET SESSION MYISAM_SORT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;
DROP TABLE
IF
	EXISTS step_third;
CREATE TABLE
IF
	NOT EXISTS step_third AS SELECT
	`f`.`Device`,
	`f`.`Trip`,
	`f`.`Time`,
	`f`.`ObstacleId`,
	`f`.`Range`,
	`f`.`Rangerate`,
	`s`.`SpeedWsu`,
	`s`.`AxWsu`
FROM
	step_first as f
	JOIN step_second AS s ON f.Device = s.Device 
	AND f.Trip = s.Trip 
	AND f.Time = s.Time 
ORDER BY
	f.Device,
	f.Trip,
	f.Time,
	f.ObstacleId;

SET UNIQUE_CHECKS = 1;

SET foreign_key_checks = 1;