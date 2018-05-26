INSERT INTO `projbd`.`edificio` VALUES ('IST');
INSERT INTO `projbd`.`edificio` VALUES ('FEUP');
INSERT INTO `projbd`.`edificio` VALUES ('Catolica');
INSERT INTO `projbd`.`edificio` VALUES ('ISEL');

-- Senhorios
INSERT INTO `projbd`.`user` VALUES ('123456719', 'Jorge Poeta', '992323123');
INSERT INTO `projbd`.`user` VALUES ('113056729', 'António Martins', '992333123');
INSERT INTO `projbd`.`user` VALUES ('133956139', 'David Manuel', '992323124');
INSERT INTO `projbd`.`user` VALUES ('143856248', 'Nuno Sousa', '992323125');
-- Arrendatarios
INSERT INTO `projbd`.`user` VALUES ('153756357', 'Armando Sousa', '992323126');
INSERT INTO `projbd`.`user` VALUES ('163656466', 'Gonçalo Santos', '992323127');
INSERT INTO `projbd`.`user` VALUES ('173516575', 'Alberto Silva', '992323128');
INSERT INTO `projbd`.`user` VALUES ('183426684', 'Rubim Guerreiro', '992323129');
INSERT INTO `projbd`.`user` VALUES ('193336793', 'Anacleto Vieira', '993323123');
INSERT INTO `projbd`.`user` VALUES ('103246782', 'Luis Raposo', '995323123');
INSERT INTO `projbd`.`user` VALUES ('120456781', 'Rui Vitória', '997323123');	

INSERT INTO `projbd`.`fiscal` VALUES (1, 'ASAE');
INSERT INTO `projbd`.`fiscal` VALUES (2, 'CIA');
INSERT INTO `projbd`.`fiscal` VALUES (3, 'PJ');
INSERT INTO `projbd`.`fiscal` VALUES (4, 'FBI');

INSERT INTO `projbd`.`espaco` VALUES ('IST', 'Central');
INSERT INTO `projbd`.`espaco` VALUES ('IST', 'DEI');
INSERT INTO `projbd`.`espaco` VALUES ('IST', 'DEG');
INSERT INTO `projbd`.`espaco` VALUES ('IST', 'DEQ');

INSERT INTO `projbd`.`posto` VALUES ('IST', 'Lab1', 'DEI');
INSERT INTO `projbd`.`posto` VALUES ('IST', 'Lab2', 'DEI');
INSERT INTO `projbd`.`posto` VALUES ('IST', 'Lab3', 'DEI');

INSERT INTO `projbd`.`espaco` VALUES ('FEUP', 'Central');
INSERT INTO `projbd`.`espaco` VALUES ('FEUP', 'DEI');
INSERT INTO `projbd`.`espaco` VALUES ('FEUP', 'DEG');
INSERT INTO `projbd`.`espaco` VALUES ('FEUP', 'DEQ');

INSERT INTO `projbd`.`posto` VALUES ('FEUP', 'Lab1', 'DEG');
INSERT INTO `projbd`.`posto` VALUES ('FEUP', 'Lab2', 'DEG');
INSERT INTO `projbd`.`posto` VALUES ('FEUP', 'Lab3', 'DEG');
INSERT INTO `projbd`.`posto` VALUES ('FEUP', 'Lab4', 'DEG');

INSERT INTO `projbd`.`espaco` VALUES ('Catolica', 'Central');
INSERT INTO `projbd`.`espaco` VALUES ('Catolica', 'DMKT');
INSERT INTO `projbd`.`espaco` VALUES ('Catolica', 'DG');

INSERT INTO `projbd`.`posto` VALUES ('Catolica', 'Sala1', 'DMKT');
INSERT INTO `projbd`.`posto` VALUES ('Catolica', 'Sala2', 'DMKT');

INSERT INTO `projbd`.`espaco` VALUES ('ISEL', 'Central');
INSERT INTO `projbd`.`espaco` VALUES ('ISEL', 'DEI');
INSERT INTO `projbd`.`espaco` VALUES ('ISEL', 'DEG');
INSERT INTO `projbd`.`espaco` VALUES ('ISEL', 'DEQ');

INSERT INTO `projbd`.`oferta` VALUES ('IST', 'Central', '2016-01-01', '2016-01-31', 19.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'Central', '2016-02-01', '2016-02-28', 20.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'Lab1', '2016-02-01', '2016-02-28', 20.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'DEI', '2016-01-01', '2016-01-31', 49.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'DEG', '2016-01-01', '2016-01-31', 39.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'DEQ', '2016-01-01', '2016-01-31', 29.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'DEI', '2016-02-01', '2016-02-28', 49.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'DEG', '2016-02-01', '2016-02-28', 39.99);
INSERT INTO `projbd`.`oferta` VALUES ('IST', 'DEQ', '2016-02-01', '2016-02-28', 29.99);	

