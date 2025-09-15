SELECT *
FROM Novela

-- 1. POPULAR TABELA NOVELA (tabela independente)
INSERT INTO Novela (NOME_NOVELA, DATA_PRIMEIRO_CAPITULO, DATA_ULTIMO_CAPITULO, HORARIO_EXIBICAO)
VALUES
('Avenida Brasil', '2012-03-26', '2012-10-19', '21:00'),
('Pantanal', '2022-03-28', '2022-10-07', '21:15'),
('Mulheres de Areia', '1993-02-08', '1993-08-27', '20:00'),
('O Clone', '2001-10-01', '2002-06-15', '21:30'),
('Tieta', '1989-08-25', '1990-04-13', '20:30');

-- 2. POPULAR TABELA ATOR (tabela independente)
INSERT INTO Ator (NOME_ATOR, IDADE, CIDADE_ATOR, SALARIO_ATOR, SEXO_ATOR)
VALUES
('Murilo Benício', 52, 'Rio de Janeiro', 85000.00, 'M'),
('Deborah Secco', 44, 'Rio de Janeiro', 78000.00, 'F'),
('Osmar Prado', 75, 'São Paulo', 65000.00, 'M'),
('Gloria Pires', 60, 'Rio de Janeiro', 92000.00, 'F'),
('Vera Fischer', 73, 'Blumenau', 68000.00, 'F'),
('Marcos Palmeira', 58, 'Rio de Janeiro', 72000.00, 'M'),
('Camila Queiroz', 31, 'São Paulo', 45000.00, 'F'),
('Johnny Massaro', 29, 'São Paulo', 42000.00, 'M'),
('Tony Ramos', 76, 'Aimorés', 95000.00, 'M'),
('Adriana Esteves', 55, 'Rio de Janeiro', 88000.00, 'F');

-- 3. POPULAR TABELA CAPITULOS (tabela dependente - precisa de código da novela)
INSERT INTO Capitulos (NOME_CAPITULO, DATA_EXIBICAO_CAPITULO, CODIGO_NOVELA)
VALUES
('Capítulo 1 - O Início', '2012-03-26', 1),
('Capítulo 2 - Segredos Revelados', '2012-03-27', 1),
('Capítulo 3 - O Reencontro', '2012-03-28', 1),
('Capítulo 1 - A Chegada ao Pantanal', '2022-03-28', 2),
('Capítulo 2 - Os Mistérios da Natureza', '2022-03-29', 2),
('Capítulo 1 - As Irmãs Gêmeas', '1993-02-08', 3),
('Capítulo 1 - A Chegada do Clone', '2001-10-01', 4),
('Capítulo 1 - O Retorno de Tieta', '1989-08-25', 5),
('Capítulo Final - O Desfecho', '2012-10-19', 1),
('Capítulo Final - O Último Episódio', '2022-10-07', 2);

-- 4. POPULAR TABELA PERSONAGEM (tabela dependente - precisa apenas do código do ator)
INSERT INTO Personagem (NOME_PERSONAGEM, IDADE_PERSONAGEM, SITUACAO_FINANCEIRA_PERSONAGEM, CODIGO_ATOR)
VALUES
('Jorge Aragão', 45, 'Classe Média', 6),
('Maria Bruaca', 35, 'Pobre', 7),
('Joventino', 28, 'Pobre', 8),
('Zé Leôncio', 60, 'Rico', 9),
('Filó', 55, 'Classe Média', 10),
('Tufão', 40, 'Rico', 1),
('Carminha', 38, 'Classe Média', 2),
('Hercules', 65, 'Rico', 3),
('Silvana', 35, 'Rico', 4),
('Noêmia', 50, 'Rico', 5);

-- 5. POPULAR TABELA NOVELA_ATOR (tabela de relacionamento muitos-para-muitos)
-- 5. POPULAR TABELA NOVELAPERSONAGEM (tabela de relacionamento muitos-para-muitos)
INSERT INTO NovelaPersonagem (CODIGO_NOVELA, CODIGO_PERSONAGEM)
VALUES
(1, 1),   -- Novela 1, Personagem 1 (Tufão)
(1, 2),   -- Novela 1, Personagem 2 (Carminha)
(1, 3),   -- Novela 1, Personagem 3 (Hercules)
(1, 4),   -- Novela 1, Personagem 4 (Silvana)
(1, 5),   -- Novela 1, Personagem 5 (Noêmia)
(2, 6),   -- Novela 2, Personagem 6 (Jorge Aragão)
(2, 7),   -- Novela 2, Personagem 7 (Maria Bruaca)
(2, 8),   -- Novela 2, Personagem 8 (Joventino)
(2, 9),   -- Novela 2, Personagem 9 (Zé Leôncio)
(2, 10),  -- Novela 2, Personagem 10 (Filó)
(3, 4),   -- Novela 3, Personagem 4 (Silvana como Ruth/Raquel)
(3, 5),   -- Novela 3, Personagem 5 (Noêmia como Tônia)
(4, 4),   -- Novela 4, Personagem 4 (Silvana como Jade)
(4, 1),   -- Novela 4, Personagem 1 (Tufão como Lucas/Diego)
(5, 5);   -- Novela 5, Personagem 5 (Noêmia como Tieta)

