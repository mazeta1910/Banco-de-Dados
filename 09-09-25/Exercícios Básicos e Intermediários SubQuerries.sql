--DIA 5 (08/09) - Subqueries B�sicas
--1. Encontre t�tulos dos livros da editora "Companhia das Letras".
--2. Liste usu�rios que pegaram emprestado o livro "1984".
--3. Selecione livros da mesma editora que publicou "Dom Casmurro".
--4. Encontre empr�stimos de livros do g�nero "Fic��o Cient�fica".
--5. Liste autores que t�m livros na editora "Rocco".
--6. Selecione usu�rios que pegaram livros do autor "Machado de Assis".
--7. Encontre livros mais caros que "O Corti�o".
--8. Liste editoras que publicaram livros ap�s 2015.
--9. Selecione empr�stimos de usu�rios de S�o Paulo (supondo campo cidade).
-- 10. Encontre livros do mesmo ano que "Harry Potter e a Pedra Filosofal".


-- 1. Encontre t�tulos dos livros da editora "Companhia das Letras".
SELECT TITULO
FROM LIVRO 
WHERE ID_EDITORA = (SELECT ID_EDITORA 
					FROM EDITORA
					WHERE NOME_EDITORA LIKE 'Companhia das Letras')

--2. Liste usu�rios que pegaram emprestado o livro "1984".
SELECT NOME_USUARIO
FROM USUARIO
WHERE ID_USUARIO IN (
    SELECT ID_USUARIO
	FROM EMPRESTIMO
	WHERE ID_LIVRO = (
        SELECT ID_LIVRO
		FROM LIVRO
		WHERE TITULO LIKE '1984'
));

--3. Selecione livros da mesma editora que publicou "Dom Casmurro".
SELECT TITULO
FROM LIVRO
WHERE ID_EDITORA = (
	SELECT ID_EDITORA
	FROM LIVRO
	WHERE TITULO LIKE 'Dom Casmurro');

-- 4. Encontre empr�stimos de livros do g�nero "Fic��o Cient�fica".
SELECT ID_EMPRESTIMO
FROM EMPRESTIMO
WHERE ID_LIVRO IN (
	SELECT ID_LIVRO
	FROM LIVRO
	WHERE GENERO LIKE 'Fic��o Cient�fica');

-- 5. Liste autores que t�m livros na editora "Rocco".
SELECT AUTOR
FROM LIVRO
WHERE ID_EDITORA IN (
	SELECT ID_EDITORA
	FROM EDITORA
	WHERE NOME_EDITORA LIKE 'ROCCO');

--6. Selecione usu�rios que pegaram livros do autor "Machado de Assis".
SELECT NOME_USUARIO
FROM USUARIO
WHERE ID_USUARIO IN (
	SELECT ID_USUARIO
	FROM EMPRESTIMO
	WHERE ID_LIVRO IN (
		SELECT ID_LIVRO
		FROM LIVRO
		WHERE AUTOR LIKE 'Machado de Assis'));

-- 7. Encontre livros mais caros que "O Corti�o".
SELECT TITULO
FROM LIVRO
WHERE PRECO > (
	SELECT PRECO
	FROM LIVRO
	WHERE TITULO LIKE 'O Corti�o');

--8. Liste editoras que publicaram livros ap�s 2015.
SELECT NOME_EDITORA
FROM EDITORA
WHERE ID_EDITORA IN (
	SELECT ID_EDITORA
	FROM LIVRO
	WHERE ANO_PUBLICACAO > 2015);

--9. Selecione empr�stimos de usu�rios que tenham feito empr�stimos antes de 2023.
SELECT ID_EMPRESTIMO
FROM EMPRESTIMO
WHERE ID_USUARIO IN (
	SELECT ID_USUARIO
	FROM USUARIO
	WHERE DATA_CADASTRO < '2023-01-01');

-- 10. Encontre livros do mesmo ano que "Harry Potter e a Pedra Filosofal".
SELECT TITULO
FROM LIVRO
WHERE ID_LIVRO IN (
	SELECT ID_LIVRO
	FROM LIVRO
	WHERE ANO_PUBLICACAO LIKE (
		SELECT ANO_PUBLICACAO
		FROM LIVRO
		WHERE TITULO LIKE 'Harry Potter e a Pedra Filosofal'));

------------------------------------------------------------------
--1. Liste usu�rios que NUNCA pegaram livros emprestados.
SELECT NOME_USUARIO
FROM USUARIO
WHERE ID_USUARIO NOT IN (
	SELECT ID_USUARIO
	FROM EMPRESTIMO
);
--2. Encontre livros que NUNCA foram emprestados.
SELECT TITULO
FROM LIVRO
WHERE ID_LIVRO NOT IN (
	SELECT ID_LIVRO
	FROM EMPRESTIMO
);
--3. Selecione editoras que N�O publicaram livros em 2024.
SELECT NOME_EDITORA
FROM EDITORA
WHERE ID_EDITORA NOT IN (
	SELECT ID_EDITORA
	FROM LIVRO
	WHERE ANO_PUBLICACAO = 2024
);
--4. Liste livros mais baratos que a m�dia de pre�os.
SELECT TITULO, PRECO, (SELECT AVG(PRECO) FROM LIVRO) AS MEDIA_PRECO
FROM LIVRO
WHERE PRECO < (SELECT AVG(PRECO) FROM LIVRO
);
--5. Encontre editoras com pelo menos um livro acima de R$ 100.
SELECT NOME_EDITORA
FROM EDITORA
WHERE ID_EDITORA IN (
	SELECT ID_EDITORA
	FROM LIVRO
	WHERE PRECO > 100
);
--6. Selecione empr�stimos de livros publicados antes de 2000.
SELECT ID_EMPRESTIMO
FROM EMPRESTIMO
WHERE ID_LIVRO IN (
	SELECT ID_LIVRO
	FROM LIVRO
	WHERE ANO_PUBLICACAO < 2000
);
--7. Liste usu�rios que pegaram livros de terror.
SELECT NOME_USUARIO
FROM USUARIO
WHERE ID_USUARIO IN (
	SELECT ID_USUARIO
	FROM EMPRESTIMO
	WHERE ID_LIVRO IN (
		SELECT ID_LIVRO
		FROM LIVRO
		WHERE GENERO LIKE 'TERROR'
));
--8. Encontre livros mais caros que "Dom Casmurro".
SELECT TITULO, PRECO
FROM LIVRO
WHERE PRECO > (
	SELECT PRECO
	FROM LIVRO
	WHERE TITULO LIKE 'Dom Casmurro'
);
--9. Liste usu�rios que se cadastraram depois do usu�rio "Juliana Rodrigues".
SELECT ID_USUARIO, NOME_USUARIO
FROM USUARIO
WHERE DATA_CADASTRO > ANY (
	SELECT DATA_CADASTRO
	FROM LIVRO
	WHERE NOME_USUARIO LIKE 'Maria Santos'
);

--10. Encontre livros de editoras brasileiras.
SELECT ID_LIVRO, TITULO, AUTOR, ANO_PUBLICACAO, GENERO, PRECO
FROM LIVRO
WHERE ID_EDITORA IN (
	SELECT ID_EDITORA
	FROM EDITORA
	WHERE PAIS LIKE 'Brasil'
);
