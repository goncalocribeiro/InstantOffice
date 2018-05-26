CREATE TABLE user 
	(nif 			integer 		not null unique,
	 nome 			varchar(255)	not null,
	 telefone 		integer,		not null,
	 PRIMARY KEY(nif));
	 
CREATE TABLE fiscal
	(id 			integer			not null unique,
	 empresa		varchar(255)	not null,
	 PRIMARY KEY(id));
	 
CREATE TABLE edificio
	(morada			varchar(255)	not null,
	 PRIMARY KEY(morada));
	
CREATE TABLE alugavel
	(morada			varchar(255)	not null,
	 codigo			integer			not null unique,
	 foto			varchar(255),
	 PRIMARY KEY(codigo),
	 FOREIGN KEY(morada) 		REFERENCES edificio(morada));
	 
CREATE TABLE arrenda
	(morada			varchar(255)	not null,
	 codigo			integer			not null unique,	
	 nif			integer			not null unique,
	 FOREIGN KEY(morada,codigo) REFERENCES alugavel(morada,codigo),
	 FOREIGN KEY(nif) 		   	REFERENCES user(nif));
	 
CREATE TABLE fiscaliza
	(id 			integer			not null unique,
	 morada			varchar(255)	not null,
	 codigo 		integer			not null unique,
	 FOREIGN KEY id 		   	REFERENCES fiscal(id),
	 FOREIGN KEY(morada,codigo) REFERENCES arrenda(morada,codigo));
	 
CREATE TABLE espaco
	(morada			varchar(255)	not null unique,
	 codigo			integer			not null unique,
	 FOREIGN KEY(morada,codigo) REFERENCES alugavel(morada,codigo));
	 
CREATE TABLE posto
	(morada			varchar(255)	not null unique,
	 codigo,		integer			not null unique,
	 codigo_espaco,	integer			not null unique,
	 FOREIGN KEY(morada,codigo) REFERENCES alugavel(morada,codigo),
	 FOREIGN KEY(morada,codigo_espaco) REFERENCES Espaco(morada,codigo_espaco));
	 
CREATE TABLE oferta
	(morada			varchar(255)	not null unique,
	 codigo			integer			not null unique,
	 data_inicio	date			not null,
	 data_fim		date			not null,
	 tarifa			numeric(10,2)	not null,
	 PRIMARY KEY(data_inicio),
	 FOREIGN KEY(morada,codigo) REFERENCES alugavel(morada,codigo));