INSERT INTO `projbd`.`oferta` VALUES ('FEUP', 'Central', '2016-01-01', '2016-01-31', 23.99);
INSERT INTO `projbd`.`oferta` VALUES ('FEUP', 'DEI', '2016-01-01', '2016-01-31', 32.00);
INSERT INTO `projbd`.`oferta` VALUES ('FEUP', 'Lab1', '2016-01-01', '2016-01-31', 25.00);
INSERT INTO `projbd`.`oferta` VALUES ('FEUP', 'Lab2', '2016-01-01', '2016-01-31', 15.00);
INSERT INTO `projbd`.`oferta` VALUES ('FEUP', 'Lab3', '2016-01-01', '2016-01-31', 15.00);
INSERT INTO `projbd`.`oferta` VALUES ('FEUP', 'Lab4', '2016-01-01', '2016-01-31', 15.00);

INSERT INTO `projbd`.`oferta` VALUES ('Catolica', 'Central', '2016-01-01', '2016-01-31', 17.00);
INSERT INTO `projbd`.`oferta` VALUES ('Catolica', 'Sala1', '2016-01-01', '2016-01-31', 4.00);
INSERT INTO `projbd`.`oferta` VALUES ('Catolica', 'Sala2', '2016-01-01', '2016-01-31', 2.00);
INSERT INTO `projbd`.`oferta` VALUES ('Catolica', 'Central', '2016-02-01', '2016-02-28', 17.00);

INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'Central', '2016-01-01', '2016-01-31', 89.00);
INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'DEI', '2016-01-01', '2016-01-31', 29.00);
INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'DEG', '2016-01-01', '2016-01-31', 49.00);
INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'DEQ', '2016-01-01', '2016-01-31', 29.00);
INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'Central', '2016-02-01', '2016-02-28', 89.00);
INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'DEI', '2016-02-01', '2016-02-28', 29.00);
INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'DEG', '2016-02-01', '2016-02-28', 49.00);
INSERT INTO `projbd`.`oferta` VALUES ('ISEL', 'DEQ', '2016-02-01', '2016-02-28', 29.00);

INSERT INTO `projbd`.`aluga` VALUES ('IST', 'Central', '2016-01-01', '120456781', '2016-1');
INSERT INTO `projbd`.`aluga` VALUES ('IST', 'Central', '2016-02-01', '120456781', '2016-49');
INSERT INTO `projbd`.`aluga` VALUES ('IST', 'Lab1', '2016-02-01', '120456781', '2016-50');
INSERT INTO `projbd`.`aluga` VALUES ('IST', 'DEI', '2016-01-01', '153756357', '2016-2');
INSERT INTO `projbd`.`aluga` VALUES ('IST', 'DEG', '2016-01-01', '163656466', '2016-3');
INSERT INTO `projbd`.`aluga` VALUES ('IST', 'DEQ', '2016-01-01', '163656466', '2016-4');
INSERT INTO `projbd`.`aluga` VALUES ('IST', 'DEI', '2016-02-01', '120456781', '2016-5');

INSERT INTO `projbd`.`aluga` VALUES ('FEUP', 'Central', '2016-01-01', '183426684', '2016-6');
INSERT INTO `projbd`.`aluga` VALUES ('FEUP', 'Lab1', '2016-01-01', '173516575', '2016-7');

INSERT INTO `projbd`.`aluga` VALUES ('Catolica', 'Central', '2016-01-01', '193336793', '2016-8');
INSERT INTO `projbd`.`aluga` VALUES ('Catolica', 'Sala1', '2016-01-01', '103246782', '2016-9');
INSERT INTO `projbd`.`aluga` VALUES ('Catolica', 'Sala2', '2016-01-01', '103246782', '2016-10');

INSERT INTO `projbd`.`aluga` VALUES ('ISEL', 'Central', '2016-01-01', '103246782', '2016-11');
INSERT INTO `projbd`.`aluga` VALUES ('ISEL', 'DEI', '2016-01-01', '103246782', '2016-12');
INSERT INTO `projbd`.`aluga` VALUES ('ISEL', 'Central', '2016-02-01', '103246782', '2016-13');

