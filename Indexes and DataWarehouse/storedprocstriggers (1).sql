DROP TRIGGER IF EXISTS `projbd`.`adicionar_oferta`;
DROP TRIGGER IF EXISTS `projbd`.`remover_oferta`;
DROP TRIGGER IF EXISTS `projbd`.`pagar_reserva`;
DROP TRIGGER IF EXISTS `projbd`.`remover_posto`;
DROP TRIGGER IF EXISTS `projbd`.`adicionar_posto`;
DROP TRIGGER IF EXISTS `projbd`.`remover_espaco_before`;
DROP TRIGGER IF EXISTS `projbd`.`remover_espaco_after`;
DROP TRIGGER IF EXISTS `projbd`.`adicionar_espaco`;
DROP TRIGGER IF EXISTS `projbd`.`remover_edificio`;
DROP TRIGGER IF EXISTS `projbd`.`remover_alugavel`;
DROP TRIGGER IF EXISTS `projbd`.`criar_reserva`;
DROP TRIGGER IF EXISTS `projbd`.`criar_aluga`;
DROP TRIGGER IF EXISTS `projbd`.`adicionar_estado`;

DELIMITER $$
-- -----------------------------------------------------------------------------------------------------------------
-- R01 - Nao podem existir ofertas com datas sobrepostas
-- Remover ofertas
-- -----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER `adicionar_oferta` BEFORE INSERT ON `projbd`.`oferta`
	FOR EACH ROW
		BEGIN
			DECLARE beginDate TIMESTAMP;
            DECLARE endDate TIMESTAMP;
			DECLARE done INT DEFAULT FALSE;
			DECLARE cur CURSOR FOR 
				SELECT `data_inicio`, `data_fim` 
				FROM `projbd`.`oferta` 
				WHERE `morada` LIKE NEW.`morada` 
					AND `codigo` LIKE NEW.`codigo`;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
                    
			OPEN cur;
				dateLoop: LOOP
					FETCH cur INTO beginDate, endDate;
                
					IF done THEN
						LEAVE dateLoop;
					END IF;
                
					IF NEW.`data_inicio` >= beginDate AND NEW.`data_inicio` <= endDate 
						OR NEW.`data_inicio` <= beginDate AND NEW.`data_fim` <= endDate AND NEW.`data_fim` >= beginDate 
						OR NEW.`data_inicio` <= beginDate AND NEW.`data_fim` >= endDate THEN
							SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ja existe uma oferta para o periodo escolhido.';
					END IF;
						
				END LOOP;
			CLOSE cur;
            
			IF NEW.`data_inicio` > NEW.`data_fim` THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de termino anterior a de inicio.';
			END IF;
		END; 
 $$
 
CREATE TRIGGER `remover_oferta` BEFORE DELETE ON `projbd`.`oferta`
	FOR EACH ROW 
		BEGIN
			DELETE FROM `projbd`.`aluga` WHERE `morada` LIKE OLD.`morada` AND `codigo` LIKE OLD.`codigo` AND `data_inicio` LIKE OLD.`data_inicio`; 
        END;
$$
 
-- -----------------------------------------------------------------------------------------------------------------
-- R02 - A data de pagamento de uma reserva paga tem de ser superior ao timestamp do ultimo estado dessa reserva
-- Pagamento de reserva
-- ----------------------------------------------------------------------------------------------------------------- 
CREATE TRIGGER `pagar_reserva` BEFORE INSERT ON `projbd`.`paga` 
	FOR EACH ROW
		BEGIN
			DECLARE maxTimestamp TIMESTAMP;
            DECLARE lastState VARCHAR(255);

            SET maxTimestamp = (SELECT MAX(`timestamp`) FROM `projbd`.`estado` WHERE `numero` = NEW.`numero`);
			SET lastState = (SELECT `estado` FROM `projbd`.`estado` WHERE `numero` LIKE NEW.`numero` AND `timestamp` LIKE maxTimeStamp);
            
            IF NEW.`data` <= maxTimeStamp THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ultima alteracao de estado posterior ao tempo actual.';
			ELSEIF NOT lastState = 'Aceite' THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Reserva ainda nao foi aceite.';
			END IF;
        END;
