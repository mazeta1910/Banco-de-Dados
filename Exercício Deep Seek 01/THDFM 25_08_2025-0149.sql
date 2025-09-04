--ESCALACAO (PK,FK Cod_Partida, PK,FK Cod_Jogador, Titular)  

CREATE TABLE
	Estadios (
		Cod_Estadio INT CONSTRAINT PK_ESTADIO PRIMARY KEY IDENTITY (1, 1),
		Nome varchar(100) CONSTRAINT NN_NOME_ESTADIO NOT NULL,
		Cidade varchar(100) CONSTRAINT NN_CIDADE_ESTADIO NOT NULL,
		Capacidade INT CONSTRAINT NN_CAPACIDADE_eSTADIO NOT NULL,
		CONSTRAINT CAPACIDADE_ESTADIO CHECK (Capacidade > 0),
		CONSTRAINT UK_ESTADIO_NOME UNIQUE (Nome)
	);

CREATE TABLE
	Times (
		Cod_Time INT CONSTRAINT PK_TIME PRIMARY KEY IDENTITY (1, 1),
		Nome varchar(100) CONSTRAINT NN_NOME_TIME NOT NULL CONSTRAINT UK_NOME_TIME UNIQUE,
		Cidade varchar(100) CONSTRAINT NN_CIDADE_TIME NOT NULL,
		Ano_Fundacao INT CONSTRAINT NN_ANO_FUNDACAO NOT NULL CONSTRAINT CK_ANO_FUNDACAO CHECK (
			Ano_Fundacao > 1800
			AND Ano_Fundacao <= YEAR (GETDATE ())
		)
	);

--TECNICO (PK Cod_Tecnico, Nome, Nacionalidade, Especialidade, FK Cod_Time)  
CREATE TABLE
	Tecnicos (
		Cod_Tecnico INT CONSTRAINT PK_TECNICO PRIMARY KEY IDENTITY (1, 1),
		Nome varchar(100) CONSTRAINT NN_NOME_TECNICO NOT NULL,
		Nacionalidade varchar(100) CONSTRAINT NN_NACIONALIDADE NOT NULL,
		Especialidade varchar(50) CONSTRAINT NN_ESPECIALIDADE NOT NULL,
		Cod_Time int NOT NULL,
		CONSTRAINT FK_COD_TIME FOREIGN KEY (COD_TIME) REFERENCES TIMES (COD_TIME)
	);

--JOGADOR (PK Cod_Jogador, Nome, Posicao, Data_Nascimento, FK Cod_Time)  
CREATE TABLE
	Jogadores (
		Cod_Jogador INT CONSTRAINT PK_JOGADOR PRIMARY KEY IDENTITY (1, 1),
		Nome varchar(100) CONSTRAINT NN_NOME_JOGADOR NOT NULL,
		Nacionalidade varchar(100) CONSTRAINT NN_NACIONALIDADE NOT NULL,
		Posicao varchar(50) CONSTRAINT NN_POSICAO NOT NULL CONSTRAINT CK_POSICAO CHECK (
			Posicao IN ('Goleiro', 'Defensor', 'Meia', 'Atacante')
		),
		Data_Nascimento DATE CONSTRAINT CK_DATA_NASCIMENTO CHECK (
			Data_Nascimento BETWEEN '1900-01-01' AND GETDATE  ()
		),
		Cod_Time int NOT NULL,
		CONSTRAINT FK_JOGADORES_TIME FOREIGN KEY (COD_TIME) REFERENCES TIMES (COD_TIME),
		Pe_Dominante varchar(10) CONSTRAINT NN_PE_DOMINANTE NOT NULL CONSTRAINT CK_PE_DOMINANTE CHECK (Pe_Dominante IN ('Ambos', 'Esquerdo', 'Direito'))
	);

-- SQL Check constraints não pode referenciar colunas diretamente na declaração da coluna
ALTER TABLE Tecnicos 
ADD Formacao_Favorita varchar(10),
	Data_Contrato_Inicial DATE,
	Data_Contrato_Final DATE;
GO

-- Adicionando as constraints
ALTER TABLE Tecnicos 
ADD CONSTRAINT CK_FORMACAO_FAVORITA CHECK (
	Formacao_Favorita IN (
		'4-4-2',
		'4-3-3',
		'4-5-1',
		'3-5-2',
		'3-4-3',
		'5-4-1',
		'5-3-2'
	)
);
GO

