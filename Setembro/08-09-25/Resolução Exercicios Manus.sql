CREATE TABLE Editora(
ID_EDITORA int PRIMARY KEY IDENTITY(1,1),
NOME_EDITORA varchar(50) NOT NULL,
CIDADE varchar(50) NOT NULL,
PAIS varchar(50) NOT NULL
);

CREATE TABLE Usuario(
ID_USUARIO int PRIMARY KEY IDENTITY(1,1),
NOME_USUARIO varchar(100) NOT NULL,
EMAIL varchar(100) NOT NULL,
TELEFONE varchar(20) NOT NULL,
DATA_CADASTRO date NOT NULL
);

CREATE TABLE Livro(
ID_LIVRO int PRIMARY KEY IDENTITY(1,1),
TITULO varchar(100) NOT NULL,
AUTOR varchar(100) NOT NULL,
ANO_PUBLICACAO int NOT NULL CONSTRAINT CK_ANO_PUBLICACAO CHECK (ANO_PUBLICACAO > 0),
GENERO varchar(50) NOT NULL,
PRECO decimal NOT NULL CONSTRAINT CK_PRECO CHECK (PRECO > 0),
ID_EDITORA int NOT NULL,
CONSTRAINT FK_LIVROS_EDITORA FOREIGN KEY (ID_EDITORA) REFERENCES EDITORA(ID_EDITORA)
);

CREATE TABLE Emprestimo(
ID_EMPRESTIMO int PRIMARY KEY IDENTITY(1,1),
ID_LIVRO int NOT NULL,
ID_USUARIO int NOT NULL,
DATA_EMPRESTIMO date,
DATA_DEVOLUCAO date,
MULTA decimal NOT NULL,
CONSTRAINT FK_EMPRESTIMO_LIVRO FOREIGN KEY (ID_LIVRO) REFERENCES LIVRO(ID_LIVRO),
CONSTRAINT FK_EMPRESTIMO_USUARIO FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO)
);
------------------------ POPULANDO AS TABELAS -----------------------------------
-- INSERIR DADOS NA TABELA EDITORAS (SEM ESPECIFICAR ID_EDITORA)
INSERT INTO EDITORA (NOME_EDITORA, CIDADE, PAIS) VALUES
('EDITORA ABRIL', 'S�O PAULO', 'BRASIL'),
('COMPANHIA DAS LETRAS', 'RIO DE JANEIRO', 'BRASIL'),
('PENGUIN RANDOM HOUSE', 'NOVA YORK', 'EUA'),
('HARPERCOLLINS', 'LONDRES', 'REINO UNIDO'),
('EDITORA ARQUEIRO', 'BELO HORIZONTE', 'BRASIL'),
('SEXTANTE', 'PORTO ALEGRE', 'BRASIL'),
('INTR�NSECA', 'RIO DE JANEIRO', 'BRASIL'),
('ROCCO', 'S�O PAULO', 'BRASIL');

-- INSERIR DADOS NA TABELA LIVROS (SEM ESPECIFICAR ID_LIVRO)
INSERT INTO LIVRO (TITULO, AUTOR, ANO_PUBLICACAO, GENERO, PRECO, ID_EDITORA) VALUES
('DOM CASMURRO', 'MACHADO DE ASSIS', 1899, 'ROMANCE', 29.90, 1),
('O CORTI�O', 'ALU�SIO AZEVEDO', 1890, 'ROMANCE', 35.50, 2),
('1984', 'GEORGE ORWELL', 1949, 'FIC��O CIENT�FICA', 42.90, 3),
('ORGULHO E PRECONCEITO', 'JANE AUSTEN', 1813, 'ROMANCE', 38.75, 4),
('O PEQUENO PR�NCIPE', 'ANTOINE DE SAINT-EXUP�RY', 1943, 'INFANTIL', 25.00, 3),
('HARRY POTTER E A PEDRA FILOSOFAL', 'J.K. ROWLING', 1997, 'FANTASIA', 49.90, 4),
('A MORENINHA', 'JOAQUIM MANUEL DE MACEDO', 1844, 'ROMANCE', 32.00, 1),
('O HOBBIT', 'J.R.R. TOLKIEN', 1937, 'FANTASIA', 45.80, 3),
('O ALQUIMISTA', 'PAULO COELHO', 1988, 'FIC��O', 39.90, 5),
('CEM ANOS DE SOLID�O', 'GABRIEL GARC�A M�RQUEZ', 1967, 'REALISMO M�GICO', 55.00, 2),
('O SENHOR DOS AN�IS', 'J.R.R. TOLKIEN', 1954, 'FANTASIA', 89.90, 3),
('A REVOLU��O DOS BICHOS', 'GEORGE ORWELL', 1945, 'F�BULA', 31.50, 3),
('O GUIA DO MOCHILEIRO DAS GAL�XIAS', 'DOUGLAS ADAMS', 1979, 'FIC��O CIENT�FICA', 37.25, 4),
('O NOME DO VENTO', 'PATRICK ROTHFUSS', 2007, 'FANTASIA', 62.00, 3),
('IT: A COISA', 'STEPHEN KING', 1986, 'TERROR', 67.90, 6);

