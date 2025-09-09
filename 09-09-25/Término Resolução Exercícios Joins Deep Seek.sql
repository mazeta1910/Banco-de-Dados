--Exerc�cios de JOIN - Com Colunas
--Espec�ficas
--INNER JOIN - "S� o que existe em ambas"
--LEFT JOIN - "Todos da esquerda + o que combina da direita"
--RIGHT JOIN - "Todos da direita + o que combina da
--esquerda"
--FULL OUTER JOIN - "Todos de ambas as tabelas"
--CROSS JOIN - "Todas as combina��es poss�veis"
--SELF JOIN - "Tabela com ela mesma"

--. LEFT JOIN - Quero TODAS as editoras, mesmo as sem empr�stimos
--. FULL OUTER JOIN - Quero TODOS os empr�stimos, mesmo com dados corrompidos
--. INNER JOIN - S� quero livros que REALMENTE geraram receita
--. LEFT JOIN - Quero TODOS os usu�rios, mesmo os inativos
--. LEFT JOIN - Quero TODOS os livros, mesmo os nunca emprestados
--. INNER JOIN - S� quero multas com dados completos v�lidos
--. INNER JOIN - Quero vis�o de atividade real (dados v�lidos)
--. FULL OUTER JOIN - Quero tudo, mesmo dados inconsistentes

-- INNER JOIN --
--Mostre: titulo, nome_editora
--Liste t�tulo do livro e nome da editora.
--Motivo: S� quero livros que T�M editora cadastrada.
SELECT L.TITULO, E.NOME_EDITORA
FROM LIVRO L
INNER JOIN EDITORA E ON E.ID_EDITORA = L.ID_EDITORA;

--Mostre: nome_usuario, titulo, data_emprestimo
--Mostre nome do usu�rio, t�tulo do livro e data do empr�stimo.
--Motivo: S� quero empr�stimos que T�M usu�rio e livro v�lidos.
SELECT U.NOME_USUARIO, L.TITULO, E.DATA_EMPRESTIMO
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON U.ID_USUARIO = E.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = E.ID_LIVRO;

--. Mostre: titulo, nome_editora, pais
--Liste livros brasileiros (t�tulo + editora + pa�s = 'Brasil').
--Motivo: S� quero livros que T�M editora com pa�s definido.
SELECT L.TITULO, E.NOME_EDITORA, E.PAIS
FROM LIVRO L
INNER JOIN EDITORA E ON E.ID_EDITORA = L.ID_EDITORA
WHERE E.PAIS LIKE 'Brasil';

--. Mostre: nome_usuario, titulo, nome_editora, data_emprestimo
--Mostre empr�stimos com dados completos (usu�rio + livro + editora).
--Motivo: S� quero empr�stimos com TODOS os dados v�lidos.
SELECT U.NOME_USUARIO, L.TITULO, ED.NOME_EDITORA, EM.DATA_EMPRESTIMO
FROM EMPRESTIMO EM
INNER JOIN USUARIO U ON U.ID_USUARIO = EM.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = EM.ID_LIVRO
INNER JOIN EDITORA ED ON ED.ID_EDITORA = L.ID_EDITORA;

--. Mostre: titulo, autor, nome_editora
--Liste livros de terror com nome da editora (genero = 'Terror').
--Motivo: S� quero livros de terror que T�M editora cadastrada.
SELECT L.TITULO, L.AUTOR, ED.NOME_EDITORA
FROM LIVRO L
INNER JOIN EDITORA ED ON L.ID_EDITORA = ED.ID_EDITORA
WHERE L.GENERO LIKE 'Terror';

--Mostre: nome_usuario, titulo, preco
--Mostre usu�rios que pegaram livros caros (preco > ) com t�tulo do livro.
--Motivo: S� quero usu�rios que REALMENTE pegaram livros caros.
SELECT U.NOME_USUARIO, L.TITULO, L.PRECO
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON U.ID_USUARIO = E.ID_USUARIO
INNER JOIN LIVRO L ON E.ID_LIVRO = L.ID_LIVRO
WHERE L.PRECO > ( SELECT AVG(PRECO) FROM LIVRO);

