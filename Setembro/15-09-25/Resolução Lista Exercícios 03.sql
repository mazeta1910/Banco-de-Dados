USE master;
GO
DROP DATABASE ListaDeExercicios02;

CREATE DATABASE ListaDeExercicios02;

CREATE TABLE Cliente(
CodCliente int CONSTRAINT PK_CODCLIENTE PRIMARY KEY IDENTITY(1,1),
Nome varchar(200) CONSTRAINT NN_NOME_CLIENTE NOT NULL,
Cidade varchar(200) CONSTRAINT NN_NOME_CIDADE NOT NULL
);

CREATE TABLE Produto(
CodProduto int CONSTRAINT PK_CODPRODUTO PRIMARY KEY IDENTITY(1,1),
NomeProduto varchar(200) CONSTRAINT NN_NOME_PRODUTO NOT NULL,
Preco decimal(8,2) CONSTRAINT NN_PRECO_PRODUTO NOT NULL,
Tipo varchar(10) CONSTRAINT CK_TIPO_PRODUTO CHECK (Tipo IN ('Hardware', 'Software', 'Outros'))
);

CREATE TABLE Pedido(
CodPedido int CONSTRAINT PK_CODPEDIDO PRIMARY KEY IDENTITY(1,1),
Produto int CONSTRAINT NN_PRODUTO_PEDIDO NOT NULL,
Cliente int CONSTRAINT NN_CLIENTE_PEDIDO NOT NULL,
ValorUnitario decimal(8,2) CONSTRAINT NN_VALORUNIT_PEDIDO NOT NULL,
ValorTotal decimal(8,2) CONSTRAINT NN_VALORTOTAL_PEDIDO NOT NULL,
CONSTRAINT FK_PRODUTO_PEDIDO FOREIGN KEY (Produto) REFERENCES Produto(CodProduto),
CONSTRAINT FK_CLIENTE_PEDIDO FOREIGN KEY (Cliente) REFERENCES Cliente(CodCliente)
);

--a) Insira 3 produtos, 3 clientes e 4 pedidos no banco de dados.
INSERT INTO Produto(NomeProduto, Preco, Tipo)
VALUES ('AutoCAD', 7500, 'Software');
INSERT INTO Produto(NomeProduto, Preco, Tipo)
VALUES ('NVIDIA GeForce GTX6060', 4500, 'Hardware');
INSERT INTO Produto(NomeProduto, Preco, Tipo)
VALUES ('Mouse Razer DeathAdder V3 Pro', 980, 'Outros');
INSERT INTO Produto(NomeProduto, Preco, Tipo)
VALUES ('Retrado da Santina', 16.50, 'Outros');

INSERT INTO Cliente(Nome, Cidade)
VALUES ('Lucas Renan Ribeiro Straube', 'Itaperuçu');
INSERT INTO Cliente(Nome, Cidade)
VALUES ('Franscico Dindão', 'Coivaras');
INSERT INTO Cliente(Nome, Cidade)
VALUES ('Matheus Honorato', 'Duque de Caxias');

INSERT INTO Pedido(Produto, Cliente, ValorUnitario, ValorTotal)
VALUES (1, 1, 7500, 7500);
INSERT INTO Pedido(Produto, Cliente, ValorUnitario, ValorTotal)
VALUES (2, 2, 4500, 4500);
INSERT INTO Pedido(Produto, Cliente, ValorUnitario, ValorTotal)
VALUES (3, 3, 980, 980);
INSERT INTO Pedido(Produto, Cliente, ValorUnitario, ValorTotal)
VALUES (1, 3, 7500, 7500);

-- 2) Exclua todos os produtos que o preço esteja entre 1 real e 2,99.
DELETE FROM Produto
WHERE Preco BETWEEN 1.00 AND 2.99;

-- 3) Exclua os clientes que não informaram em qual cidade moram.
DELETE FROM Cliente
Where Cidade IS NULL;

-- 4) Atualize o preço de todos os produtos do tipo Software. Dê um aumento de 10%.
UPDATE Produto
SET Preco = Preco * 1.1
Where Tipo LIKE 'Software';

-- 5) Liste o nome de todos os produtos que o tipo é Hardware ou Software, e ordene por nome do produto.
SELECT CodProduto, NomeProduto, Preco
FROM Produto
WHERE Tipo LIKE 'Software' OR Tipo LIKE 'Hardware';

