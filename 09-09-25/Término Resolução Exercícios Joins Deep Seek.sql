--Exercícios de JOIN - Com Colunas
--Específicas
--INNER JOIN - "Só o que existe em ambas"
--LEFT JOIN - "Todos da esquerda + o que combina da direita"
--RIGHT JOIN - "Todos da direita + o que combina da
--esquerda"
--FULL OUTER JOIN - "Todos de ambas as tabelas"
--CROSS JOIN - "Todas as combinações possíveis"
--SELF JOIN - "Tabela com ela mesma"

--. LEFT JOIN - Quero TODAS as editoras, mesmo as sem empréstimos
--. FULL OUTER JOIN - Quero TODOS os empréstimos, mesmo com dados corrompidos
--. INNER JOIN - Só quero livros que REALMENTE geraram receita
--. LEFT JOIN - Quero TODOS os usuários, mesmo os inativos
--. LEFT JOIN - Quero TODOS os livros, mesmo os nunca emprestados
--. INNER JOIN - Só quero multas com dados completos válidos
--. INNER JOIN - Quero visão de atividade real (dados válidos)
--. FULL OUTER JOIN - Quero tudo, mesmo dados inconsistentes

-- INNER JOIN --
--Mostre: titulo, nome_editora
--Liste título do livro e nome da editora.
--Motivo: Só quero livros que TÊM editora cadastrada.
SELECT L.TITULO, E.NOME_EDITORA
FROM LIVRO L
INNER JOIN EDITORA E ON E.ID_EDITORA = L.ID_EDITORA;

--Mostre: nome_usuario, titulo, data_emprestimo
--Mostre nome do usuário, título do livro e data do empréstimo.
--Motivo: Só quero empréstimos que TÊM usuário e livro válidos.
SELECT U.NOME_USUARIO, L.TITULO, E.DATA_EMPRESTIMO
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON U.ID_USUARIO = E.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = E.ID_LIVRO;

--. Mostre: titulo, nome_editora, pais
--Liste livros brasileiros (título + editora + país = 'Brasil').
--Motivo: Só quero livros que TÊM editora com país definido.
SELECT L.TITULO, E.NOME_EDITORA, E.PAIS
FROM LIVRO L
INNER JOIN EDITORA E ON E.ID_EDITORA = L.ID_EDITORA
WHERE E.PAIS LIKE 'Brasil';

--. Mostre: nome_usuario, titulo, nome_editora, data_emprestimo
--Mostre empréstimos com dados completos (usuário + livro + editora).
--Motivo: Só quero empréstimos com TODOS os dados válidos.
SELECT U.NOME_USUARIO, L.TITULO, ED.NOME_EDITORA, EM.DATA_EMPRESTIMO
FROM EMPRESTIMO EM
INNER JOIN USUARIO U ON U.ID_USUARIO = EM.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = EM.ID_LIVRO
INNER JOIN EDITORA ED ON ED.ID_EDITORA = L.ID_EDITORA;

--. Mostre: titulo, autor, nome_editora
--Liste livros de terror com nome da editora (genero = 'Terror').
--Motivo: Só quero livros de terror que TÊM editora cadastrada.
SELECT L.TITULO, L.AUTOR, ED.NOME_EDITORA
FROM LIVRO L
INNER JOIN EDITORA ED ON L.ID_EDITORA = ED.ID_EDITORA
WHERE L.GENERO LIKE 'Terror';

--Mostre: nome_usuario, titulo, preco
--Mostre usuários que pegaram livros caros (preco > ) com título do livro.
--Motivo: Só quero usuários que REALMENTE pegaram livros caros.
SELECT U.NOME_USUARIO, L.TITULO, L.PRECO
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON U.ID_USUARIO = E.ID_USUARIO
INNER JOIN LIVRO L ON E.ID_LIVRO = L.ID_LIVRO
WHERE L.PRECO > ( SELECT AVG(PRECO) FROM LIVRO);

--Mostre: nome_usuario, titulo, data_emprestimo, multa
--Liste empréstimos com multa (multa > ) com dados do usuário e livro.
--Motivo: Só quero empréstimos que TÊM usuário e livro válidos.
SELECT U.NOME_USUARIO, L.TITULO, E.DATA_EMPRESTIMO, E.MULTA
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON U.ID_USUARIO = E.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = E.ID_LIVRO
WHERE E.MULTA > (SELECT AVG(MULTA) FROM EMPRESTIMO);

