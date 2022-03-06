DROP TABLE
IF
	EXISTS front_targets;
DROP TABLE
IF
	EXISTS wsu;

SET UNIQUE_CHECKS = 0;

SET foreign_key_checks = 0;
set global local_infile=on;
SET SESSION BULK_INSERT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;

SET SESSION MYISAM_SORT_BUFFER_SIZE = 1024 * 1024 * 1024 * 5;
CREATE TABLE
IF
	NOT EXISTS front_targets (
		`Device` int(255) NOT NULL,
		`Trip` int(255) NOT NULL,
		`Time` int(255) NOT NULL,
		`TargetId` varchar(255) NOT NULL,
		`ObstacleId` varchar(255) NOT NULL,
		`Range` varchar(255) NOT NULL,
		`Rangerate` varchar(255) NOT NULL,
		`Transversal` varchar(255) NOT NULL,
		`TargetType` varchar(255) NOT NULL,
		`Status` tinyint(255) NOT NULL,
		`CIPV` tinyint(255) NOT NULL 
	) engine=myisam;
CREATE TABLE
IF
	NOT EXISTS wsu (
		`Device` int(255) NOT NULL,
		`Trip` int(255) NOT NULL,
		`Time` int(255) NOT NULL,
		`GpsValidWsu` varchar(255) NOT NULL,
		`GpsTimeWsu` varchar(255) NOT NULL,
		`LatitudeWsu` varchar(255) NOT NULL,
		`LongtitudeWsu` varchar(255) NOT NULL,
		`AltitudeWsu` varchar(255) NOT NULL,
		`GpsHeadingWsu` varchar(255) NOT NULL,
		`GpsSpeedWsu` varchar(255) NOT NULL,
		`HdopWsu` varchar(255) NOT NULL,
		`PdopWsu` varchar(255) NOT NULL,
		`FixQualityWsu` varchar(255) NOT NULL,
		`GpsCoastingWsu` varchar(255) NOT NULL,
		`ValidCanWsu` varchar(255) NOT NULL,
		`YawRateWsu` varchar(255) NOT NULL,
		`SpeedWsu` varchar(255) NOT NULL,
		`TurnSngRWsu` varchar(255) NOT NULL,
		`TurnSngLWsu` varchar(255) NOT NULL,
		`BrakeAbsTcsWsu` varchar(255) NOT NULL,
		`AxWsu` varchar(255) NOT NULL,
		`PrndlWsu` varchar(255) NOT NULL,
		`VsaActiveWsu` varchar(255) NOT NULL,
		`HeadLampWsu` varchar(255) NOT NULL,
		`WiperWsu` varchar(255) NOT NULL,
		`ThrottleWsu` varchar(255) NOT NULL,
		`SteerWsu` varchar(255) NOT NULL 
	) engine=myisam;
LOAD DATA LOCAL INFILE 'F:/learning_document/bachelor_graduation_new/original_data/DataFrontTargets.csv' INTO TABLE front_targets FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
LOAD DATA LOCAL INFILE 'F:/learning_document/bachelor_graduation_new/original_data/DataWsu.csv' INTO TABLE wsu FIELDS TERMINATED BY ',' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

SET foreign_key_checks = 1;

SET unique_checks = 1;