-- INSERIR DADOS NA TABELA USUARIOS (SEM ESPECIFICAR ID_USUARIO)
INSERT INTO USUARIO (NOME_USUARIO, EMAIL, TELEFONE, DATA_CADASTRO) VALUES
('ANA SILVA', 'ANA.SILVA@EMAIL.COM', '(11) 99999-1111', '2023-01-15'),
('CARLOS OLIVEIRA', 'CARLOS.OLIVEIRA@EMAIL.COM', '(21) 98888-2222', '2023-02-20'),
('MARIA SANTOS', 'MARIA.SANTOS@EMAIL.COM', '(31) 97777-3333', '2023-03-10'),
('JO�O PEREIRA', 'JO�O.PEREIRA@EMAIL.COM', '(11) 96666-4444', '2023-01-25'),
('FERNANDA COSTA', 'FERNANDA.COSTA@EMAIL.COM', '(21) 95555-5555', '2023-04-05'),
('RICARDO ALMEIDA', 'RICARDO.ALMEIDA@EMAIL.COM', '(31) 94444-6666', '2023-02-15'),
('JULIANA RODRIGUES', 'JULIANA.RODRIGUES@EMAIL.COM', '(11) 93333-7777', '2023-05-12'),
('PEDRO MENDES', 'PEDRO.MENDES@EMAIL.COM', '(21) 92222-8888', '2023-03-22'),
('AMANDA FERREIRA', 'AMANDA.FERREIRA@EMAIL.COM', '(31) 91111-9999', '2023-04-18'),
('BRUNO CARVALHO', 'BRUNO.CARVALHO@EMAIL.COM', '(11) 90000-0000', '2023-01-08');

-- INSERIR DADOS NA TABELA EMPRESTIMOS (SEM ESPECIFICAR ID_EMPRESTIMO)
INSERT INTO EMPRESTIMO (ID_LIVRO, ID_USUARIO, DATA_EMPRESTIMO, DATA_DEVOLUCAO, MULTA) VALUES
(3, 1, '2024-01-10', '2024-01-20', 0.00),
(6, 2, '2024-01-12', '2024-01-25', 0.00),
(1, 3, '2024-01-15', '2024-02-05', 15.50),
(8, 4, '2024-01-18', '2024-01-28', 0.00),
(12, 5, '2024-01-20', '2024-02-10', 12.00),
(15, 6, '2024-01-22', '2024-02-01', 0.00),
(9, 7, '2024-01-25', '2024-02-15', 18.75),
(4, 8, '2024-01-28', '2024-02-08', 0.00),
(11, 9, '2024-02-01', '2024-02-20', 25.00),
(2, 10, '2024-02-05', '2024-02-15', 0.00),
(5, 1, '2024-02-10', '2024-02-25', 7.50),
(7, 2, '2024-02-12', '2024-02-22', 0.00),
(10, 3, '2024-02-15', NULL, 0.00),
(13, 4, '2024-02-18', NULL, 0.00),
(14, 5, '2024-02-20', '2024-03-05', 0.00);

