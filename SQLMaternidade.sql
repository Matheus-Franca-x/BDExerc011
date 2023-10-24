CREATE DATABASE maternidade
GO
USE maternidade
GO
CREATE TABLE mae 
(
	id_mae					INT IDENTITY(1001, 1)	NOT NULL,
	nome					VARCHAR(60) 			NOT NULL,
	logradouro_end			VARCHAR(100) 			NOT NULL,
	numero_end				INT						NOT NULL CHECK(numero_end >= 0),
	cep_end					CHAR(8) 				NOT NULL CHECK(LEN(cep_end) = 8),
	complemento_end			VARCHAR(200)			NOT NULL,
	telefone				CHAR(10)				NOT NULL CHECK(LEN(telefone) = 10),
	data_nasc				DATE					NOT NULL
	PRIMARY KEY (id_mae)
)
GO
CREATE TABLE bebe
(
	id_bebe					INT	IDENTITY(1, 1)		NOT NULL,
	nome					VARCHAR(60)				NOT NULL,
	data_nasc				DATE					NULL     DEFAULT GETDATE(),
	altura					DECIMAL(7, 2)			NOT NULL CHECK(altura >= 0),
	peso					DECIMAL(4, 3)			NOT NULL CHECK(peso >= 0),
	id_mae					INT						NOT NULL
	PRIMARY KEY (id_bebe)
	FOREIGN KEY (id_mae) REFERENCES mae (id_mae)
)
GO
CREATE TABLE medico
(
	crm_num					INT						NOT NULL,
	crm_uf					CHAR(2)					NOT NULL,
	nome					VARCHAR(60)				NOT NULL,
	telefone_cell			CHAR(11)				NOT NULL CHECK(LEN(telefone_cell) = 11),
	especialidade			VARCHAR(30)				NOT NULL
	PRIMARY KEY (crm_num, crm_uf)
)
GO
CREATE TABLE bebe_medico
(
	id_bebe					INT						NOT NULL,
	crm_num					INT						NOT NULL,
	crm_uf					CHAR(2)					NOT NULL
	PRIMARY KEY (id_bebe, crm_num, crm_uf)
	FOREIGN KEY (id_bebe) REFERENCES bebe (id_bebe),
	FOREIGN KEY (crm_num, crm_uf) REFERENCES medico (crm_num, crm_uf)
)