$$ 
  
-- -----------------------------------------------------------------------------------------------------------------
-- Propagacao de remocao/adicao de posto
-- -----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER `remover_posto` AFTER DELETE ON `projbd`.`posto`
	FOR EACH ROW 
		BEGIN
			DELETE FROM `projbd`.`alugavel` WHERE `morada` LIKE OLD.`morada` AND `codigo` LIKE OLD.`codigo`;
		END;
$$
            
CREATE TRIGGER `adicionar_posto` BEFORE INSERT ON `projbd`.`posto`
	FOR EACH ROW 
		BEGIN
			INSERT INTO `projbd`.`alugavel` VALUES(NEW.`morada`, NEW.`codigo`, 'foto url');
        END;
$$
            
-- -----------------------------------------------------------------------------------------------------------------
-- Propagacao de remocao de espaco
-- -----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER `remover_espaco_before` BEFORE DELETE ON `projbd`.`espaco`
	FOR EACH ROW 
		BEGIN
			DELETE FROM `projbd`.`posto` WHERE `morada` LIKE OLD.`morada` AND `codigo_espaco` LIKE OLD.`codigo`;
		END;
$$
        
CREATE TRIGGER `remover_espaco_after` AFTER DELETE ON `projbd`.`espaco`
	FOR EACH ROW 
		BEGIN
			DELETE FROM `projbd`.`alugavel` WHERE `morada` LIKE OLD.`morada` AND `codigo` LIKE OLD.`codigo`;    
		END;
$$
            
CREATE TRIGGER `adicionar_espaco` BEFORE INSERT ON `projbd`.`espaco`
	FOR EACH ROW
		BEGIN
			INSERT INTO `projbd`.`alugavel` VALUES(NEW.`morada`, NEW.`codigo`, 'foto url');
		END;
$$
            
-- -----------------------------------------------------------------------------------------------------------------
-- Propagacao de remocao de edificio
-- -----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER `remover_edificio` BEFORE DELETE ON `projbd`.`edificio`
	FOR EACH ROW 
		BEGIN
			DELETE FROM `projbd`.`espaco` WHERE `morada` LIKE OLD.`morada`; 	
		END;
$$

-- -----------------------------------------------------------------------------------------------------------------
-- Propagacao de remocao de alugavel
-- -----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER `remover_alugavel` BEFORE DELETE ON `projbd`.`alugavel`
	FOR EACH ROW 
		BEGIN
			DELETE FROM `projbd`.`oferta` WHERE `morada` LIKE OLD.`morada` AND `codigo` LIKE OLD.`codigo`; 	
		END;
$$ 
        
-- -----------------------------------------------------------------------------------------------------------------
-- Propagacao de criacao de reserva
-- -----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER `criar_reserva` AFTER INSERT ON `projbd`.`reserva`
	FOR EACH ROW 
		BEGIN
			INSERT INTO `projbd`.`estado` VALUES(NEW.`numero`, (SELECT NOW()), 'Pendente');  
		END;
$$

CREATE TRIGGER `criar_aluga` BEFORE INSERT ON `projbd`.`aluga`
	FOR EACH ROW
		BEGIN
			INSERT INTO `projbd`.`reserva` VALUES(NEW.`numero`);
        END;
$$

-- -----------------------------------------------------------------------------------------------------------------
-- Propagacao de criacao/remocao de estado
-- -----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER `adicionar_estado` BEFORE INSERT ON `projbd`.`estado`
	FOR EACH ROW 
		BEGIN
			DECLARE state VARCHAR(255);
			DECLARE done INT DEFAULT FALSE;
			DECLARE cur CURSOR FOR 
				SELECT `estado` 
				FROM `projbd`.`estado` 
				WHERE `numero` LIKE NEW.`numero`;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
                    
			OPEN cur;
				dateLoop: LOOP
					FETCH cur INTO state;
                
					IF done THEN
						LEAVE dateLoop;
					END IF;
                
					IF NEW.`estado` = 'Aceite' AND state = 'Aceite' THEN 
						SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ja existe uma reserva aceite para oferta escolhida.';
					END IF;
						
				END LOOP;
			CLOSE cur;
        END;
$$
DELIMITER ; $$