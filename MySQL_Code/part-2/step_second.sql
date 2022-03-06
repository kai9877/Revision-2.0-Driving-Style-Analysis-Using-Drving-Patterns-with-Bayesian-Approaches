#从Wsu表格中提取所需要的列，并且要求所收集的数据中CAN信号必须有效，因为要使用CAN信号中的AxWsu作为加速度研究。
#Extract the required columns from the Wsu table. Require that the CAN signal in the collected data must be valid, as the AxWsu in the CAN signal is used as an acceleration study.
SET UNIQUE_CHECKS = 0;

SET foreign_key_checks = 0;

SET SESSION BULK_INSERT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;

SET SESSION MYISAM_SORT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;
DROP TABLE
IF
	EXISTS step_second;
CREATE TABLE
IF
	NOT EXISTS step_second AS SELECT
	`w`.`Device`,
	`w`.`Trip`,
	`w`.`Time`,
	`w`.`GpsValidWsu`,
	`w`.`GpsSpeedWsu`,
	`w`.`ValidCanWsu`,
	`w`.`SpeedWsu`,
	`w`.`AxWsu` 
FROM
	`spmd_original`.`wsu` AS w 
WHERE
	w.ValidCanWsu = 1;

SET UNIQUE_CHECKS = 1;

SET foreign_key_checks = 1;