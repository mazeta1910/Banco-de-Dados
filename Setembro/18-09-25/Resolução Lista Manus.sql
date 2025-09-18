CREATE TABLE Categorias(
	id_categoria int CONSTRAINT PK_ID_CATEGORIA PRIMARY KEY IDENTITY(1,1),
	nome_categoria varchar(50) CONSTRAINT NN_NOME_CATEGORIA NOT NULL,
	descricao_categoria varchar(200),
	ativa BIT CONSTRAINT DF_CATEGORIA_ATIVA DEFAULT 1
);

CREATE TABLE Fornecedores(
	id_fornecedor int CONSTRAINT PK_ID_FORNECEDOR PRIMARY KEY IDENTITY(1,1),
	nome_fornecedor varchar(100) CONSTRAINT NN_NOME_FORNECEDOR NOT NULL,
	cnpj varchar(18) CONSTRAINT UQ_CNPJ UNIQUE,
	cidade varchar(50) CONSTRAINT NN_CIDADE_FORNECEDOR NOT NULL,
	estado varchar(2) CONSTRAINT CK_ESTADO_FORNECEDOR CHECK(estado IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG',
																'PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),
	telefone varchar(15),
	email varchar(100)
);

CREATE TABLE Clientes(
	id_cliente int CONSTRAINT PK_ID_CLIENTE PRIMARY KEY IDENTITY(1,1),
	nome_cliente varchar(100) CONSTRAINT NN_NOME_CLIENTE NOT NULL,
	cpf varchar(14) CONSTRAINT UQ_CPF UNIQUE,
	email varchar(100) CONSTRAINT NN_EMAIL_CLIENTE NOT NULL,
	telefone varchar(15),
	data_nascimento date,
	cidade varchar(50) NOT NULL,
	estado varchar(2) CONSTRAINT CK_ESTADO_CLIENTE CHECK (estado IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG',
																'PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),
	data_cadastro date CONSTRAINT NN_DATA_CADASTRO NOT NULL,
	ativo BIT CONSTRAINT DF_CLIENTE_ATIVO DEFAULT 1
);

CREATE TABLE Pedidos(
	id_pedido int CONSTRAINT PK_ID_PEDIDO PRIMARY KEY IDENTITY(1,1),
	data_pedido date CONSTRAINT NN_DATA_PEDIDO NOT NULL,
	valor_total decimal(10,2) CONSTRAINT NN_VALOR_TOTAL NOT NULL,
	status_pedido varchar(20) CONSTRAINT NN_STATUS_PEDIDO NOT NULL,
	CONSTRAINT CK_STATUS_PEDIDO CHECK (status_pedido IN ('Pendente', 'Processando', 'Enviado', 'Entregue', 'Cancelado')),
	data_entrega date,
	id_cliente int CONSTRAINT NN_ID_CLIENTE_PEDIDO NOT NULL,
	CONSTRAINT FK_ID_CLIENTE_PEDIDO FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Produtos(
	id_produto int CONSTRAINT PK_ID_PRODUTO PRIMARY KEY IDENTITY(1,1),
	nome_produto varchar(100) CONSTRAINT NN_NOME_PRODUTO NOT NULL,
	descricao_produto varchar(500),
	preco decimal(10,2) CONSTRAINT NN_PRECO_PRODUTO NOT NULL,
	CONSTRAINT CK_PRECO_PRODUTO CHECK(preco > 0),
	estoque int CONSTRAINT NN_ESTOQUE NOT NULL,
	CONSTRAINT CK_ESTOQUE CHECK(estoque >=0),
	data_cadastro date CONSTRAINT NN_DATA_CADASTRO NOT NULL,
	ativo BIT CONSTRAINT DF_PRODUTO_ATIVO DEFAULT 1,
	id_categoria int CONSTRAINT NN_ID_CATEGORIA_PRODUTO NOT NULL,
	CONSTRAINT FK_ID_CATEGORIA_PRODUTOS FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
	id_fornecedor int CONSTRAINT NN_ID_FORNECEDOR_PRODUTO NOT NULL,
	CONSTRAINT FK_ID_FORNECEDOR_PRODUTO FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor),
);

CREATE TABLE Itens_Pedido(
	id_pedido int CONSTRAINT NN_ID_PEDIDO_IP NOT NULL,
	id_produto int CONSTRAINT NN_ID_PRODUTO_IP NOT NULL,
	quantidade int CONSTRAINT NN_QUANTIDADE_IP NOT NULL,
	CONSTRAINT CK_QUANTIDADE_IP CHECK (quantidade > 0),
	preco_unitario decimal(10,2) CONSTRAINT NN_PRECO_UNITARIO NOT NULL,
	desconto decimal(5,2) CONSTRAINT DF_DESCONTO DEFAULT 0,
	CONSTRAINT PK_ITENS_PEDIDO PRIMARY KEY (id_pedido, id_produto),
	CONSTRAINT FK_ID_PEDIDO_IP FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido),
	CONSTRAINT FK_ID_PRODUTO_IP FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

CREATE TABLE Avaliacoes(
	id_avaliacao int CONSTRAINT PK_ID_AVALIACAO PRIMARY KEY IDENTITY(1,1),
	nota int CONSTRAINT NN_NOTA NOT NULL,
	CONSTRAINT CK_NOTA CHECK (nota BETWEEN 1 AND 5),
	comentario varchar(1000),
	data_avaliacao date CONSTRAINT NN_DATA_AVALIACAO NOT NULL,
	id_cliente int CONSTRAINT NN_ID_CLIENTE_AVALIACAO NOT NULL,
	id_produto int CONSTRAINT NN_ID_PRODUTO_AVALIACAO NOT NULL,
	CONSTRAINT FK_ID_CLIENTE_AVALIACAO FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
	CONSTRAINT FK_ID_PRODUTO_AVALIACAO FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);
----------------------------------------------------------------------------------------
-- Populando o banco de dados:
-- Populando a tabela CATEGORIAS
INSERT INTO CATEGORIAS (nome_categoria, descricao_categoria, ativa) VALUES
('Eletrônicos', 'Dispositivos eletrônicos e acessórios tecnológicos', 1),
('Roupas', 'Vestuário feminino, masculino e infantil', 1),
('Casa e Jardim', 'Móveis, decoração e produtos para jardinagem', 1),
('Livros', 'Livros de literatura, técnicos e didáticos', 1),
('Esportes', 'Equipamentos e roupas esportivas', 1),
('Beleza', 'Cosméticos e produtos de cuidados pessoais', 1),
('Brinquedos', 'Brinquedos e jogos infantis', 1),
('Automotivo', 'Peças e acessórios para veículos', 0);

-- Populando a tabela FORNECEDORES
INSERT INTO FORNECEDORES (nome_fornecedor, cnpj, cidade, estado, telefone, email) VALUES
('TechSupply Brasil', '12.345.678/0001-90', 'São Paulo', 'SP', '(11) 3333-4444', 'vendas@techsupply.com.br'),
('ModaStyle Confecções', '98.765.432/0001-10', 'Rio de Janeiro', 'RJ', '(21) 2222-3333', 'contato@modastyle.com'),
('CasaBela Móveis', '55.444.333/0001-20', 'Belo Horizonte', 'MG', '(31) 4444-5555', 'atendimento@casabela.com.br'),
('LivroMax Editora', '11.222.333/0001-40', 'São Paulo', 'SP', '(11) 5555-6666', 'distribuidora@livromax.com'),
('SportPro Equipamentos', '66.777.888/0001-30', 'Porto Alegre', 'RS', '(51) 7777-8888', 'compras@sportpro.com.br'),
('BelezaTotal Cosméticos', '33.222.111/0001-50', 'Curitiba', 'PR', '(41) 8888-9999', 'sac@belezatotal.com'),
('Brinquedos Educativos', '99.888.777/0001-60', 'Florianópolis', 'SC', '(48) 9999-0000', 'vendas@brinquedoseducativos.com.br'),
('AutoParts Brasil', '44.555.666/0001-70', 'Campinas', 'SP', '(19) 3030-4040', 'pedidos@autoparts.com.br');

-- Populando a tabela CLIENTES
INSERT INTO CLIENTES (nome_cliente, cpf, email, telefone, data_nascimento, cidade, estado, data_cadastro, ativo) VALUES
('João Silva Santos', '111.222.333-44', 'joao.silva@email.com', '(11) 9999-8888', '1985-03-15', 'São Paulo', 'SP', '2024-01-10', 1),
('Maria Santos Oliveira', '222.333.444-55', 'maria.santos@email.com', '(21) 8888-7777', '1990-07-22', 'Rio de Janeiro', 'RJ', '2024-01-15', 1),
('Pedro Costa Pereira', '333.444.555-66', 'pedro.costa@email.com', '(31) 7777-6666', '1982-11-30', 'Belo Horizonte', 'MG', '2024-02-01', 1),
('Ana Lima Rodrigues', '444.555.666-77', 'ana.lima@email.com', '(11) 6666-5555', '1995-05-18', 'Campinas', 'SP', '2024-02-10', 1),
('Carlos Oliveira Souza', '555.666.777-88', 'carlos.oliveira@email.com', '(51) 5555-4444', '1988-12-25', 'Porto Alegre', 'RS', '2024-03-05', 1),
('Fernanda Almeida Costa', '666.777.888-99', 'fernanda.almeida@email.com', '(41) 4444-3333', '1992-09-08', 'Curitiba', 'PR', '2024-03-12', 1),
('Ricardo Martins Lima', '777.888.999-00', 'ricardo.martins@email.com', '(48) 3333-2222', '1987-04-17', 'Florianópolis', 'SC', '2024-03-20', 1),
('Juliana Pereira Santos', '888.999.000-11', 'juliana.pereira@email.com', '(19) 2222-1111', '1993-12-03', 'Campinas', 'SP', '2024-04-01', 1),
('Marcos Oliveira Costa', '999.000.111-22', 'marcos.oliveira@email.com', '(11) 1111-2222', '1980-06-28', 'São Paulo', 'SP', '2024-04-05', 1),
('Patrícia Souza Silva', '000.111.222-33', 'patricia.souza@email.com', '(21) 2222-3333', '1991-02-14', 'Niterói', 'RJ', '2024-04-10', 1);

-- Populando a tabela PRODUTOS
INSERT INTO PRODUTOS (nome_produto, descricao_produto, preco, estoque, data_cadastro, ativo, id_categoria, id_fornecedor) VALUES
('Smartphone Samsung Galaxy S23', 'Smartphone Android 128GB, 8GB RAM, câmera tripla 50MP', 2899.00, 15, '2024-01-01', 1, 1, 1),
('Notebook Dell Inspiron 15', 'Notebook Intel Core i5, 8GB RAM, SSD 256GB, 15.6"', 2549.90, 8, '2024-01-05', 1, 1, 1),
('Camiseta Nike Dry-Fit', 'Camiseta esportiva tecnológica, secagem rápida', 89.90, 50, '2024-01-10', 1, 2, 2),
('Mesa de Jantar 6 Lugares', 'Mesa de madeira maciça, estilo rústico, 180x90cm', 1200.00, 5, '2024-01-15', 1, 3, 3),
('Livro SQL - Guia Completo', 'Guia completo de SQL com exemplos práticos', 75.50, 30, '2024-02-01', 1, 4, 4),
('Bicicleta Mountain Bike', 'Bicicleta aro 29, 21 marchas, suspensão dianteira', 980.00, 12, '2024-02-10', 1, 5, 5),
('Fone de Ouvido Bluetooth', 'Fone sem fio com cancelamento de ruído ativo', 220.00, 25, '2024-02-15', 1, 1, 1),
('Tênis Adidas Runfalcon', 'Tênis esportivo para corrida, confortável', 199.90, 35, '2024-03-01', 1, 2, 2),
('Kit Maquiagem Profissional', 'Kit com 12 sombras, 6 batons e pincéis', 149.90, 20, '2024-03-05', 1, 6, 6),
('Quebra-Cabeça 1000 Peças', 'Quebra-cabeça educativo, tema mapa-múndi', 59.90, 40, '2024-03-10', 1, 7, 7),
('Óleo Motor 5W30', 'Óleo lubrificante sintético 5W30, 1L', 35.90, 100, '2024-03-15', 1, 8, 8),
('Tablet Samsung Galaxy Tab', 'Tablet 10.4", 64GB, 4GB RAM, Android', 899.00, 18, '2024-03-20', 1, 1, 1),
('Vestido Floral Verão', 'Vestido leve de algodão, estampado floral', 129.90, 28, '2024-03-25', 1, 2, 2),
('Jogo de Panelas Antiaderente', 'Conjunto com 5 panelas e frigideira, antiaderente', 299.90, 15, '2024-04-01', 1, 3, 3),
('Livro Python para Iniciantes', 'Introdução à programação Python com exercícios', 65.00, 22, '2024-04-05', 1, 4, 4);

-- Populando a tabela PEDIDOS
INSERT INTO PEDIDOS (data_pedido, valor_total, status_pedido, data_entrega, id_cliente) VALUES
('2024-03-01', 2899.00, 'Entregue', '2024-03-03', 1),
('2024-03-05', 89.90, 'Entregue', '2024-03-07', 2),
('2024-03-10', 2549.90, 'Processando', NULL, 3),
('2024-03-15', 1200.00, 'Enviado', '2024-03-20', 4),
('2024-03-20', 75.50, 'Entregue', '2024-03-22', 5),
('2024-03-25', 980.00, 'Pendente', NULL, 1),
('2024-04-01', 419.80, 'Processando', NULL, 2),
('2024-04-05', 220.00, 'Enviado', '2024-04-10', 3),
('2024-04-10', 149.90, 'Entregue', '2024-04-12', 6),
('2024-04-15', 59.90, 'Processando', NULL, 7),
('2024-04-20', 35.90, 'Pendente', NULL, 8),
('2024-04-25', 899.00, 'Enviado', '2024-04-28', 9),
('2024-05-01', 129.90, 'Entregue', '2024-05-03', 10),
('2024-05-05', 299.90, 'Processando', NULL, 1),
('2024-05-10', 65.00, 'Pendente', NULL, 2);

-- Populando a tabela ITENS_PEDIDO
INSERT INTO ITENS_PEDIDO (id_pedido, id_produto, quantidade, preco_unitario, desconto) VALUES
(1, 1, 1, 2899.00, 0),
(2, 3, 1, 89.90, 0),
(3, 2, 1, 2549.90, 0),
(4, 4, 1, 1200.00, 0),
(5, 5, 1, 75.50, 0),
(6, 6, 1, 980.00, 0),
(7, 3, 2, 89.90, 10.00),
(7, 8, 1, 199.90, 0),
(8, 7, 1, 220.00, 0),
(9, 9, 1, 149.90, 0),
(10, 10, 1, 59.90, 0),
(11, 11, 1, 35.90, 0),
(12, 12, 1, 899.00, 0),
(13, 13, 1, 129.90, 0),
(14, 14, 1, 299.90, 0),
(15, 15, 1, 65.00, 0),
(1, 7, 1, 220.00, 5.00),
(3, 5, 1, 75.50, 0),
(5, 3, 2, 89.90, 15.00);

-- Populando a tabela AVALIACOES
INSERT INTO AVALIACOES (nota, comentario, data_avaliacao, id_cliente, id_produto) VALUES
(5, 'Excelente produto! Entrega rápida e produto de qualidade', '2024-03-04', 1, 1),
(4, 'Bom produto, mas poderia ter mais cores disponíveis', '2024-03-08', 2, 3),
(5, 'Notebook rápido e eficiente, perfeito para trabalho', '2024-03-12', 3, 2),
(3, 'Mesa bonita mas arranha com facilidade', '2024-03-21', 4, 4),
(5, 'Livro muito útil para aprender SQL, recomendo!', '2024-03-23', 5, 5),
(4, 'Bicicleta de boa qualidade, entrega dentro do prazo', '2024-03-28', 1, 6),
(5, 'Fone excelente, som de alta qualidade e confortável', '2024-04-08', 3, 7),
(4, 'Tênis confortável, mas solado poderia ser mais aderente', '2024-04-12', 2, 8),
(5, 'Kit de maquiagem completo, produtos de boa qualidade', '2024-04-14', 6, 9),
(3, 'Quebra-cabeça com peças muito pequenas, difícil de montar', '2024-04-18', 7, 10),
(4, 'Óleo de boa qualidade, entrega rápida', '2024-04-22', 8, 11),
(5, 'Tablet perfeito para estudos e entretenimento', '2024-04-30', 9, 12),
(4, 'Vestido bonito e confortável, tecido de qualidade', '2024-05-04', 10, 13),
(5, 'Panelas antiaderentes excelentes, não grudam nada', '2024-05-08', 1, 14),
(4, 'Livro bom para iniciantes, exemplos claros', '2024-05-12', 2, 15);
----------------------------------------------------------------------------------------

--1. Liste todos os produtos com nome e preço.
SELECT id_produto, nome_produto, descricao_produto, preco, estoque, data_cadastro, ativo
FROM Produtos
ORDER BY Nome_Produto;

--2. Mostre todas as categorias ativas.
SELECT id_categoria, nome_categoria, descricao_categoria
FROM Categorias
WHERE ativa = 1
ORDER BY nome_categoria;

--3. Encontre todos os clientes de São Paulo (SP).
SELECT id_cliente, nome_cliente, cpf, email, telefone, data_nascimento, cidade, estado, data_cadastro, ativo
FROM Clientes
WHERE Cidade LIKE 'São Paulo' AND Estado LIKE 'SP';

--4. Liste produtos com preço acima de R$ 100.
SELECT id_produto, nome_produto, descricao_produto, preco, estoque, data_cadastro, ativo
FROM Produtos
WHERE preco > 100;

--5. Mostre fornecedores que têm telefone cadastrado.
SELECT id_fornecedor, nome_fornecedor, cnpj, cidade, estado, telefone, email
FROM Fornecedores
WHERE Telefone IS NOT NULL;

--6. Encontre produtos cadastrados em 2024.
SELECT id_produto, nome_produto, descricao_produto, preco, estoque, data_cadastro
FROM Produtos
WHERE data_cadastro BETWEEN '2024-01-01' AND '2024-12-31';

--7. Liste clientes que nasceram antes de 1990.
SELECT *
FROM Clientes
WHERE data_nascimento < '1990-01-01';

--8. Mostre pedidos com status 'Entregue'.
SELECT *
FROM Pedidos
WHERE status_pedido = 'Entregue';

--9. Encontre produtos com estoque menor que 10 unidades.
SELECT *
FROM Produtos
WHERE Estoque < 10;

--10. Liste avaliações com nota 5.
SELECT *
FROM Avaliacoes
WHERE Nota = 5;

--NÍVEL 2: WHERE AVANÇADO (11-15)
--1. Encontre produtos cujo nome contenha "Smartphone".
SELECT id_produto, nome_produto, descricao_produto, preco, estoque, data_cadastro, ativo
FROM Produtos
WHERE nome_produto LIKE '%smartphone%';

--2. Liste clientes de SP ou RJ.
SELECT id_cliente, nome_cliente, cpf, email, telefone, data_nascimento, cidade, estado
FROM Clientes
WHERE Estado IN ('RJ', 'SP')
ORDER BY estado;

--3. Mostre produtos com preço entre R$ 50 e R$ 200.
SELECT id_produto, nome_produto, descricao_produto, preco, estoque, data_cadastro
FROM Produtos
WHERE Preco BETWEEN 50 AND 200
ORDER BY Preco;

--4. Encontre pedidos feitos em dezembro de 2024.
SELECT id_pedido, data_pedido, valor_total, status_pedido, data_entrega
From Pedidos
WHERE data_pedido BETWEEN '2024-12-31' AND '2024-12-01'
ORDER BY data_pedido;
-- OU
SELECT id_pedido, data_pedido, valor_total, status_pedido, data_entrega
From Pedidos
WHERE MONTH(data_pedido) = 12 AND YEAR(data_pedido) = 2024
ORDER BY data_pedido;

--5. Liste produtos de fornecedores de Minas Gerais (MG).
SELECT id_fornecedor, nome_fornecedor, cnpj, cidade, estado, telefone, email
FROM Fornecedores
WHERE Estado = 'MG';

--NÍVEL 3: ORDER BY E FUNÇÕES SIMPLES (16-20)
--1. Liste produtos ordenados por preço (maior para menor).
SELECT *
FROM Produtos
ORDER BY Preco DESC;

--2. Mostre clientes ordenados por nome alfabeticamente.
SELECT *
FROM CLIENTES
ORDER BY Nome_Cliente;

--3. Encontre os 5 produtos mais caros.
SELECT TOP 5 *
FROM Produtos
ORDER BY Preco DESC;

--4. Liste pedidos ordenados por data (mais recente primeiro).
SELECT *
FROM PEDIDOS
ORDER BY data_pedido DESC;

--5. Mostre fornecedores ordenados por cidade e depois por nome.
SELECT *
FROM Fornecedores
ORDER BY Cidade, Nome_Fornecedor;

--NÍVEL 4: INNER JOIN (21-25)
--1. Liste produtos com nome da categoria.
SELECT pr.id_produto, pr.nome_produto, pr.descricao_produto, pr.preco, pr.estoque, ca.nome_categoria
FROM Produtos pr
INNER JOIN Categorias ca ON pr.id_categoria = ca.id_categoria;

--2. Mostre pedidos com nome do cliente.
SELECT pe.id_pedido, pe.data_pedido, pe.valor_total, pe.status_pedido, cl.nome_cliente
FROM Pedidos pe
INNER JOIN Clientes cl ON pe.id_cliente = cl.id_cliente
ORDER BY cl.nome_cliente;

--3. Encontre produtos com nome do fornecedor e cidade.
SELECT pr.id_produto, pr.nome_produto, pr.descricao_produto, pr.preco, pr.estoque, fo.nome_fornecedor, fo.cidade
FROM Produtos pr
INNER JOIN Fornecedores fo ON pr.id_fornecedor = fo.id_fornecedor
ORDER BY pr.nome_produto;

--4. Liste avaliações com nome do cliente e nome do produto.
SELECT 
	av.id_avaliacao, 
	av.nota, 
	av.comentario, 
	av.data_avaliacao, 
	cl.nome_cliente, 
	pr.nome_produto
FROM Avaliacoes av
INNER JOIN Clientes cl ON av.id_cliente = cl.id_cliente
INNER JOIN Produtos pr ON av.id_produto = pr.id_produto
ORDER BY Nome_Cliente;

--5. Mostre itens de pedido com nome do produto e nome do cliente.
SELECT 
	itp.id_pedido,
	itp.id_produto,
	itp.quantidade,
	itp.preco_unitario,
	itp.desconto,
	pr.nome_produto,
	cl.nome_cliente
FROM Itens_Pedido itp
INNER JOIN Pedidos pe ON itp.id_pedido = pe.id_pedido
INNER JOIN Produtos pr ON itp.id_produto = pr.id_produto
INNER JOIN Clientes cl ON pe.id_cliente = cl.id_cliente
ORDER BY cl.nome_cliente, itp.id_pedido;

--NÍVEL 5: LEFT JOIN (26-30)
--1. Liste TODOS os produtos e suas avaliações (se houver).
SELECT pr.id_produto AS 'ID Produto', 
	pr.nome_produto AS 'Nome do Produto', 
	pr.descricao_produto AS 'Descrição do Produto', 
	pr.preco AS 'Preço do Produto', 
	pr.estoque AS 'Quantidade no Estoque', 
	pr.data_cadastro AS 'Data de Cadastro', 
	pr.ativo AS 'Ativo', 
	av.nota AS 'Nota', 
	av.comentario AS 'Comentário', 
	cl.nome_cliente AS 'Nome do Cliente'
FROM Produtos pr
INNER JOIN Avaliacoes av ON pr.id_produto = av.id_produto
INNER JOIN Clientes cl ON av.id_cliente = cl.id_cliente
ORDER BY pr.id_produto;

--2. Mostre TODOS os clientes e seus pedidos (se houver).
SELECT cl.id_cliente,
	cl.nome_cliente,
	cl.cpf,
	cl.email,
	cl.telefone,
	cl.data_nascimento,
	cl.cidade,
	cl.estado,
	cl.data_cadastro,
	pe.id_pedido,
	pe.data_pedido,
	pe.valor_total,
	pe.status_pedido,
	pe.data_entrega
FROM Clientes cl
INNER JOIN Pedidos pe ON cl.id_cliente = pe.id_cliente
ORDER BY cl.nome_cliente;

--3. Encontre TODAS as categorias e quantos produtos têm.
SELECT
	ca.id_categoria,
	ca.nome_categoria,
	ca.descricao_categoria,
	COUNT(pr.id_categoria) AS 'Quantidade de Produtos'
FROM Categorias ca
INNER JOIN Produtos pr ON ca.id_categoria = pr.id_categoria
GROUP BY ca.id_categoria, ca.nome_categoria, ca.descricao_categoria
ORDER BY COUNT(pr.id_produto) DESC;

--4. Liste TODOS os fornecedores e quantos produtos fornecem.
SELECT fo.id_fornecedor,
	fo.nome_fornecedor,
	fo.cnpj,
	fo.cidade,
	fo.estado,
	fo.telefone,
	fo.email,
	COUNT(pr.id_produto) AS 'Quantidade de Produtos'
FROM Fornecedores fo 
LEFT JOIN Produtos pr ON fo.id_fornecedor = pr.id_fornecedor
GROUP BY fo.id_fornecedor, 
	fo.nome_fornecedor, 
	fo.cnpj, 
	fo.cidade, 
	fo.estado, 
	fo.telefone, 
	fo.email
ORDER BY COUNT(pr.id_produto) DESC;

--5. Mostre TODOS os produtos e a data do último pedido (se houver).
SELECT pr.id_produto,
	pr.nome_produto,
	pr.descricao_produto,
	pr.preco,
	pr.estoque,
	pr.data_cadastro,
	pr.ativo,
	MAX(pe.data_pedido) AS 'Último Pedido'
FROM Produtos pr
LEFT JOIN Itens_Pedido ipe ON pr.id_produto = ipe.id_produto
LEFT JOIN Pedidos pe ON ipe.id_pedido = pe.id_pedido
GROUP BY pr.id_produto,
	pr.nome_produto,
	pr.descricao_produto,
	pr.preco,
	pr.estoque,
	pr.data_cadastro,
	pr.ativo
ORDER BY MAX(pe.data_pedido) DESC;