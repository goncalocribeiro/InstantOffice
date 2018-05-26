-- -----------------------------------------------------
-- Schema projbd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projbd` DEFAULT CHARACTER SET utf8 ;
USE `projbd`;

DROP TABLE IF EXISTS `projbd`.`estado`;
DROP TABLE IF EXISTS `projbd`.`paga`;
DROP TABLE IF EXISTS `projbd`.`aluga`;
DROP TABLE IF EXISTS `projbd`.`reserva`;
DROP TABLE IF EXISTS `projbd`.`oferta`;
DROP TABLE IF EXISTS `projbd`.`posto`;
DROP TABLE IF EXISTS `projbd`.`espaco`;
DROP TABLE IF EXISTS `projbd`.`fiscaliza`;
DROP TABLE IF EXISTS `projbd`.`arrenda`;
DROP TABLE IF EXISTS `projbd`.`alugavel`;
DROP TABLE IF EXISTS `projbd`.`edificio`;
DROP TABLE IF EXISTS `projbd`.`fiscal`;
DROP TABLE IF EXISTS `projbd`.`user`;

-- -----------------------------------------------------
-- Table `projbd`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`user` (
	`nif` VARCHAR(9) NOT NULL UNIQUE,
	`nome` VARCHAR(80) NOT NULL,
	`telefone` VARCHAR(26) NOT NULL,
	PRIMARY KEY (`nif`)
);

-- -----------------------------------------------------
-- Table `projbd`.`fiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`fiscal` (
	`id` INT NOT NULL UNIQUE,
	`empresa` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `projbd`.`edificio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`edificio` (
  `morada` VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (`morada`)
);

-- -----------------------------------------------------
-- Table `projbd`.`alugavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`alugavel` (
	`morada` VARCHAR(255) NOT NULL,
	`codigo` VARCHAR(255) NOT NULL,
	`foto` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`morada`, `codigo`),
	FOREIGN KEY (`morada`) 
		REFERENCES `projbd`.`edificio` (`morada`)    
);

-- -----------------------------------------------------
-- Table `projbd`.`arrenda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`arrenda` (
    `morada` VARCHAR(255) NOT NULL,
	`codigo` VARCHAR(255) NOT NULL,
	`nif` VARCHAR(9) NOT NULL,
	PRIMARY KEY (`morada`, `codigo`),
	FOREIGN KEY (`nif`)
		REFERENCES `projbd`.`user` (`nif`),
	FOREIGN KEY (`morada` , `codigo`)
		REFERENCES `projbd`.`alugavel` (`morada` , `codigo`)
);

-- -----------------------------------------------------
-- Table `projbd`.`fiscaliza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`fiscaliza` (
	`id` INT NOT NULL,
    `morada` VARCHAR(255) NOT NULL,
	`codigo` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id`, `morada`, `codigo`),
	FOREIGN KEY (`morada` , `codigo`)
		REFERENCES `projbd`.`alugavel` (`morada` , `codigo`),
	FOREIGN KEY (`id`)
		REFERENCES `projbd`.`fiscal` (`id`)
);

-- -----------------------------------------------------
-- Table `projbd`.`espaco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`espaco` (
	`morada` VARCHAR(255) NOT NULL,
	`codigo` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`morada`, `codigo`),
	FOREIGN KEY (`morada` , `codigo`)
		REFERENCES `projbd`.`alugavel` (`morada` , `codigo`)
);

-- -----------------------------------------------------
-- Table `projbd`.`posto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`posto` (
	`morada` VARCHAR(255) NOT NULL,
	`codigo` VARCHAR(255) NOT NULL,
	`codigo_espaco` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`morada`, `codigo`),
	FOREIGN KEY (`morada` , `codigo`)
		REFERENCES `projbd`.`alugavel` (`morada`, `codigo`),
	FOREIGN KEY (`morada`, `codigo_espaco`)
		REFERENCES `projbd`.`espaco` (`morada`, `codigo`)
);

-- -----------------------------------------------------
-- Table `projbd`.`oferta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`oferta` (
	`morada` VARCHAR(255) NOT NULL,
    `codigo` VARCHAR(255) NOT NULL,
	`data_inicio` DATE NOT NULL,
	`data_fim` DATE NULL,
	`tarifa` NUMERIC(19, 4) NOT NULL,
	PRIMARY KEY (`morada`, `codigo`, `data_inicio`),
	FOREIGN KEY (`morada` , `codigo`)
		REFERENCES `projbd`.`alugavel` (`morada` , `codigo`)
);

-- -----------------------------------------------------
-- Table `projbd`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`reserva` (
  `numero` VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (`numero`)
);

-- -----------------------------------------------------
-- Table `projbd`.`aluga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`aluga` (
	`morada` VARCHAR(255) NOT NULL,
	`codigo` VARCHAR(255) NOT NULL,
	`data_inicio` DATE NOT NULL,
	`nif` VARCHAR(9) NOT NULL,
	`numero` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`morada`, `codigo`, `data_inicio`, `nif`, `numero`),
	FOREIGN KEY (`morada` , `codigo` , `data_inicio`)
		REFERENCES `projbd`.`oferta` (`morada` , `codigo` , `data_inicio`),
	FOREIGN KEY (`nif`)
		REFERENCES `projbd`.`user` (`nif`),
	FOREIGN KEY (`numero`)
		REFERENCES `projbd`.`reserva` (`numero`)
);

-- -----------------------------------------------------
-- Table `projbd`.`paga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`paga` (
	`numero` VARCHAR(255) NOT NULL UNIQUE,
	`data` TIMESTAMP NOT NULL,
	`metodo` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`numero`),
	FOREIGN KEY (`numero`)
		REFERENCES `projbd`.`reserva` (`numero`)
);

-- -----------------------------------------------------
-- Table `projbd`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projbd`.`estado` (
	`numero` VARCHAR(255) NOT NULL,
	`timestamp` TIMESTAMP NOT NULL,
	`estado` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`numero`, `timestamp`),
	FOREIGN KEY (`numero`)
		REFERENCES `projbd`.`reserva` (`numero`)
);