-----------------------------------

-- 1) Encontre a data de exibição do último capítulo para a novela Ti-ti-ti.
SELECT DATA_ULTIMO_CAPITULO
FROM NOVELA
WHERE NOME_NOVELA LIKE 'Ti-ti-ti';

--- 2) Encontre o nome de todos os atores que morem em cidades que comecem com a letra "M".
SELECT *
FROM ATOR
WHERE CIDADE_ATOR LIKE 'M%';

--- 3) Encontre a quantidade de novelas que tenham como parte do nome a palavra "vida"
SELECT CODIGO_NOVELA, NOME_NOVELA, COUNT(CODIGO_NOVELA) AS QUANTIDADE
FROM NOVELA
WHERE NOME_NOVELA LIKE '%vida%'
GROUP BY CODIGO_NOVELA, NOME_NOVELA;

--- 6) Encontre a quantidade de novelas que o ator Fernando Souza participou.
SELECT N.CODIGO_NOVELA, N.NOME_NOVELA, COUNT(DISTINCT N.CODIGO_NOVELA) AS QUANTIDADE
FROM NOVELA N
LEFT JOIN NovelaPersonagem NP ON NP.CODIGO_NOVELA = N.CODIGO_NOVELA
LEFT JOIN Personagem P ON NP.CODIGO_PERSONAGEM = P.CODIGO_PERSONAGEM
LEFT JOIN Ator A ON A.CODIGO_ATOR = P.CODIGO_ATOR
WHERE A.NOME_ATOR LIKE 'Fernando Souza'
GROUP BY N.CODIGO_NOVELA, N.NOME_NOVELA;

--- 7) Selecione todos os campos da tabela tbPersonagem ordenados por nome em ordem crescente.
SELECT CODIGO_PERSONAGEM, NOME_PERSONAGEM, IDADE_PERSONAGEM, SITUACAO_FINANCEIRA_PERSONAGEM, CODIGO_ATOR
FROM PERSONAGEM
ORDER BY NOME_PERSONAGEM ASC;

-- 8) Selecione todos os campos da tabela tbPersonagem ordenados por idade em ordem decrescente.
SELECT *
FROM PERSONAGEM
ORDER BY IDADE_PERSONAGEM DESC;

-- 9) Selecione quantos atores existem cadastrados.
SELECT COUNT(CODIGO_ATOR) AS QUANTIDADE_ATORES
FROM ATOR;

-- 10) Selecione quantos capítulos existem por novela. Retorne o nome da novela e a 
-- quantidade de capítulos para a novela.
SELECT N.NOME_NOVELA, COUNT(C.CODIGO_CAPITULO) AS QTD_CAPITULOS
FROM NOVELA N 
LEFT JOIN CAPITULOS C ON N.CODIGO_NOVELA = C.CODIGO_NOVELA
GROUP BY N.NOME_NOVELA;

-- 11) Selecione quantos atores são do sexo feminino.
SELECT COUNT(CODIGO_ATOR) AS QTD_ATRIZES
FROM ATOR
WHERE SEXO_ATOR LIKE 'F';

-- 12) Faça uma consulta que retorne a idade média dos personagens.
SELECT AVG(IDADE_PERSONAGEM) AS MEDIA_IDADE
FROM PERSONAGEM;

-- 13) Selecione o nome dos atores que tem a mesma idade que o seu personagem.
SELECT A.CODIGO_ATOR, A.NOME_ATOR, A.IDADE, P.CODIGO_PERSONAGEM, P.NOME_PERSONAGEM, P.IDADE_PERSONAGEM
FROM ATOR A
INNER JOIN PERSONAGEM P ON P.IDADE_PERSONAGEM = A.IDADE;

-- 14) Encontre todas as novelas que tenham o valor do horário de exibição vazio.
SELECT CODIGO_NOVELA, NOME_NOVELA, HORARIO_EXIBICAO
FROM NOVELA
WHERE HORARIO_EXIBICAO IS NULL;

-- 15) Selecione quantas novelas existem cadastradas.
SELECT COUNT(CODIGO_NOVELA) AS QTD_NOVELAS
FROM NOVELA;

-- 16) Selecione quantos personagens tem menos do que 15 anos.
SELECT COUNT(IDADE_PERSONAGEM) AS QTD_MENOR_15ANOS
FROM PERSONAGEM
WHERE IDADE_PERSONAGEM < 15;

-- 17) Encontre qual o maior salário. <----------- AQUI
SELECT MAX(SALARIO_ATOR) AS MAIOR_SALARIO
FROM ATOR;