-- DADOS ADICIONAIS PARA TESTES
INSERT INTO EMPRESTIMO (ID_LIVRO, ID_USUARIO, DATA_EMPRESTIMO, DATA_DEVOLUCAO, MULTA) VALUES
(3, 6, '2024-03-01', '2024-03-15', 0.00),
(6, 7, '2024-03-05', NULL, 0.00),
(8, 8, '2024-03-08', '2024-03-20', 5.00),
(1, 9, '2024-03-10', NULL, 0.00),
(12, 10, '2024-03-12', '2024-03-25', 0.00);

-- INSERIR MAIS LIVROS
INSERT INTO LIVRO (TITULO, AUTOR, ANO_PUBLICACAO, GENERO, PRECO, ID_EDITORA) VALUES
('DUNA', 'FRANK HERBERT', 1965, 'FIC��O CIENT�FICA', 69.90, 3),
('O PODER DO H�BITO', 'CHARLES DUHIGG', 2012, 'AUTOAJUDA', 44.50, 6),
('MINDSET', 'CAROL S. DWECK', 2006, 'PSICOLOGIA', 39.90, 7),
('O HOMEM DE GIZ', 'C.J. TUDOR', 2018, 'SUSPENSE', 52.00, 8),
('A PACIENTE SILENCIOSA', 'ALEX MICHAELIDES', 2019, 'THRILLER', 47.80, 5);

------------------------ EXERC�CIOS 05/09/2025 ----------------------------------
--DIA 1 (04/09) - SELECT B�sico e WHERE
--1. Selecione todos os campos da tabela Livros .
--2. Liste apenas o t�tulo e autor de todos os livros.
--3. Mostre o nome e email de todos os usu�rios.
--4. Encontre todos os livros do autor "Stephen King".
--5. Liste os livros do g�nero "Terror".
--6. Selecione os usu�rios cadastrados em 2025.
--7. Encontre livros com pre�o maior que R$ 50,00.
--8. Liste editoras da cidade "S�o Paulo".
--9. Mostre empr�stimos com multa maior que zero.
--10. Selecione livros publicados no ano 2020.

-- --1. Selecione todos os campos da tabela Livros .
SELECT *
FROM LIVRO;

--2. Liste apenas o t�tulo e autor de todos os livros.
SELECT TITULO, AUTOR
FROM LIVRO;

--3. Mostre o nome e email de todos os usu�rios
SELECT NOME_USUARIO, EMAIL
FROM USUARIO;

--4. Encontre todos os livros do autor Stephen King
SELECT *
FROM LIVRO
WHERE AUTOR LIKE 'Stephen King';

--5. Liste os livros do g�nero terror.
SELECT *
FROM LIVRO
WHERE GENERO LIKE 'TERROR';

-- 6. Selecione todos os usu�rios cadastrados em 2025.
SELECT *
FROM USUARIO
WHERE DATA_CADASTRO >= '2025-01-01';

-- 7. Liste livros com pre�o maior que R$ 50,00;
SELECT *
FROM LIVRO
WHERE PRECO > 50;

-- 8. Liste editoras da cidade "S�o Paulo"
SELECT *
FROM EDITORA
WHERE CIDADE LIKE 'S�o Paulo';

-- 9. Mostre empr�stimos com multa maior que zero.
SELECT *
FROM EMPRESTIMO
WHERE MULTA > 0;

-- 10. Selecione livros publicados no ano 2020.
SELECT *
FROM LIVRO
WHERE ANO_PUBLICACAO = 2020;

-- 11. Liste todos os livros ordenados por t�tulo (A-Z)
SELECT * 
FROM LIVRO
ORDER BY TITULO ASC;

-- 12. Mostre usu�rios ordenados por data de cadastro (mais recente primeiro).
SELECT *
FROM USUARIO
ORDER BY DATA_CADASTRO DESC;

-- 13. Ordene livros por pre�o (do mais caro para o mais barato)
SELECT *
FROM LIVRO
ORDER BY PRECO DESC;

-- 14. Liste editoras em ordem alfab�tica por nome.
SELECT *
FROM EDITORA
ORDER BY NOME_EDITORA;

-- 15. Encontre livros publicados ap�s 2010 e do g�nero "Fic��o".
SELECT *
FROM LIVRO
WHERE ANO_PUBLICACAO > 2010 AND GENERO LIKE 'Fic��o';

