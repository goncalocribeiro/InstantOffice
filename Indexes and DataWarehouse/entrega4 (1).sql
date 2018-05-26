DROP TABLE IF EXISTS  `projbd`.`facts`;
DROP TABLE IF EXISTS  `projbd`.`dim_date`;
DROP TABLE IF EXISTS  `projbd`.`dim_time`;
DROP TABLE IF EXISTS  `projbd`.`dim_user`;
DROP TABLE IF EXISTS  `projbd`.`dim_location`;

DROP PROCEDURE IF EXISTS fillDates;
DROP PROCEDURE IF EXISTS fillTimes;
DROP PROCEDURE IF EXISTS fillLocations;
DROP PROCEDURE IF EXISTS fillFacts;

DROP FUNCTION IF EXISTS calcAverage;

CREATE TABLE IF NOT EXISTS `projbd`.`dim_date` (
	`id` INT NOT NULL UNIQUE AUTO_INCREMENT,
	`day` INT NOT NULL,
    `month` INT NOT NULL,
    `year` INT NOT NULL,
    `week` INT NOT NULL,
    `semester` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `projbd`.`dim_time` (
	`id` INT NOT NULL UNIQUE AUTO_INCREMENT, 
	`hour` INT NOT NULL,
    `minute` INT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `projbd`.`dim_user` (
	`id` INT NOT NULL UNIQUE AUTO_INCREMENT,
	`nif` VARCHAR(9) NOT NULL UNIQUE,
    PRIMARY KEY (`id`)
    ) AS 
	SELECT `nif` 
    FROM `projbd`.`user`;
    
        
CREATE TABLE IF NOT EXISTS `projbd`.`dim_location` (
	`id` INT NOT NULL UNIQUE AUTO_INCREMENT,
	`edificio` VARCHAR(255) NOT NULL,
    `espaco` VARCHAR(255) NOT NULL,
    `posto` VARCHAR(255) NOT NULL,
    PRIMARY KEY(`id`)
);

CREATE TABLE IF NOT EXISTS `projbd`.`facts` (
	`id` INT UNIQUE NOT NULL AUTO_INCREMENT,
	`uid` INT NOT NULL,
    `lid` INT NOT NULL,
    `tid`INT NOT NULL,
    `did` INT NOT NULL,
    `paid` NUMERIC(19, 4) NOT NULL,
    `leaseTime` INT NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`uid`)
		REFERENCES `projbd`.`dim_user` (`id`),
	FOREIGN KEY (`lid`)
		REFERENCES `projbd`.`dim_location` (`id`),
	FOREIGN KEY (`tid`)
		REFERENCES `projbd`.`dim_time` (`id`),
	FOREIGN KEY (`did`)
		REFERENCES `projbd`.`dim_date` (`id`)
);

DELIMITER $
CREATE PROCEDURE fillDates(dateStart DATE, dateEnd DATE)
BEGIN
	DECLARE semesterNum INT;
    DECLARE weekNum INT;
    DECLARE cnt INT;

	WHILE dateStart <= dateEnd DO
		IF MONTH(dateStart) = 1 AND DAY(dateStart) = 1 THEN
			SET cnt = 0;
            SET weekNum = 1;
		END IF;
    
		IF cnt > 0 AND cnt % 7 = 0 THEN
			SET weekNum = weekNum + 1;
		END IF;
    
		IF(MONTH(dateStart) < 7) THEN 
			SET semesterNum = 1;
		ELSE
			SET semesterNum = 2;
		END IF;
        
		INSERT INTO `projbd`.`dim_date` (`day`, `month`, `year`, `week`, `semester`) VALUES (DAY(dateStart), MONTH(dateStart), YEAR(dateStart), weekNum, semesterNum);
		SET dateStart = date_add(dateStart, INTERVAL 1 DAY);

		SET cnt = cnt + 1;
	END WHILE;
END;
$

CREATE PROCEDURE fillTimes(timeStart DATETIME, timeEnd DATETIME)
BEGIN
	WHILE timeStart <= timeEnd DO
		INSERT INTO `projbd`.`dim_time` (`hour`, `minute`) VALUES (HOUR(timeStart), MINUTE(timeStart));
		SET timeStart = date_add(timeStart, INTERVAL 1 MINUTE);
	END WHILE;
END;
$

CREATE PROCEDURE fillLocations()
BEGIN
	INSERT INTO `projbd`.`dim_location` (`edificio`, `espaco`, `posto`)
    SELECT `morada`, `codigo`, `codigo`
    FROM `projbd`.`espaco`;
    
    INSERT INTO `projbd`.`dim_location` (`edificio`, `espaco`, `posto`)
    SELECT `morada`, `codigo_espaco`, `codigo`
    FROM `projbd`.`posto`;
END;
$

CREATE PROCEDURE fillFacts()
BEGIN
	DECLARE num VARCHAR(255);
	DECLARE address VARCHAR(255);
    DECLARE identifier VARCHAR(255);
    DECLARE startDate TIMESTAMP;
    DECLARE endDate TIMESTAMP;
    DECLARE price NUMERIC(19, 4);
    DECLARE nif VARCHAR(9);
    DECLARE payDate TIMESTAMP;
    DECLARE method VARCHAR(255);
    
    DECLARE uid INT;
    DECLARE lid INT;
    DECLARE tid INT;
    DECLARE did INT;
    DECLARE leaseTime INT;
    
	DECLARE done INT DEFAULT FALSE;
	DECLARE cur CURSOR FOR 
		SELECT *
		FROM `projbd`.`oferta` NATURAL JOIN `projbd`.`aluga` NATURAL JOIN `projbd`.`paga`;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
                    
	OPEN cur;
		dateLoop: LOOP
			FETCH cur INTO num, address, identifier, startDate, endDate, price, nif, payDate, method;
                
			IF done THEN
				LEAVE dateLoop;
			END IF;
            
            SET uid = (SELECT du.`id` FROM `dim_user` du WHERE du.`nif` = nif);
            SET lid = (SELECT dl.`id` FROM `dim_location` dl WHERE dl.`edificio` = address AND ((dl.`espaco` = identifier AND dl.`posto` = identifier) OR (dl.`espaco` != identifier AND dl.`posto` = identifier)));
			SET tid = (SELECT dt.`id` FROM `dim_time` dt WHERE dt.`hour` = HOUR(payDate) AND dt.`minute` = MINUTE(payDate));
			SET did = (SELECT dd.`id` FROM `dim_date` dd WHERE dd.`day` = DAY(payDate) AND dd.`month` = MONTH(payDate) AND dd.`year` = YEAR(payDate));
            SET leaseTime = datediff(endDate, startDate);
			SET price = leaseTime * price;
            
            INSERT INTO `projbd`.`facts` (`uid`, `lid`, `tid`, `did`, `paid`, `leaseTime`)
            VALUES (uid, lid, tid, did, price, leaseTime);
		END LOOP;
	CLOSE cur;
END;
$

CREATE FUNCTION calcAverage (location INT, endDate INT) RETURNS DECIMAL(19, 4)
	BEGIN
		DECLARE done INT DEFAULT FALSE;
		DECLARE newDate INT;
        DECLARE cnt DECIMAL(19, 4) DEFAULT 0;
		DECLARE val DECIMAL(19, 4);
        DECLARE average DECIMAL(19, 4) DEFAULT 0;
		DECLARE cur CURSOR FOR
			SELECT paid, did
			FROM facts
            WHERE lid = location;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
        
        OPEN cur;
			fetchLoop: LOOP
				FETCH cur INTO val, newDate;
				
                IF done THEN
					LEAVE fetchLoop;
				END IF;
                
                IF newDate <= endDate THEN
					SET average = average + val;
					SET cnt = cnt + 1;
                END IF;
			END LOOP;
		CLOSE cur;
        
        RETURN average / cnt;
	END;
$

DELIMITER ;

CALL fillDates('2016-01-01','2017-12-31');
CALL fillTimes('1970-01-01 00:00:00', '1970-01-01 23:59:59');
CALL fillLocations();
CALL fillFacts();

SET @sql = NULL;
SELECT 
	GROUP_CONCAT(DISTINCT CONCAT(
		"CASE WHEN did = \"",
        did,
        "\" THEN paid
        ELSE calcAverage(f.lid, ", did, ") 
        END AS `", (SELECT DATE(concat(d.year, "-", d.month, "-", d.day)) FROM dim_date d WHERE d.id = did), "`")
		) INTO @sql
FROM facts;

SET @sql = concat("SELECT CASE WHEN l.espaco = l.posto THEN concat(l.edificio, \" - \", l.espaco) ELSE concat(l.edificio, \" - \", l.espaco, \" - \", l.posto) END AS location, ", @sql, " 
				FROM facts f 
				INNER JOIN dim_location l ON f.lid = l.id
                INNER JOIN dim_date d ON f.did = d.id
                GROUP BY lid;");

SELECT @sql;
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
