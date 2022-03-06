
SET UNIQUE_CHECKS = 0;

SET foreign_key_checks = 0;

SET SESSION BULK_INSERT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;

SET SESSION MYISAM_SORT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;
DROP TABLE
IF
	EXISTS step_seventh;

SET @num := 0;

SET @Device := 0;

set @ori_num :=0;

SET @Trip := 0;

SET @ObstacleId := 0;
CREATE TABLE
IF
	NOT EXISTS step_seventh AS SELECT
	@num :=
IF
	(
		@ori_num=`o`.`eventNum`
		and @Device = `o`.`eventDevice` 
		AND @Trip = `o`.`eventTrip` 
		AND @ObstacleId = `o`.`eventOId`,
		@num,
		@num + 1 
	) AS finalNum,
	@ori_num := `o`.`eventNum` as eventNum,
	@ObstacleId := `o`.`eventOId` AS finalOId,
	@Device := `o`.`eventDevice` AS finalDevice,
	@Trip := `o`.`eventTrip` AS finalTrip,
	`o`.`eventTime`,
	`o`.`Range`,
	`o`.`Rangerate`,
	`o`.`SpeedWsu`,
	`o`.`AxWsu` 
FROM
	`step_sixth` AS s
	JOIN step_forth AS o
	join step_fifth as f 
	ON s.eventDevice = o.eventDevice and f.eventNum=o.eventNum
ORDER BY
	finalNum,
	`o`.`eventTime`;

SET UNIQUE_CHECKS = 1;

SET foreign_key_checks = 1;