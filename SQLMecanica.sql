CREATE DATABASE mecanica
GO
USE mecanica
GO
CREATE TABLE cliente
(
	id_cliente					INT	IDENTITY(3401, 15)	NOT NULL,
	nome						VARCHAR(100)			NOT NULL,
	logradouro_end				VARCHAR(200)			NOT NULL,
	numero_end					INT						NOT NULL CHECK(numero_end >= 0),
	cep_end						CHAR(8)					NOT NULL CHECK(LEN(cep_end) = 8),
	complemento_end				VARCHAR(255)			NOT NULL
	PRIMARY KEY (id_cliente)
)
GO
CREATE TABLE telefone_cliente
(
	id_cliente					INT						NOT NULL,
	telefone					VARCHAR(11)				NOT NULL
	PRIMARY KEY (id_cliente, telefone)
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
)
GO
CREATE TABLE veiculo
(
	placa						CHAR(7)					NOT NULL CHECK(LEN(placa) = 7),
	marca						VARCHAR(30)				NOT NULL,
	modelo						VARCHAR(30)				NOT NULL CHECK(CONVERT(INT, LEFT(modelo, 4)) >= 1997),
	cor							VARCHAR(15)				NOT NULL,
	ano_fabricacao				INT						NOT NULL CHECK(ano_fabricacao >= 1997),
	ano_modelo					INT						NOT NULL,
	data_aquisicao				DATE					NOT NULL,
	id_cliente					INT						NOT NULL
	PRIMARY KEY (placa)
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	CONSTRAINT chk_ano_mod_fab CHECK (ano_modelo = ano_fabricacao OR ano_modelo = ano_fabricacao + 1)
)
GO
CREATE TABLE categoria
(
	id_categoria				INT	IDENTITY(1, 1)		NOT NULL,
	categoria					VARCHAR(10)				NULL     DEFAULT('Estagiário'),
	valor_hora					DECIMAL(4, 2)			NOT NULL
	PRIMARY KEY (id_categoria),
	CONSTRAINT chk_ctg_vlt CHECK
	(
		categoria = 'Estagiário' AND valor_hora > 15 OR
		categoria = 'Nível 1' 	 AND valor_hora > 25 OR
		categoria = 'Nível 2'	 AND valor_hora > 35 OR
		categoria = 'Nível 3'    AND valor_hora > 50
	)
)
GO
CREATE TABLE funcionario
(
	id_funcionario				INT	IDENTITY(101, 1)	NOT NULL,
	nome						VARCHAR(100)			NOT NULL,
	logradouro_end				VARCHAR(200)			NOT NULL,
	numero_end					INT						NOT NULL CHECK(numero_end >= 0),
	telefone					CHAR(11)				NOT NULL CHECK(telefone = 10 OR telefone = 11),
	categoria_habilitacao		VARCHAR(2)				NOT NULL CHECK(categoria_habilitacao IN('A', 'B', 'C', 'D', 'E')),
	id_categoria				INT						NOT NULL
	PRIMARY KEY (id_funcionario)
	FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
)
GO
CREATE TABLE peca
(
	id_peca						INT	IDENTITY(3411, 7)	NOT NULL,
	nome						VARCHAR(100)			NOT NULL UNIQUE,
	preco						DECIMAL(4, 2)			NOT NULL CHECK(preco >= 0),
	estoque						INT						NULL     DEFAULT 10 CHECK(estoque >= 10)
	PRIMARY KEY (id_peca)
)
GO
CREATE TABLE reparo
(
	placa						CHAR(7)					NOT NULL,			
	id_funcionario				INT						NOT NULL,
	id_peca						INT						NOT NULL,
	data_reparo					DATE					NOT NULL DEFAULT GETDATE(),
	custo_total					DECIMAL(4, 2)			NOT NULL CHECK(custo_total >= 0),
	tempo						INT						NOT NULL CHECK(tempo >= 0)
	PRIMARY KEY (placa, id_funcionario, id_peca, data_reparo)
	FOREIGN KEY (placa) REFERENCES veiculo (placa),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
	FOREIGN	KEY	(id_peca) REFERENCES peca (id_peca)
)