INSERT INTO `projbd`.`estado` VALUES ('2016-1', '2019-01-01 02:53:21', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-49', '2019-02-01 02:53:21', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-50', '2019-02-01 02:53:21', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-2', '2019-01-01 01:13:15', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-3', '2019-01-01 11:03:22', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-4', '2019-01-01 02:13:23', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-5', '2019-01-01 12:23:21', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-6', '2019-01-01 02:23:33', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-7', '2019-01-02 01:23:03', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-8', '2019-01-01 13:13:14', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-9', '2019-01-01 10:13:46', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-10', '2019-01-01 10:33:17', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-11', '2019-01-01 11:03:15', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-12', '2019-01-01 01:33:19', 'Aceite');
INSERT INTO `projbd`.`estado` VALUES ('2016-13', '2019-02-01 07:15:27', 'Aceite');

INSERT INTO `projbd`.`paga` VALUES ('2016-1', '2020-01-02 10:43:41', 'Cartão Crédito');
INSERT INTO `projbd`.`paga` VALUES ('2016-49', '2020-02-02 10:43:41', 'Cartão Crédito');
-- INSERT INTO `projbd`.`paga` VALUES ('2016-50', '2020-02-02 10:43:41', 'Cartão Crédito');
INSERT INTO `projbd`.`paga` VALUES ('2016-2', '2020-01-02 11:33:25', 'Cartão Crédito');
INSERT INTO `projbd`.`paga` VALUES ('2016-3', '2020-01-02 12:23:42', 'Paypal');
INSERT INTO `projbd`.`paga` VALUES ('2016-4', '2020-01-01 08:43:23', 'Cartão Crédito');
INSERT INTO `projbd`.`paga` VALUES ('2016-6', '2020-01-02 11:53:38', 'Cartão Crédito');
INSERT INTO `projbd`.`paga` VALUES ('2016-7', '2020-01-03 08:33:03', 'Paypal');
INSERT INTO `projbd`.`paga` VALUES ('2016-8', '2020-01-02 19:13:14', 'Cartão Crédito');
INSERT INTO `projbd`.`paga` VALUES ('2016-9', '2020-01-01 18:23:46', 'Paypal');
INSERT INTO `projbd`.`paga` VALUES ('2016-10', '2020-01-02 12:03:37', 'Cartão Crédito');
INSERT INTO `projbd`.`paga` VALUES ('2016-11', '2020-01-01 13:23:25', 'Paypal');
INSERT INTO `projbd`.`paga` VALUES ('2016-13', '2020-02-01 09:21:05', 'Cartão Crédito');

INSERT INTO `projbd`.`arrenda` VALUES ('IST', 'Central', '123456719');
INSERT INTO `projbd`.`arrenda` VALUES ('IST', 'DEI', '123456719');
INSERT INTO `projbd`.`arrenda` VALUES ('IST', 'Lab1', '123456719');
INSERT INTO `projbd`.`arrenda` VALUES ('IST', 'Lab2', '123456719');
INSERT INTO `projbd`.`arrenda` VALUES ('IST', 'Lab3', '123456719');
INSERT INTO `projbd`.`arrenda` VALUES ('IST', 'DEG', '123456719');
INSERT INTO `projbd`.`arrenda` VALUES ('IST', 'DEQ', '123456719');

INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'Central', '113056729');
INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'DEI', '113056729');
INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'DEG', '113056729');
INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'DEQ', '113056729');
INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'Lab1', '113056729');
INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'Lab2', '113056729');
INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'Lab3', '113056729');
INSERT INTO `projbd`.`arrenda` VALUES ('FEUP', 'Lab4', '113056729');

INSERT INTO `projbd`.`arrenda` VALUES ('Catolica', 'Central', '133956139');
INSERT INTO `projbd`.`arrenda` VALUES ('Catolica', 'DMKT', '133956139');
INSERT INTO `projbd`.`arrenda` VALUES ('Catolica', 'Sala1', '133956139');
INSERT INTO `projbd`.`arrenda` VALUES ('Catolica', 'Sala2', '133956139');
INSERT INTO `projbd`.`arrenda` VALUES ('Catolica', 'DG', '133956139');

INSERT INTO `projbd`.`arrenda` VALUES ('ISEL', 'Central', '143856248');
INSERT INTO `projbd`.`arrenda` VALUES ('ISEL', 'DEI', '143856248');
INSERT INTO `projbd`.`arrenda` VALUES ('ISEL', 'DEG', '143856248');
INSERT INTO `projbd`.`arrenda` VALUES ('ISEL', 'DEQ', '143856248');

INSERT INTO `projbd`.`fiscaliza` VALUES (1, 'IST', 'Central');
INSERT INTO `projbd`.`fiscaliza` VALUES (1, 'IST', 'DEI');
INSERT INTO `projbd`.`fiscaliza` VALUES (1, 'IST', 'Lab1');
INSERT INTO `projbd`.`fiscaliza` VALUES (1, 'FEUP', 'Central');
INSERT INTO `projbd`.`fiscaliza` VALUES (2, 'FEUP', 'Central');
INSERT INTO `projbd`.`fiscaliza` VALUES (2, 'FEUP', 'DEQ');
INSERT INTO `projbd`.`fiscaliza` VALUES (3, 'FEUP', 'DEI');
INSERT INTO `projbd`.`fiscaliza` VALUES (4, 'Catolica', 'Central');
INSERT INTO `projbd`.`fiscaliza` VALUES (2, 'Catolica', 'DG');