--Mostre: nome_usuario, titulo, data_emprestimo, multa
--Liste empr�stimos com multa (multa > ) com dados do usu�rio e livro.
--Motivo: S� quero empr�stimos que T�M usu�rio e livro v�lidos.
SELECT U.NOME_USUARIO, L.TITULO, E.DATA_EMPRESTIMO, E.MULTA
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON U.ID_USUARIO = E.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = E.ID_LIVRO
WHERE E.MULTA > (SELECT AVG(MULTA) FROM EMPRESTIMO);

--Mostre: titulo, ano_publicacao, nome_editora, cidade
--Mostre livros publicados ap�s 2020 com cidade da editora.
--Motivo: S� quero livros recentes que T�M editora com cidade.
SELECT L.TITULO, L.ANO_PUBLICACAO, E.NOME_EDITORA, E.CIDADE
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA
WHERE L.ANO_PUBLICACAO > 2020 
  AND E.CIDADE IS NOT NULL;

------------------ LEFT JOIN ----------------------
--Mostre: titulo, data_emprestimo
--Liste TODOS os livros e suas datas de empr�stimo (se houver).
--Motivo: Quero ver TODOS os livros, mesmo os nunca emprestados (NULL).
SELECT L.TITULO, E.DATA_EMPRESTIMO
FROM LIVRO L
LEFT JOIN EMPRESTIMO E ON E.ID_LIVRO = L.ID_LIVRO;

--Mostre: nome_usuario, COUNT(emprestimos) AS total_emprestimos
--Mostre TODOS os usu�rios e quantos livros pegaram.
--Motivo: Quero ver TODOS os usu�rios, mesmo os que nunca pegaram ().
SELECT U.NOME_USUARIO, COUNT(E.ID_EMPRESTIMO) AS TOTAL_EMPRESTIMOS
FROM USUARIO U
LEFT JOIN EMPRESTIMO E ON E.ID_USUARIO = U.ID_USUARIO
GROUP BY U.NOME_USUARIO;

--Mostre: nome_editora, COUNT(livros) AS total_livros
--Liste TODAS as editoras e quantos livros publicaram.
--Motivo: Quero ver TODAS as editoras, mesmo as sem livros ().
SELECT E.NOME_EDITORA, COUNT(L.ID_LIVRO) AS TOTAL_LIVROS
FROM EDITORA E
LEFT JOIN LIVRO L ON E.ID_EDITORA = L.ID_EDITORA
GROUP BY E.NOME_EDITORA;

--Mostre: titulo, SUM(multa) AS total_multas
--Mostre TODOS os livros e o valor total de multas geradas.
--Motivo: Quero ver TODOS os livros, mesmo os sem multas (NULL/).
SELECT L.TITULO, SUM(E.MULTA) AS TOTAL_MULTAS
FROM LIVRO L
LEFT JOIN EMPRESTIMO E ON L.ID_LIVRO = E.ID_LIVRO
GROUP BY L.TITULO;

--. Mostre: nome_usuario, MAX(data_emprestimo) AS ultimo_emprestimo
--Liste TODOS os usu�rios e a data do �ltimo empr�stimo.
--Motivo: Quero ver TODOS os usu�rios, mesmo os inativos (NULL).
SELECT U.NOME_USUARIO, MAX(E.DATA_EMPRESTIMO) AS ULTIMO_EMPRESTIMO
FROM USUARIO U
LEFT JOIN EMPRESTIMO E ON E.ID_USUARIO = U.ID_USUARIO
GROUP BY U.NOME_USUARIO;

--. Mostre: nome_editora, AVG(preco) AS preco_medio
--Mostre TODAS as editoras e a m�dia de pre�os dos seus livros.
--Motivo: Quero ver TODAS as editoras, mesmo as sem livros (NULL).
SELECT E.NOME_EDITORA, AVG(L.PRECO) AS PRECO_MEDIO
FROM EDITORA E
LEFT JOIN LIVRO L ON L.ID_EDITORA = E.ID_EDITORA
GROUP BY E.NOME_EDITORA;

