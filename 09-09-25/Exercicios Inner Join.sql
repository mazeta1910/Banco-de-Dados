--1. Liste título do livro e nome da editora.
SELECT L.TITULO, E.NOME_EDITORA
FROM LIVRO L
INNER JOIN EDITORA E ON L.ID_EDITORA = E.ID_EDITORA;

--2. Mostre nome do usuário e título do livro emprestado.
SELECT U.NOME_USUARIO, L.TITULO
FROM USUARIO U
INNER JOIN EMPRESTIMO E ON E.ID_USUARIO = U.ID_USUARIO
INNER JOIN LIVRO L ON L.ID_LIVRO = E.ID_LIVRO
ORDER BY U.NOME_USUARIO ASC;
--3. Junte livros com editoras, mostrando cidade da editora.
SELECT L.ID_LIVRO, L.TITULO, L.AUTOR, E.NOME_EDITORA, E.CIDADE
FROM LIVRO L
INNER JOIN EDITORA E ON E.ID_EDITORA = L.ID_EDITORA
ORDER BY L.TITULO;
--4. Liste empréstimos com nome do usuário e data.
SELECT L.TITULO, L.AUTOR, E.ID_USUARIO, E.DATA_EMPRESTIMO, U.NOME_USUARIO
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.ID_USUARIO = U.ID_USUARIO
INNER JOIN LIVRO L ON E.ID_LIVRO = L.ID_LIVRO
ORDER BY L.AUTOR;
--5. Mostre livros com editora e país da editora.
SELECT L.ID_LIVRO, L.TITULO, L.AUTOR, L.ANO_PUBLICACAO, E.ID_EDITORA, E.NOME_EDITORA, E.PAIS
FROM LIVRO L
INNER JOIN EDITORA E ON E.ID_EDITORA = L.ID_EDITORA
ORDER BY L.TITULO;
--6. Junte usuários com empréstimos, mostrando email.
SELECT U.NOME_USUARIO, U.EMAIL, U.TELEFONE, E.ID_EMPRESTIMO, E.DATA_EMPRESTIMO
FROM USUARIO U
INNER JOIN EMPRESTIMO E ON E.ID_USUARIO = U.ID_USUARIO
ORDER BY NOME_USUARIO;
--7. Liste livros com editora, ordenados por nome da editora.
--8. Mostre empréstimos com título do livro e autor.
--9. Junte todas as tabelas para um relatório completo.
--10. Liste livros brasileiros (editoras do Brasil).