--Mostre: titulo, ano_publicacao, nome_editora, cidade
--Mostre livros publicados após 2020 com cidade da editora.
--Motivo: Só quero livros recentes que TÊM editora com cidade.
SELECT L.TITULO, L.ANO_PUBLICACAO, E.NOME_EDITORA, E.CIDADE
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA
WHERE L.ANO_PUBLICACAO > 2020 
  AND E.CIDADE IS NOT NULL;

------------------ LEFT JOIN ----------------------
--Mostre: titulo, data_emprestimo
--Liste TODOS os livros e suas datas de empréstimo (se houver).
--Motivo: Quero ver TODOS os livros, mesmo os nunca emprestados (NULL).
SELECT L.TITULO, E.DATA_EMPRESTIMO
FROM LIVRO L
LEFT JOIN EMPRESTIMO E ON E.ID_LIVRO = L.ID_LIVRO;

--Mostre: nome_usuario, COUNT(emprestimos) AS total_emprestimos
--Mostre TODOS os usuários e quantos livros pegaram.
--Motivo: Quero ver TODOS os usuários, mesmo os que nunca pegaram ().
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
--Liste TODOS os usuários e a data do último empréstimo.
--Motivo: Quero ver TODOS os usuários, mesmo os inativos (NULL).
SELECT U.NOME_USUARIO, MAX(E.DATA_EMPRESTIMO) AS ULTIMO_EMPRESTIMO
FROM USUARIO U
LEFT JOIN EMPRESTIMO E ON E.ID_USUARIO = U.ID_USUARIO
GROUP BY U.NOME_USUARIO;

--. Mostre: nome_editora, AVG(preco) AS preco_medio
--Mostre TODAS as editoras e a média de preços dos seus livros.
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
--Mostre TODOS os empréstimos e dados dos livros (mesmo livros deletados).
--Motivo: Quero ver TODOS os empréstimos, mesmo de livros removidos (NULL).
SELECT L.TITULO, L.AUTOR, E.DATA_EMPRESTIMO
FROM LIVRO L
RIGHT JOIN EMPRESTIMO E ON E.ID_LIVRO = L.ID_LIVRO;

--. Mostre: nome_usuario, email, data_emprestimo
--Liste TODOS os empréstimos e dados dos usuários (mesmo usuários deletados).
--Motivo: Quero ver TODOS os empréstimos, mesmo de usuários removidos (NULL).
SELECT U.NOME_USUARIO, U.EMAIL, E.DATA_EMPRESTIMO
FROM USUARIO U
RIGHT JOIN EMPRESTIMO E ON U.ID_USUARIO = E.ID_USUARIO;

--. Mostre: data_emprestimo, data_devolucao, multa
--Mostre TODAS as multas e dados dos empréstimos.
--Motivo: Quero ver TODAS as multas, mesmo de empréstimos problemáticos.
SELECT E.DATA_EMPRESTIMO, E.DATA_DEVOLUCAO, E.MULTA
FROM EMPRESTIMO E;

--. Mostre: nome_editora, cidade, data_emprestimo
--Liste TODOS os empréstimos e dados das editoras.
--Motivo: Quero ver TODOS os empréstimos, mesmo de editoras que saíram.
SELECT ED.NOME_EDITORA, ED.CIDADE, EM.DATA_EMPRESTIMO
FROM EDITORA ED
RIGHT JOIN LIVRO L ON ED.ID_EDITORA = L.ID_LIVRO
RIGHT JOIN EMPRESTIMO EM ON L.ID_LIVRO = EM.ID_LIVRO

-------------- FULL OUTER JOIN ---------------------
--. Mostre: titulo, data_emprestimo
--Mostre TODOS os livros E TODOS os empréstimos.
--Motivo: Quero ver livros nunca emprestados E empréstimos órfãos.
SELECT L.TITULO, E.DATA_EMPRESTIMO
FROM LIVRO L
FULL OUTER JOIN EMPRESTIMO E ON E.ID_LIVRO = L.ID_LIVRO;

--. Mostre: nome_usuario, data_emprestimo
--Liste TODOS os usuários E TODOS os empréstimos.
--Motivo: Quero ver usuários inativos E empréstimos de usuários deletados.
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
--Gere todas as combinações possíveis entre usuários e livros.
--Motivo: Para análise de recomendações (quem poderia pegar qual livro).
SELECT U.NOME_USUARIO, L.TITULO
FROM USUARIO U
CROSS JOIN LIVRO L;

--. Mostre: nome_editora, genero
--Mostre todas as combinações entre editoras e gêneros literários.
--Motivo: Para verificar quais editoras não publicam em certos gêneros.
SELECT E.NOME_EDITORA, L.GENERO
FROM EDITORA E
CROSS JOIN LIVRO L;