-- f) Liste o nome e cidade de todos os clientes que tem como sobrenome (final do nome) Silva.
SELECT Nome, Cidade
FROM Cliente
WHERE Nome LIKE '%Silva';

-- g) Liste a média de preços dos pedidos (baseado na coluna ValorTotal)
SELECT AVG(ValorTotal) AS 'Média de Preços'
FROM Pedido

-- h) Liste a média de preço de cada tipo de produto. Ordene por tipo.
SELECT Tipo, AVG(Preco) AS 'Média de Preços'
FROM Produto
GROUP BY Tipo
ORDER BY Tipo;

-- i) Liste o nome do produto com o preço mais alto.
SELECT TOP 1 NomeProduto
FROM Produto
ORDER BY Preco DESC;

-- j) Liste o preço do produto com o preço mais baixo.
SELECT TOP 1 Preco
From Produto
ORDER BY Preco ASC;

-- k) Altere a tabela Pedido para incluir uma coluna chamada Data do tipo timestamp null.
ALTER TABLE Pedido
ADD Data datetime NULL;

-- l) Atualize a coluna Data da tabela Pedido para 01/01/2022 se o cliente for de Curitiba.
-- E para 01/05/2022 se o cliente for de outra cidade.
UPDATE Pedido
SET Data = CASE 
    WHEN c.Cidade = 'Curitiba' THEN '2022-01-01'
    ELSE '2022-05-01'
END
FROM Pedido p
INNER JOIN Cliente c ON p.Cliente = c.CodCliente;

-- m) Listar a data, valor unitário e valor total de todos os pedidos e também listar se
-- o valor total está de acordo com o valor unitário multiplicado pela quantidade.
SELECT 
    Data,
    ValorUnitario,
    ValorTotal,
    CASE 
        WHEN ValorTotal = ValorUnitario THEN 'CORRETO'
        ELSE 'INCORRETO'
    END AS 'Status do Valor Total'
FROM Pedido;

-- n) Liste o nome do cliente e do produto de cada pedido do cliente 1. Não duplique as informações.
SELECT DISTINCT C.Nome, Pr.NomeProduto
FROM Pedido Pe
INNER JOIN Produto Pr ON Pr.CodProduto = Pe.Produto
INNER JOIN Cliente C ON C.CodCliente = Pe.Cliente
WHERE C.CodCliente = 1;

-- o) Liste o nome de todos os produtos que não foram vendidos.
SELECT Pr.NomeProduto
FROM Produto Pr
LEFT JOIN Pedido Pe ON Pe.Produto = Pr.CodProduto
WHERE Pe.Produto IS NULL;

-- p) Una a listagem do código e nome de todos os produtos com o código e nome de todos os clientes.
SELECT Pr.CodProduto, Pr.NomeProduto, C.CodCliente, C.Nome
FROM Produto Pr
LEFT JOIN Pedido Pe ON Pr.CodProduto = Pe.Produto
LEFT JOIN Cliente C ON Pe.Cliente = C.CodCliente

-- q) Liste a quantidade de clientes, quantidade de pedidos e preço médio dos
-- produtos usando um único select com subselects.
SELECT
    (SELECT COUNT(*) FROM Cliente) AS 'Quantidade de Clientes',
    (SELECT COUNT(*) FROM Pedido) AS 'Quantidade de Pedidos',
    (SELECT AVG(Preco) FROM Produto) AS 'Preço Médio dos Produtos';

-- r) Liste o nome do cliente, soma do valor dos pedidos, média do valor dos pedidos e
-- quantidade de pedidos dos clientes qque já compraram mais de 15 mil (soma do valor total)
SELECT
    c.Nome AS 'Nome do Cliente',
    SUM(pd.ValorTotal) AS 'Soma dos Pedidos',
    AVG(pd.ValorTotal) AS 'Média dos Pedidos',
    COUNT(pd.CodPedido) AS 'Quantidade de Pedidos'
FROM Cliente c
INNER JOIN Pedido pd ON c.CodCliente = pd.Cliente
GROUP BY c.CodCliente, c.Nome
HAVING SUM(pd.ValorTotal) > 15000;