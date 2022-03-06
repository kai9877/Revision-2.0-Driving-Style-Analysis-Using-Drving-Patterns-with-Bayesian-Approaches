#从FrontTargets表中提取所需要的列，要求 CIPV=1,TargetType=0或1,Status=3。这意味着前车为最近车辆，左前方或右前方并没有车辆干扰行驶，处于跟驰行驶状态。前车为小轿车或者卡车。前车状态为行驶。
#To extract the required columns from the FrontTargets table, CIPV=1, TargetType=0 or 1, and Status=3. This means that the car in front is the closest vehicle, and there is no vehicle interference in the left front or right front, and it is in a state of follow-up driving. The front car is a car or truck. The vehicle in front of the car is in the driving state.
SET UNIQUE_CHECKS = 0;

SET foreign_key_checks = 0;

SET SESSION BULK_INSERT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;

SET SESSION MYISAM_SORT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;
DROP TABLE
IF
	EXISTS step_first;
CREATE TABLE
IF
	NOT EXISTS step_first AS SELECT
	* 
FROM
	`spmd_original`.`front_targets` AS f 
WHERE
	f.CIPV = 1 
	AND ( f.TargetType = 0 OR f.TargetType = 1 ) 
	AND f.STATUS = 3 
ORDER BY
	f.Device,
	f.Trip,
	f.Time,
	f.ObstacleId;