-- Checando data inicial
ALTER TABLE Tecnicos 
	ADD CONSTRAINT CK_DATA_CONTRATO_INICIAL 
	CHECK (Data_Contrato_Inicial >= '1950-01-01' OR Data_Contrato_Inicial IS NULL);
GO

-- Checando as duas datas
ALTER TABLE Tecnicos ADD CONSTRAINT CK_DATAS_CONTRATO 
	CHECK ((Data_Contrato_Final >= Data_Contrato_Inicial) OR 
	(Data_Contrato_Inicial IS NULL AND Data_Contrato_Final IS NULL));
GO

--PARTIDA (PK Cod_Partida, Data, Horario, FK Cod_Estadio, FK Cod_Time_Casa, FK Cod_Time_Visitante)  

CREATE TABLE Partidas (
	Cod_Partida INT CONSTRAINT PK_COD_PARTIDA PRIMARY KEY IDENTITY(1,1),
	Data_Partida DATE
		CONSTRAINT CK_DATA_PARTIDA CHECK (Data_Partida BETWEEN '1950-01-01' AND GETDATE()),
	Horario_Inicio TIME,
	Horario_Fim TIME,
	Cod_Estadio INT NOT NULL,
	Cod_Time_Casa INT NOT NULL,
	Cod_Time_Visitante INT NOT NULL,
		CONSTRAINT CK_HORARIOS_PARTIDA CHECK (Horario_Inicio < Horario_Fim),
		CONSTRAINT FK_PARTIDAS_ESTADIO FOREIGN KEY (Cod_Estadio) REFERENCES Estadios(Cod_Estadio),
		CONSTRAINT FK_PARTIDAS_MANDANTE FOREIGN KEY (Cod_Time_Casa) REFERENCES Times(Cod_Time),
		CONSTRAINT FK_PARTIDAS_VISITANTE FOREIGN KEY (Cod_Time_Visitante) REFERENCES Times(Cod_Time),
	Res_Casa INT NOT NULL
		CONSTRAINT DF_RES_CASA DEFAULT 0,
	Res_Fora INT NOT NULL
		CONSTRAINT DF_RES_FORA DEFAULT 0,
	Cod_Treinador_Casa INT NOT NULL,
		CONSTRAINT FK_PARTIDA_TREINADOR_CASA FOREIGN KEY (Cod_Treinador_Casa) REFERENCES Tecnicos(Cod_Tecnico),
	Cod_Treinador_Fora INT NOT NULL,
		CONSTRAINT FK_PARTIDA_TREINADOR_MANDANTE FOREIGN KEY (Cod_Treinador_Fora) REFERENCES Tecnicos(Cod_Tecnico)
);

-- /DEFINIÇÃO DE RESTRIÇÃO / NOME DA CONSTRAINT / TIPO DE RESTRIÇÃO (XXXX) / DEFINIÇÃO DA RESTRIÇÃO --
--ESCALACAO (PK,FK Cod_Partida, PK,FK Cod_Jogador, Titular)  

CREATE TABLE Escalacoes(
	Cod_Partida INT NOT NULL,
	Cod_Jogador INT NOT NULL,
	Titular BIT NOT NULL,
	CONSTRAINT PK_ESCALACOES PRIMARY KEY (Cod_Partida, Cod_Jogador),
	CONSTRAINT FK_ESCALACOES_PARTIDA FOREIGN KEY (Cod_Partida) REFERENCES Partidas(Cod_Partida),
	CONSTRAINT FK_ESCALACOES_JOGADOR FOREIGN KEY (Cod_Jogador) REFERENCES Jogadores(Cod_Jogador)
);

-- /DEFINIÇÃO DE RESTRIÇÃO / NOME DA CONSTRAINT / TIPO DE RESTRIÇÃO (XXXX) / DEFINIÇÃO DA RESTRIÇÃO --

USE master;
GO
ALTER DATABASE [Exercicio01-TecnicosFutebol] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE [Exercicio01-TecnicosFutebol];
GO

-- 2. Criação do novo banco
CREATE DATABASE [Exercicio01-TecnicosFutebol];
GO
USE [Exercicio01-TecnicosFutebol];
GO

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Jogadores' AND COLUMN_NAME LIKE '%Cod%Jogador%';