-- 18) Encontre qual o menor salario.
SELECT MIN(SALARIO_ATOR) AS MENOR_SALARIO
FROM ATOR;

-- 19) Faça o somatório de todos os salários.
SELECT SUM(SALARIO_ATOR) AS SOMA_SALARIOS
FROM ATOR;

-- 20) Sleecione a quantidade de personagens representados para cada ator.
SELECT A.CODIGO_ATOR, A.NOME_ATOR, COUNT(P.CODIGO_ATOR) AS QTD_PERSONAGENS
FROM ATOR A
INNER JOIN PERSONAGEM P ON P.CODIGO_ATOR = A.CODIGO_ATOR
GROUP BY A.CODIGO_ATOR, A.NOME_ATOR;

-- 21) Encontre o nome de todas as novelas quem tem mais de 40 capítulos.
SELECT N.NOME_NOVELA
FROM NOVELA N
LEFT JOIN Capitulos C ON N.CODIGO_NOVELA = C.CODIGO_NOVELA
GROUP BY N.NOME_NOVELA
HAVING COUNT(C.CODIGO_NOVELA) > 40;

-- 22) Encontre o nome de todos os atores que atuaram como personagens ricos (situação financeira)
-- em mais de 15 novelas.
SELECT A.CODIGO_ATOR, A.NOME_ATOR
FROM ATOR A
INNER JOIN Personagem P ON A.CODIGO_ATOR = P.CODIGO_ATOR
INNER JOIN NovelaPersonagem NP ON P.CODIGO_PERSONAGEM = NP.CODIGO_PERSONAGEM
INNER JOIN Novela N ON N.CODIGO_NOVELA = NP.CODIGO_NOVELA
WHERE P.SITUACAO_FINANCEIRA_PERSONAGEM LIKE '%Rico%'
GROUP BY A.CODIGO_ATOR, A.NOME_ATOR
HAVING COUNT(DISTINCT N.CODIGO_NOVELA) > 15;

-- 23) Selecione o nome dos atores que não participam de nenhuma novela.
SELECT A.CODIGO_ATOR, A.NOME_ATOR, A.IDADE
FROM ATOR A
INNER JOIN Personagem P ON P.CODIGO_ATOR = A.CODIGO_ATOR
INNER JOIN NovelaPersonagem NP ON NP.CODIGO_PERSONAGEM = P.CODIGO_PERSONAGEM
WHERE NP.CODIGO_NOVELA IS NULL;

-- 24) Selecione o nome e a idade dos atores quqe participam da novela "Ser Estranho"
SELECT A.NOME_ATOR, A.IDADE
FROM ATOR A
INNER JOIN PERSONAGEM P ON P.CODIGO_ATOR = A.CODIGO_ATOR
INNER JOIN NOVELAPERSONAGEM NP ON P.CODIGO_PERSONAGEM = NP.CODIGO_PERSONAGEM
INNER JOIN NOVELA N ON N.CODIGO_NOVELA = NP.CODIGO_NOVELA
WHERE N.NOME_NOVELA LIKE 'Ser Estranho';

-- 25) Selecione o nome de todos os atores que tiveram personagens com o nome "Anna".
SELECT A.NOME_ATOR
FROM ATOR A
INNER JOIN Personagem P ON P.CODIGO_ATOR = A.CODIGO_ATOR
WHERE P.NOME_PERSONAGEM LIKE 'Anna';

-- 28) Selecione o nome e a idade do personagem mais novo.
SELECT TOP 1 NOME_PERSONAGEM, MIN(IDADE_PERSONAGEM) AS IDADE_MIN
FROM PERSONAGEM
GROUP BY NOME_PERSONAGEM;

-- 29) Selecione o nome e o salário do ator que recebe o menor salário.
SELECT TOP 1 NOME_ATOR, MIN(SALARIO_ATOR) AS SALARIO
FROM ATOR
GROUP BY NOME_ATOR
ORDER BY SALARIO ASC;

-- 30) Quais os noems dos atores que nunca representaram personagens pobres nas novelas.
SELECT A.NOME_ATOR
FROM ATOR A
INNER JOIN PERSONAGEM P ON P.CODIGO_ATOR = A.CODIGO_ATOR
WHERE SITUACAO_FINANCEIRA_PERSONAGEM != 'Pobre';

-- 31) Selecione o nome dos atores que trabalharam em pelo menos uma novela das 18:00.
SELECT A.NOME_ATOR
FROM ATOR A
INNER JOIN PERSONAGEM P ON A.CODIGO_ATOR = P.CODIGO_ATOR
INNER JOIN NovelaPersonagem NP ON NP.CODIGO_PERSONAGEM = P.CODIGO_PERSONAGEM
INNER JOIN NOVELA N ON N.CODIGO_NOVELA = NP.CODIGO_NOVELA
WHERE N.HORARIO_EXIBICAO = '18:00';