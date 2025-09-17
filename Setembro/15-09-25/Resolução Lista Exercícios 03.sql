USE master;
GO
DROP DATABASE ListaDeExercicios03;

CREATE DATABASE ListaDeExercicios03;
USE ListaDeExercicios03;

CREATE TABLE Produto(
CodProduto int CONSTRAINT PK_COD_PRODUTO PRIMARY KEY IDENTITY(1,1),
Nome varchar(10) CONSTRAINT NN_NOME_PRODUTO NOT NULL,
Preco decimal(8,2) CONSTRAINT NN_PRECO_PRODUTO NOT NULL,
Tipo varchar(10) CONSTRAINT NN_TIPO_PRODUTO NOT NULL
);

CREATE TABLE StatusConta(
CodStatusConta int CONSTRAINT PK_COD_STATUS_Conta PRIMARY KEY IDENTITY (1,1),
Nome varchar(50) CONSTRAINT CK_NOME_STATUS_CONTA CHECK (Nome IN ('Aberto', 'Fechado', 'Pago'))
);

CREATE TABLE StatusPedido(
CodStatusPedido int CONSTRAINT PK_COD_STATUS_PEDIDO PRIMARY KEY IDENTITY (1,1),
Nome varchar(50) CONSTRAINT CK_NOME_STATUS_PEDIDO CHECK (Nome IN ('Pendente', 'Entregue')),
);

CREATE TABLE StatusUsuario(
CodStatusUsuario int CONSTRAINT PK_COD_STATUS_USUARIO PRIMARY KEY IDENTITY (1,1),
Nome varchar(50) CONSTRAINT CK_NOME_STATUS_USUARIO CHECK (Nome IN ('Ativo', 'Inativo'))
);

CREATE TABLE Conta(
CodConta int CONSTRAINT PK_COD_CONTA PRIMARY KEY IDENTITY (1,1),
Mesa int CONSTRAINT NN_MESA NOT NULL,
HoraAbertura datetime CONSTRAINT NN_HORAABERTURA NOT NULL,
HoraFechamento datetime CONSTRAINT NN_HORAFECHAMENTO NOT NULL,
Situacao int CONSTRAINT NN_SITUACAO_CONTA NOT NULL,
CONSTRAINT FK_SITUACAO_CONTA FOREIGN KEY (Situacao)
REFERENCES StatusConta(CodStatusConta),
Total decimal(8,2) CONSTRAINT NN_TOTAL_CONTA NOT NULL
);

CREATE TABLE Usuario(
CodUsuario int CONSTRAINT PK_COD_USUARIO PRIMARY KEY IDENTITY (1,1),
Login varchar(100) CONSTRAINT NN_LOGIN_USUARIO NOT NULL,
CONSTRAINT UQ_LOGIN_UNIQUE UNIQUE(Login),
Senha varchar(50) CONSTRAINT NN_SENHA_USUARIO NOT NULL,
UltimoAcesso datetime CONSTRAINT NN_ULTIMO_ACESSO NOT NULL,
Status int CONSTRAINT NN_STATUS_USUARIO NOT NULL,
CONSTRAINT FK_STATUS_USUARIO FOREIGN KEY (Status)
REFERENCES StatusUsuario(CodStatusUsuario)
);

CREATE TABLE Pedido(
CodPedido int CONSTRAINT PK_COD_PEDIDO PRIMARY KEY IDENTITY (1,1),
Produto int CONSTRAINT NN_PRODUTO_PEDIDO NOT NULL,
Qtde int CONSTRAINT NN_QTD NOT NULL,
ValorUnitario decimal(8,2) CONSTRAINT NN_VALOR_UNITARIO NOT NULL,
ValorTotal decimal(8,2) CONSTRAINT NN_VALOR_TOTAL NOT NULL,
Situacao int CONSTRAINT NN_SITUACAO_PEDIDO NOT NULL,
Conta int CONSTRAINT NN_CONTA_PEDIDO NOT NULL,
Usuario int CONSTRAINT NN_USUARIO_PEDIDO NOT NULL,
CONSTRAINT FK_PRODUTO_PEDIDO FOREIGN KEY (Produto)
REFERENCES Produto(CodProduto),
CONSTRAINT FK_SITUACAO_PEDIDO FOREIGN KEY (Situacao)
REFERENCES StatusPedido(CodStatusPedido),
CONSTRAINT FK_CONTA_PEDIDO FOREIGN KEY (Conta)
REFERENCES Conta(CodConta),
CONSTRAINT FK_USUARIO_PEDIDO FOREIGN KEY (Usuario)
REFERENCES Usuario(CodUsuario)
);

-- Crie os comandos SQL para inserir 2 registros na tabela status pedido.
INSERT INTO StatusPedido(Nome)
VALUES('Pendente');
INSERT INTO StatusPedido(Nome)
VALUES('Entregue');

-- Crie outro comando SQL para inserir 2 status de usuário (ativo e inativo)
INSERT INTO StatusUsuario(Nome)
VALUES('Inativo');
INSERT INTO StatusUsuario(Nome)
VALUES('Ativo')

-- Crie outro comando SQL para inserir 3 status da conta (Aberto, Fechado, Pago)
INSERT INTO StatusConta(Nome)
VALUES('Fechado');
INSERT INTO StatusConta(Nome)
VALUES('Pago');
INSERT INTO StatusConta(Nome)
VALUES('Aberto');

-- Faça um comando para excluir todos os registros da tabela peDido, porém, que o usuário que fez o pedido tenha o nome Antonio (exatamente como Antonio)
DELETE FROM PEDIDO
WHERE Usuario IN (SELECT CodUsuario FROM Usuario WHERE Login = 'Antonio');

-- Aumente em 10% o preço de cada produto da tabela produto.
UPDATE Produto
Set Preco = Preco*1.10;

-- Liste o nome de cada garçom (usuário) e o valor total em pedidos que cada um fez.
SELECT U.Login, SUM(P.ValorTotal) AS 'Valor Total em Pedidos'
FROM Usuario U
INNER JOIN Pedido P ON P.Usuario = U.CodUsuario
GROUP BY U.Login;

-- Mostre a soma do valor total de todas as contas que não tiveram data e hora de fechamento.
SELECT SUM(C.Total) AS 'Soma do Valor Total'
FROM Conta C
WHERE HoraFechamento IS NULL;

-- Liste o nome dos garçons que nunca fizeram nenhum pedido.
SELECT U.Login
FROM Usuario U
LEFT JOIN Pedido P ON U.CodUsuario = P.Usuario
WHERE P.CodPedido IS NULL;

-- Mostre a média de preço de cada produto agrupado pelo tipo do produto.
SELECT Tipo, AVG(Preco) AS 'Média de Preço'
FROM Produto
GROUP BY Tipo;

-- Mostre a soma de todos os produtos consumidos para a conta cod = 10.
SELECT Co.CodConta, Co.Mesa, Co.Situacao, Co.Total, SUM(Pr.Preco) AS 'Soma dos produtos consumidos pela conta 10'
FROM Conta Co
INNER JOIN Pedido Pe ON Co.CodConta = Pe.Conta
INNER JOIN Produto Pr ON Pr.CodProduto = Pe.Produto
GROUP BY Co.CodConta, Co.Mesa, Co.Situacao, Co.Total;