-- 16. Selecione usu�rios cujo nome come�a com "A" ou "B".
SELECT *
FROM USUARIO
WHERE NOME_USUARIO LIKE 'A%' OR NOME_USUARIO LIKE 'B%';

-- 17. Liste livros que n�o s�o do autor Dan Brown.
SELECT *
FROM LIVRO
WHERE AUTOR NOT LIKE 'Dan Brown';

-- 18. Encontre empr�stimos com multa entre R$5,00 e R$20,00.
SELECT *
FROM EMPRESTIMO
WHERE MULTA BETWEEN 5 AND 20;

-- 19. Mostre livros com pre�o menor que R$ 30,00, ordenados por ano.
SELECT *
FROM LIVRO
WHERE PRECO < 30
ORDER BY ANO_PUBLICACAO;

-- 20. Liste usu�rios que n�o tem telefone cadastrado.
SELECT *
FROM USUARIO
WHERE TELEFONE IS NULL;

-- 21. Encontre livros dos autores "George Orwell", "Isaac Asimov" e "Ray Bradbury"
SELECT *
FROM LIVRO
WHERE AUTOR IN ('George Orwell', 'Isaac Asimov', 'Ray Bradbury');

-- 22. Liste livros que n�o s�o dos g�neros Romance, Autoajuda, Religi�o.
SELECT *
FROM LIVRO
WHERE GENERO NOT IN ('Romance', 'Autoajuda', 'Religi�o');

-- 23. Selecione editoras das cidades Rio de Janeiro, Belo Horizonte ou Porto Alegre.
SELECT *
FROM EDITORA
WHERE CIDADE IN ('Rio de Janeiro', 'Belo Horizonte', 'Porto Alegre');

-- 24. Encontre usu�rios com IDs 10, 25, 30, 45 e 60.
SELECT *
FROM USUARIO
WHERE ID_USUARIO IN (10, 20, 25, 30, 45, 60);

-- 25. Liste livros cujo t�tulo come�a com O.
SELECT *
FROM LIVRO
WHERE TITULO LIKE 'O%';

-- 26. Encontre usu�rios cujo nome termina com "Silva"
SELECT *
FROM USUARIO
WHERE NOME_USUARIO LIKE '%Silva';

-- 27. Selecione livros cujo t�tulo cont�m a palavra amor.
SELECT *
FROM LIVRO
WHERE TITULO LIKE '%amor%';

-- 28. Liste editoras cujo nome cont�m "Editora"
SELECT *
FROM EDITORA
WHERE NOME_EDITORA LIKE '%EDITORA%';

-- 29. Encontre usu�rios com email que cont�m hotmail.
SELECT *
FROM USUARIO
WHERE EMAIL LIKE '%HOTMAIL%'

-- 30. Mostre livros em que o autor cont�m J (inicial do meio)
SELECT *
FROM LIVRO
WHERE AUTOR LIKE '% J. %';

-- 31. Selecione livros publicados entre 1990 e 2000.
SELECT *
FROM LIVRO
WHERE ANO_PUBLICACAO BETWEEN '1990' AND '2000';

-- 32. Encontre empr�stimos feitos entre '2025-01-01' e '2025-06-30'
SELECT *
FROM EMPRESTIMO
WHERE DATA_EMPRESTIMO BETWEEN '2025-01-01' AND '2025-06-30';

-- 33. Liste livros com pre�o entre 20,00 e 40,00
SELECT *
FROM LIVRO
WHERE PRECO BETWEEN 20 AND 40;

-- 34. Mostre usu�rios cadastrados entre '2024-01-01' e '2024-12-31'
SELECT *
FROM USUARIO
WHERE DATA_CADASTRO BETWEEN '2024-01-01' AND '2024-12-31';

-- 35. Encontre livros cujo t�tulo tem exatamente 5 caracteres.
SELECT *
FROM LIVRO
WHERE TITULO LIKE '_____';

-- 36. Liste usu�rios cujo telefone come�a com "11" 
SELECT *
FROM USUARIO
WHERE TELEFONE LIKE '(11)%';

-- 37. Selecione livros cujo autor tem sobrenome Santos
SELECT *
FROM LIVRO
WHERE AUTOR LIKE '% SANTOS%';

