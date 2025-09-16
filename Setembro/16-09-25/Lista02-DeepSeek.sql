-- Tabela clientes
CREATE TABLE clientes (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    data_cadastro DATE
);

-- Tabela produtos
CREATE TABLE produtos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(50)
);

-- Tabela pedidos
CREATE TABLE pedidos (
    id INT PRIMARY KEY IDENTITY(1,1),
    cliente_id INT,
    data_pedido DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'pendente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabela itens_pedido
CREATE TABLE itens_pedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserir dados de exemplo
INSERT INTO clientes (nome, email, telefone, data_cadastro) VALUES
('João Silva', 'joao@email.com', '(11) 9999-8888', '2024-01-15'),
('Maria Santos', 'maria@email.com', '(11) 7777-6666', '2024-02-10'),
('Pedro Alves', 'pedro@email.com', '(11) 5555-4444', '2024-02-20'),
('Ana Costa', 'ana@email.com', '(11) 3333-2222', '2024-03-05'),
('Carlos Oliveira', 'carlos@email.com', '(11) 1111-0000', '2024-03-15'),
('Fernanda Lima', 'fernanda@email.com', '(11) 2222-3333', '2024-04-01'),
('Ricardo Souza', 'ricardo@email.com', '(11) 4444-5555', '2024-04-10');

INSERT INTO produtos (nome, preco, categoria) VALUES
('Notebook', 2500.00, 'Eletrônicos'),
('Mouse', 50.00, 'Eletrônicos'),
('Teclado', 120.00, 'Eletrônicos'),
('Camiseta', 40.00, 'Vestuário'),
('Calça Jeans', 90.00, 'Vestuário'),
('Livro SQL', 80.00, 'Livros'),
('Livro Python', 75.00, 'Livros'),
('Fone de Ouvido', 150.00, 'Eletrônicos'),
('Tênis', 200.00, 'Calçados'),
('Mochila', 120.00, 'Acessórios');

INSERT INTO pedidos (cliente_id, data_pedido, status) VALUES
(1, '2024-03-01', 'entregue'),
(2, '2024-03-05', 'entregue'),
(3, '2024-03-10', 'processando'),
(1, '2024-03-15', 'entregue'),
(4, '2024-03-20', 'pendente'),
(5, '2024-03-25', 'cancelado'),
(2, '2024-04-01', 'processando'),
(6, '2024-04-05', 'pendente');

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 2500.00),
(1, 2, 1, 50.00),
(2, 3, 1, 120.00),
(2, 8, 2, 150.00),
(3, 4, 3, 40.00),
(3, 5, 2, 90.00),
(4, 6, 1, 80.00),
(4, 7, 1, 75.00),
(5, 9, 1, 200.00),
(5, 10, 1, 120.00),
(6, 1, 1, 2500.00),
(7, 2, 2, 50.00),
(7, 3, 1, 120.00),
(8, 4, 5, 40.00);

--Exercício 1: Selecione todos os clientes ordenados por nome em ordem alfabética.
SELECT id, nome, email, telefone, data_cadastro
FROM Clientes
ORDER BY Nome asc;

--Exercício 2: Liste todos os produtos da categoria 'Eletrônicos' com preço superior a R$ 100,00.
SELECT Id, nome, preco, categoria
FROM Produtos
WHERE Preco > 100.00

--Exercício 3: Mostre o nome do cliente, a data do pedido e o status para todos os pedidos.
SELECT C.id, C.nome, Pe.data_pedido, Pe.status
FROM Clientes C
LEFT JOIN Pedidos Pe ON C.id = Pe.cliente_id

--Exercício 4: Calcule o valor total de cada pedido (quantidade × preço_unitario).
SELECT P.Id AS Pedido_ID, C.Nome AS Cliente_NOME, SUM(ItPe.pedido_id * ItPe.produto_id) AS 'Valor Total'
FROM Pedidos P
INNER JOIN Clientes C ON P.cliente_id = C.id
INNER JOIN Itens_Pedido ItPe ON ItPe.pedido_id = P.id
GROUP BY P.Id, C.Nome
ORDER BY P.id;