--. Mostre: titulo, data_devolucao
--Liste TODOS os livros e se foram devolvidos (data_devolucao).
--Motivo: Quero ver TODOS os livros, mesmo os nunca emprestados (NULL).
SELECT L.TITULO, E.DATA_DEVOLUCAO
FROM LIVRO L
LEFT JOIN EMPRESTIMO E ON L.ID_LIVRO = E.ID_LIVRO;

----------------- RIGHT JOIN ---------------------
--. Mostre: titulo, autor, data_emprestimo
--Mostre TODOS os empr�stimos e dados dos livros (mesmo livros deletados).
--Motivo: Quero ver TODOS os empr�stimos, mesmo de livros removidos (NULL).
SELECT L.TITULO, L.AUTOR, E.DATA_EMPRESTIMO
FROM LIVRO L
RIGHT JOIN EMPRESTIMO E ON E.ID_LIVRO = L.ID_LIVRO;

--. Mostre: nome_usuario, email, data_emprestimo
--Liste TODOS os empr�stimos e dados dos usu�rios (mesmo usu�rios deletados).
--Motivo: Quero ver TODOS os empr�stimos, mesmo de usu�rios removidos (NULL).
SELECT U.NOME_USUARIO, U.EMAIL, E.DATA_EMPRESTIMO
FROM USUARIO U
RIGHT JOIN EMPRESTIMO E ON U.ID_USUARIO = E.ID_USUARIO;

--. Mostre: data_emprestimo, data_devolucao, multa
--Mostre TODAS as multas e dados dos empr�stimos.
--Motivo: Quero ver TODAS as multas, mesmo de empr�stimos problem�ticos.
SELECT E.DATA_EMPRESTIMO, E.DATA_DEVOLUCAO, E.MULTA
FROM EMPRESTIMO E;

--. Mostre: nome_editora, cidade, data_emprestimo
--Liste TODOS os empr�stimos e dados das editoras.
--Motivo: Quero ver TODOS os empr�stimos, mesmo de editoras que sa�ram.
SELECT ED.NOME_EDITORA, ED.CIDADE, EM.DATA_EMPRESTIMO
FROM EDITORA ED
RIGHT JOIN LIVRO L ON ED.ID_EDITORA = L.ID_LIVRO
RIGHT JOIN EMPRESTIMO EM ON L.ID_LIVRO = EM.ID_LIVRO

-------------- FULL OUTER JOIN ---------------------
--. Mostre: titulo, data_emprestimo
--Mostre TODOS os livros E TODOS os empr�stimos.
--Motivo: Quero ver livros nunca emprestados E empr�stimos �rf�os.
SELECT L.TITULO, E.DATA_EMPRESTIMO
FROM LIVRO L
FULL OUTER JOIN EMPRESTIMO E ON E.ID_LIVRO = L.ID_LIVRO;

--. Mostre: nome_usuario, data_emprestimo
--Liste TODOS os usu�rios E TODOS os empr�stimos.
--Motivo: Quero ver usu�rios inativos E empr�stimos de usu�rios deletados.
SELECT U.NOME_USUARIO, E.DATA_EMPRESTIMO
FROM USUARIO U
FULL OUTER JOIN EMPRESTIMO E ON E.ID_USUARIO = U.ID_USUARIO;

--. Mostre: nome_editora, titulo
--Mostre TODAS as editoras E TODOS os livros.
--Motivo: Quero ver editoras sem livros E livros sem editora.
SELECT E.NOME_EDITORA, L.TITULO
FROM EDITORA E
FULL OUTER JOIN LIVRO L ON L.ID_EDITORA = E.ID_EDITORA;

--------------- CROSS JOIN -------------------
--. Mostre: nome_usuario, titulo
--Gere todas as combina��es poss�veis entre usu�rios e livros.
--Motivo: Para an�lise de recomenda��es (quem poderia pegar qual livro).
SELECT U.NOME_USUARIO, L.TITULO
FROM USUARIO U
CROSS JOIN LIVRO L;

--. Mostre: nome_editora, genero
--Mostre todas as combina��es entre editoras e g�neros liter�rios.
--Motivo: Para verificar quais editoras n�o publicam em certos g�neros.
SELECT E.NOME_EDITORA, L.GENERO
FROM EDITORA E
CROSS JOIN LIVRO L;