-- 38. Encontre editoras de pa�ses que come�am com B.
SELECT *
FROM EDITORA
WHERE PAIS LIKE 'B%';

-- 39. Liste empr�stimos com multa entre 0,01 e 10,00.
SELECT *
FROM EMPRESTIMO
WHERE MULTA BETWEEN '0.01' AND '10';

-- 40. Mostre livros cujo t�tulo cont�m n�meros.
SELECT *
FROM LIVRO
WHERE TITULO LIKE '%[0-9]%';

---- 41. Encontre t�tulos dos livros da editora "Companhia das Letras".
--SELECT L.TITULO, L.AUTOR, L.PRECO, E.NOME_EDITORA
--FROM LIVRO L
--INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA
--WHERE E.NOME_EDITORA LIKE 'COMPANHIA DAS LETRAS'
--ORDER BY L.TITULO;

---- 42. Liste usu�rios que pegaram emprestado o livro 1984.
--SELECT U.NOME, U.CPF, U.DATA_CADASTRO
--FROM USUARIO U
--INNER JOIN EMPRESTIMO E ON U.ID_USUARIO = E.ID_USUARIO
--WHERE E.ID_LIVRO FROM 

-- 41. Encontre o livro mais caro
SELECT *
FROM LIVRO
WHERE PRECO = (SELECT MAX(PRECO) FROM LIVRO);

-- 42. Encontre o livro mais barato.
SELECT *
FROM LIVRO
WHERE PRECO = (SELECT MIN(PRECO) FROM LIVRO);

-- 43. Liste livros com pre�o acima da m�dia.
SELECT *
FROM LIVRO
WHERE PRECO > (SELECT AVG(PRECO) FROM LIVRO);

-- 44. Liste livros com pre�o abaixo da m�dia.
SELECT *
FROM LIVRO 
WHERE PRECO < (SELECT AVG(PRECO) FROM LIVRO);

-- 45. Encontre o usu�rio mais antigo (primeira data de cadastro).
SELECT *
FROM USUARIO
WHERE DATA_CADASTRO = (SELECT MIN(DATA_CADASTRO) FROM USUARIO);

-- 46. Encontre t�tulos dos livros da editora "Rocco".
SELECT L.TITULO, L.AUTOR, L.ANO_PUBLICACAO, L.GENERO, L.PRECO
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA
WHERE E.NOME_EDITORA LIKE 'Rocco'
ORDER BY L.TITULO;

------------------------ EXERC�CIOS INNER JOIN ----------------------------------
-- 1. Liste t�tulo do livro e nome da editora.
SELECT L.TITULO, E.NOME_EDITORA
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA

-- 2. Mostre o nome do usu�rio e t�tulo do livro emprestado.
SELECT U.NOME_USUARIO, L.TITULO
FROM USUARIO U
INNER JOIN EMPRESTIMO EMP ON U.ID_USUARIO = EMP.ID_USUARIO
INNER JOIN LIVRO L ON EMP.ID_LIVRO = L.ID_LIVRO;

-- 3. Mostre livros brasileiros (titulo, editora, pais)
SELECT L.TITULO, E.NOME_EDITORA, E.PAIS
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA
WHERE E.PAIS LIKE 'BRASIL'
ORDER BY L.TITULO;

-- 1. Liste t�tulo do livro e nome da editora.
SELECT L.TITULO, E.NOME_EDITORA
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA

-- 2. Mostre o nome do usu�rio e t�tulo do livro emprestado.
SELECT U.NOME_USUARIO, L.TITULO
FROM USUARIO U
INNER JOIN EMPRESTIMO E ON E.ID_USUARIO = U.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = E.ID_LIVRO

-- 3. Mostre livros brasileiros (titulo, editora, pais)
SELECT L.TITULO, E.NOME_EDITORA, E.PAIS
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA
WHERE E.PAIS LIKE 'Brasil'
ORDER BY L.TITULO;

-- 4. Mostre empr�stimos com dados completos (usu�rio, livro, editora)
SELECT U.USUARIO, L.TITULO, E.NOME_EDITORA
FROM USUARIO U
INNER JOIN 