--Exercício 5: Encontre quantos pedidos cada cliente fez (mostre o nome do cliente e a quantidade de pedidos).
SELECT C.Nome, COUNT(P.Cliente_id) AS 'Pedidos do Cliente'
FROM Clientes C
LEFT JOIN Pedidos P ON C.id = P.Cliente_id
GROUP BY C.Nome

--Exercício 6: Liste os produtos que nunca foram vendidos (não estão em nenhum item_pedido).
SELECT P.id, P.nome, P.preco, P.categoria
FROM Produtos P
LEFT JOIN Itens_Pedido Ip ON P.id = Ip.produto_id
WHERE Ip.produto_id IS NULL;

--Exercício 7: Mostre todos os pedidos com status 'pendente' e os nomes dos clientes que os fizeram.
SELECT Pe.id, Pe.cliente_id, Pe.data_pedido, Pe.status, Cl.nome
FROM Pedidos Pe
INNER JOIN Clientes Cl ON Pe.cliente_id = Cl.id
WHERE Status LIKE 'Pendente';

--Exercício 8: Calcule o total de vendas por categoria de produto.
SELECT Pr.Categoria, COUNT(Pr.Id) AS 'Total de Vendas'
FROM Produtos Pr
GROUP BY Pr.Categoria;

--Exercício 9: Liste os clientes que fizeram pedidos em março de 2024.
SELECT Cl.id, Cl.nome, Cl.email, Cl.telefone, Cl.data_cadastro, Pe.data_pedido
FROM Clientes Cl
INNER JOIN Pedidos Pe ON Cl.id = Pe.cliente_id
WHERE Pe.data_pedido BETWEEN '2024-03-01' AND '2024-03-31';

--Exercício 10: Mostre os 3 produtos mais vendidos (com maior quantidade total vendida).
SELECT TOP 3 Pr.Id, Pr.Nome, Pr.Preco, Pr.Categoria, SUM(IPe.produto_id) AS 'Quantidade Total Vendida'
FROM Produtos Pr
INNER JOIN itens_pedido Ipe ON Pr.id = Ipe.produto_id
GROUP BY Pr.Id, Pr.Nome, Pr.Preco, Pr.Categoria
ORDER BY 'Quantidade Total Vendida' DESC;

--Exercício 11: Encontre o valor médio dos pedidos por cliente.
SELECT Cl.id, Cl.Nome, COUNT(Pe.id) AS 'Total Pedidos', SUM(ip.quantidade * ip.preco_unitario) / COUNT(Pe.id) AS 'Valor Médio dos Produtos'
FROM Clientes Cl
LEFT JOIN Pedidos pe ON Cl.id = Pe.cliente_id
LEFT JOIN itens_pedido ip ON pe.id = ip.pedido_id
GROUP BY Cl.id, Cl.nome
ORDER BY 'Valor Médio dos Produtos';

--Exercício 12: Liste todos os pedidos que contêm mais de 2 produtos diferentes.
SELECT Pe.id, Pe.cliente_id, Pe.data_pedido, Pe.status, COUNT(DISTINCT Ip.produto_id) AS 'Produtos Diferentes'
FROM Pedidos Pe
INNER JOIN itens_pedido Ip ON Ip.pedido_id = Pe.id
GROUP BY Pe.id, Pe.cliente_id, Pe.data_pedido, Pe.status
HAVING COUNT(DISTINCT IP.produto_id) > 2;

--Exercício 13: Mostre os clientes que nunca fizeram um pedido.

--Exercício 14: Calcule o total de vendas por mês.

--Exercício 15: Liste os produtos com seu preço e uma coluna adicional que classifique como "Caro" (preço > 150) ou "Acessível" (preço ≤ 150).

--Exercício 16: Mostre os pedidos com valor total superior a R$ 500,00.

--Exercício 17: Encontre o cliente que fez o pedido com o maior valor total.

--Exercício 18: Liste todos os produtos vendidos no pedido de ID 3.

--Exercício 19: Mostre a quantidade total de produtos vendidos por categoria.

--Exercício 20: Liste os clientes que fizeram mais de 1 pedido.