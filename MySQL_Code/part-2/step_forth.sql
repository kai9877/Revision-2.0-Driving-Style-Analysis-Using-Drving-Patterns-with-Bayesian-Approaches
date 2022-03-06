#按照规则，划分出跟车事件。此时，先不考虑跟驰时间。将每行与上一行的Device,Trip,ObstacleId对比，判断车辆是否仍然处于跟驰状态中。如有三者中有任意一个变化，则选择前者，即事件数不发生变化。反之，事件数加一。在此之后，按照相对距离range小于120，大于5；并且跟驰车辆速度要求不得低于18km/h挑选出符合条件的事件。
#According to the rules, divide the following events. At this point, don't consider the timing. Compare each row with the Device, Trip, obstacleIds on the previous row to determine if the vehicle is still in a heeling state. If there is a change in any of the three, the former is selected, that is, the number of events does not change. Conversely, the number of events is multiplied by one. After this, the qualifying events shall be selected according to the relative distance range of less than 120 and greater than 5; and the speed requirements of the follow-up vehicle shall not be less than 18km/h.
SET UNIQUE_CHECKS = 0;

SET foreign_key_checks = 0;

SET SESSION BULK_INSERT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;

SET SESSION MYISAM_SORT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;
DROP TABLE
IF
	EXISTS step_forth;

SET @num := 0;

SET @Device := 0;

SET @Trip := 0;

SET @ObstacleId := 0;

set @Time:=0;
CREATE TABLE
IF
	NOT EXISTS step_forth AS SELECT
	@num :=
IF
	(
		@Device = t.Device 
		AND @Trip = t.Trip 
		AND @ObstacleId = t.ObstacleId
		and @Time=t.Time-10,
		@num,
		@num + 1 
	) AS eventNum,
	#函数function(条件,A值,B值)，若条件成立，则返回值A；条件不成立，返回值B。
	#Functions function (condition, A, B), if the condition is true, returns the value A; if the condition is not true, returns the value B.
	@Device := `t`.`Device` AS eventDevice,
	@Trip := `t`.`Trip` AS eventTrip,
	@ObstacleId := `t`.`ObstacleId` AS eventOId,
	@Time:=`t`.`Time` as eventTime,
	`t`.`Range`,
	`t`.`Rangerate`,
	`t`.`SpeedWsu`,
	`t`.`AxWsu` 
FROM
	step_third AS t 
WHERE
	`t`.`Range` >= 5 
	AND `t`.`Range` <= 120 
	AND `t`.`SpeedWsu` >= 18 
ORDER BY
	eventNum,
	eventDevice,
	eventTrip,
	eventTime,
	eventOId;

SET UNIQUE_CHECKS = 1;

SET foreign_key_checks = 1;