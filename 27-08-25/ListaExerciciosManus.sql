DROP DATABASE EMPRESA;

CREATE DATABASE EMPRESA;
USE EMPRESA;
	
CREATE TABLE EMPREGADO
(
	RG NUMERIC(10) CONSTRAINT PK_EMPREGADO  PRIMARY KEY,
	NOME VARCHAR(100) CONSTRAINT NN_NOME NOT NULL,
	CPF NUMERIC(11) CONSTRAINT UN_CPF UNIQUE,
	DEPARTAMENTO INT CONSTRAINT NN_DEPARTAMENTO NOT NULL,
	RGSUPERVISOR NUMERIC(10) CONSTRAINT FK_EMPREGADO REFERENCES EMPREGADO(RG),
	SALARIO NUMERIC(10,2) CONSTRAINT NN_SALARIO NOT NULL
);

CREATE TABLE DEPARTAMENTO
(
	NUMERO INT CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY IDENTITY (1,1),
	NOME VARCHAR(100) CONSTRAINT NN_NOME_DEP NOT NULL,
	RGGERENTE NUMERIC(10) CONSTRAINT NNRGERENTE NOT NULL CONSTRAINT FK_GERENTE REFERENCES EMPREGADO(RG)
);

CREATE TABLE PROJETO
(
	NUMERO INT CONSTRAINT PK_PROJETO PRIMARY KEY IDENTITY (1,1),
	NOME VARCHAR(100) CONSTRAINT NN_NOME_PROJETO NOT NULL,
	LOCALIZACAO VARCHAR(50) CONSTRAINT NN_LOCALIZACAO NOT NULL
);

CREATE TABLE DEPENDENTE
(
	NUMERODEPENDENTE INT CONSTRAINT PK_DEPENDENTE PRIMARY KEY IDENTITY(1,1),
	RGRESPONSAVEL NUMERIC(10),
	NOMEDEPENDENTE VARCHAR(100),
	CONSTRAINT UN_RGRESPONSAVELNOME UNIQUE (RGRESPONSAVEL,NOMEDEPENDENTE),
	CONSTRAINT FK_RGRESPONSAVEL FOREIGN KEY (RGRESPONSAVEL) REFERENCES EMPREGADO(RG),
	DTNASCIMENTO DATE CONSTRAINT NN_DTNASCIMENTO NOT NULL,
	RELACAO VARCHAR(30) CONSTRAINT NN_RELACAO NOT NULL,
	SEXO CHAR(1) CONSTRAINT CK_SEXO CHECK(SEXO IN('M','F')) NOT NULL
);

CREATE TABLE DEPARTAMENTOPROJETO
(
	NUMERODEPARTAMENTO INT,
	NUMEROPROJETO INT,
	CONSTRAINT PK_DEPARTAMENTOPROJETO PRIMARY KEY (NUMERODEPARTAMENTO,NUMEROPROJETO),
	CONSTRAINT FK_NUMERODEPARTAMENTO FOREIGN KEY (NUMERODEPARTAMENTO) REFERENCES DEPARTAMENTO(NUMERO),
	CONSTRAINT FK_NUMEROPROJETO FOREIGN KEY (NUMEROPROJETO) REFERENCES PROJETO(NUMERO)
);

CREATE TABLE EMPREGADOPROJETO
(
	RGEMPREGADO NUMERIC(10),
	NUMEROPROJETO INT,
	CONSTRAINT PK_EMPREGADOPROJETO PRIMARY KEY (RGEMPREGADO,NUMEROPROJETO),
	CONSTRAINT FK_RGEMPREGADO FOREIGN KEY (RGEMPREGADO) REFERENCES EMPREGADO(RG),
	CONSTRAINT FK_NUMEROPROJETO_EMPREGADOPROJETO FOREIGN KEY (NUMEROPROJETO) REFERENCES PROJETO(NUMERO),
	HORAS INT CONSTRAINT NN_HORAS NOT NULL
);

-- INSERTS

INSERT INTO EMPREGADO (RG,NOME,CPF,DEPARTAMENTO,RGSUPERVISOR,SALARIO)
VALUES (10101010, 'João Luiz',11111111,1,null,3000.00);
INSERT INTO EMPREGADO (RG,NOME,CPF,DEPARTAMENTO,RGSUPERVISOR,SALARIO)
VALUES (20202020, 'Fernando',22222222,2,10101010,2500.00);
INSERT INTO EMPREGADO (RG,NOME,CPF,DEPARTAMENTO,RGSUPERVISOR,SALARIO)
VALUES (30303030, 'Ricardo',33333333,2,10101010,2300.00);
INSERT INTO EMPREGADO (RG,NOME,CPF,DEPARTAMENTO,RGSUPERVISOR,SALARIO)
VALUES (40404040, 'Jorge',44444444,2,20202020,4200.00);
INSERT INTO EMPREGADO (RG,NOME,CPF,DEPARTAMENTO,RGSUPERVISOR,SALARIO)
VALUES (50505050, 'Renato',55555555,3,20202020,1300.00);

INSERT INTO DEPARTAMENTO(NOME, RGGERENTE)
VALUES ('Contabilidade',10101010);
INSERT INTO DEPARTAMENTO(NOME, RGGERENTE)
VALUES ('Engenharia Civil',30303030);
INSERT INTO DEPARTAMENTO(NOME, RGGERENTE)
VALUES ('Engenharia Mec�nica',20202020);

ALTER TABLE EMPREGADO
ADD CONSTRAINT FK_DEPARTAMENTO_EMPREGADO FOREIGN KEY (DEPARTAMENTO) REFERENCES DEPARTAMENTO (NUMERO);

INSERT INTO PROJETO(NOME, LOCALIZACAO)
VALUES ('Financeiro 1', 'S�o Paulo');
INSERT INTO PROJETO(NOME, LOCALIZACAO)
VALUES ('Motor 3', 'Rio Claro');
INSERT INTO PROJETO(NOME, LOCALIZACAO)
VALUES ('Predio Central', 'Campinas');

INSERT INTO DEPENDENTE(RGRESPONSAVEL,NOMEDEPENDENTE,DTNASCIMENTO,RELACAO,SEXO)
VALUES(10101010,'Jorge','1986-12-27','Filho','M');
INSERT INTO DEPENDENTE(RGRESPONSAVEL,NOMEDEPENDENTE,DTNASCIMENTO,RELACAO,SEXO)
VALUES(10101010,'Luiz','1979-11-18','Filho','M');
INSERT INTO DEPENDENTE(RGRESPONSAVEL,NOMEDEPENDENTE,DTNASCIMENTO,RELACAO,SEXO)
VALUES(20202020,'Fernanda','1969-02-14','Conjuge','F');
INSERT INTO DEPENDENTE(RGRESPONSAVEL,NOMEDEPENDENTE,DTNASCIMENTO,RELACAO,SEXO)
VALUES(20202020,'Angelo','1995-02-10','Filho','M');
INSERT INTO DEPENDENTE(RGRESPONSAVEL,NOMEDEPENDENTE,DTNASCIMENTO,RELACAO,SEXO)
VALUES(30303030,'Andreia','1990-05-01','Filho','F');
										  
INSERT INTO DEPARTAMENTOPROJETO(NUMERODEPARTAMENTO,NUMEROPROJETO)
VALUES (2,1);
INSERT INTO DEPARTAMENTOPROJETO(NUMERODEPARTAMENTO,NUMEROPROJETO)
VALUES (3,2);
INSERT INTO DEPARTAMENTOPROJETO(NUMERODEPARTAMENTO,NUMEROPROJETO)
VALUES (2,3);

INSERT INTO EMPREGADOPROJETO(RGEMPREGADO,NUMEROPROJETO,HORAS)
VALUES (20202020,1,10);
INSERT INTO EMPREGADOPROJETO(RGEMPREGADO,NUMEROPROJETO,HORAS)
VALUES (20202020,2,20);
INSERT INTO EMPREGADOPROJETO(RGEMPREGADO,NUMEROPROJETO,HORAS)
VALUES (30303030,1,35);
INSERT INTO EMPREGADOPROJETO(RGEMPREGADO,NUMEROPROJETO,HORAS)
VALUES (40404040,3,50);
INSERT INTO EMPREGADOPROJETO(RGEMPREGADO,NUMEROPROJETO,HORAS)
VALUES (50505050,3,35);

------------------------------------------------------------------------------------------ CONTEUDO AULA --------------------------------------------------------------------------------------

-- ORDENAÇÃO --
-- ORDER BY --
SELECT NOME FROM EMPREGADO
ORDER BY NOME DESC

SELECT NOME, CPF FROM EMPREGADO
ORDER BY NOME ASC, RG

-- NULL --
SELECT NOME FROM EMPREGADO WHERE RGSUPERVISOR IS NULL

SELECT NOME FROM EMPREGADO WHERE RGSUPERVISOR IS NOT NULL

-- LIKE E = --

SELECT NOME FROM EMPREGADO WHERE NOME LIKE 'JOÃO %'
SELECT NOME FROM EMPREGADO WHERE NOME = 'JOÃO'
SELECT NOME FROM EMPREGADO WHERE NOME LIKE '_____'

-- BETWEEN --
SELECT NOMEDEPENDENTE FROM DEPENDENTE WHERE DTNASCIMENTO BETWEEN '01-01-2000' AND '31-12-2025'

-- IN E NOT IN --
SELECT NOME FROM EMPREGADO WHERE RG IN (10101010,20202020)
SELECT NOME FROM EMPREGADO WHERE RGSUPERVISOR IN (SELECT RG FROM EMPREGADO WHERE RGSUPERVISOR IS NULL)

-- UNION --
SELECT NOME FROM EMPREGADO UNION SELECT NOME FROM EMPREGADO

SELECT NOME FROM EMPREGADO WHERE RG = 10101010 INTERSECT SELECT NOME FROM EMPREGADO

-- EXCEPT --
SELECT NOME FROM EMPREGADO WHERE RG!=10101010


----------------------------------------------------------------- LISTA DE EXERCICIOS ---------------------------------------------------------------------------------------

-- 1) Exiba todos os atributos da tabela empregado ordenando por salário e nome --
-- SELECT * FROM EMPREGADO ORDER BY SALARIO DESC, NOME DESC
SELECT RG,NOME,CPF,DEPARTAMENTO,RGSUPERVISOR,SALARIO
FROM EMPREGADO ORDER BY SALARIO, NOME

-- 2) Exiba o nome e o salário dos empregados que tem salário entre 2 e 3 mil. --
SELECT SALARIO,NOME
FROM EMPREGADO WHERE SALARIO BETWEEN 2000.00 AND 3000.00

-- 3) Exiba os dependentes que são filhos, que nasceram entre 10 de abril de 1994 e 15 de maio de 2000 e que são do sexo masculino. --
SELECT NOMEDEPENDENTE
FROM DEPENDENTE WHERE RELACAO = 'Filho' AND DTNASCIMENTO BETWEEN '1994-04-10' AND '2000-05-15' AND SEXO = 'M'

-- 4) Exiba todos os dependentes que tem Maria em qualquer parte do nome --
SELECT NOMEDEPENDENTE
FROM DEPENDENTE WHERE NOMEDEPENDENTE LIKE '% MARIA %'

-- 5) Exiba os departamentos cujo o nome tem 10 caracteres --
SELECT NOME
FROM DEPARTAMENTO WHERE NOME LIKE '__________'

-- 6) Exiba todos os empregados que possuem supervisor --
SELECT NOME
FROM EMPREGADO WHERE RGSUPERVISOR IS NOT NULL

-- 7) Exiba todos os empregados que não possuem um supervisor --
SELECT NOME
FROM EMPREGADO WHERE RGSUPERVISOR IS NULL

-- 8) Exiba uma listagem única com todos os nomes dos empregados e dependentes, caso exista nome repetidos
-- ambos devem ser exibidos --
SELECT NOME
FROM EMPREGADO UNION ALL SELECT NOMEDEPENDENTE FROM DEPENDENTE

-- 9) Exiba os empregados que possuem dependentes ou que trablaham em algum projeto. 
SELECT NOME 
FROM EMPREGADO WHERE RG IN (SELECT RGResponsavel FROM DEPENDENTE) 
OR RG IN (SELECT RGEmpregado FROM EMPREGADOPROJETO); ------------ IMPORTANTE

-- 10) Exiba os empregados que tem salário maior que 4 mil e que não tem supervisor
SELECT NOME
FROM EMPREGADO WHERE SALARIO > 4000 AND RGSUPERVISOR IS NULL

-- 11) Exiba os empregados que possuem o João Luiz como supervisor
SELECT NOME
FROM EMPREGADO WHERE RGSUPERVISOR IN (SELECT RG FROM EMPREGADO WHERE NOME LIKE 'João Luiz')

-- 12) Exiba os empregados que trabalham no projeto motor 3
-- SELECT NOME
-- FROM EMPREGADO WHERE DEPARTAMENTO = 3
SELECT NOME FROM EMPREGADO
WHERE RG IN (SELECT RGEMPREGADO FROM EMPREGADOPROJETO WHERE NUMEROPROJETO IN (SELECT NUMERO FROM PROJETO WHERE NOME LIKE 'MOTOR 3'))

-- 13) Exiba o nome dos empregados que trabalharam mais que 5 horas no projeto Prédio Central
SELECT NOME 
FROM EMPREGADO
WHERE RG IN (
    SELECT RGEMPREGADO 
    FROM EMPREGADOPROJETO 
    WHERE HORAS > 5 
    AND NUMEROPROJETO IN (
        SELECT NUMEROPROJETO   -- ← Use a CHAVE (INT), não o NOME (VARCHAR)
        FROM PROJETO 
        WHERE NOME = 'Predio Central'
    )
);

-- 14) Exiba o departamento que é gerenciado pelo empregado Ricardo
SELECT NOME FROM DEPARTAMENTO
WHERE RGGERENTE IN (SELECT RG FROM EMPREGADO WHERE NOME LIKE 'RICARDO')


------------------------------- LISTA DE EXERCICIOS TENTATIVA O1 ------------------------------------------------
-- Ordenar todos os atriutos da tabela emprego por salário e nome
SELECT *
FROM EMPREGADO
ORDER BY SALARIO, NOME

-- Exiba o nome e o salário dos empregados que tem salário entre 2 e 3 mil.
SELECT NOME, SALARIO
FROM EMPREGADO
WHERE SALARIO BETWEEN 2000.00 AND 3000.00

-- Exiba os dependentes que são filhos, que nasceram entre 10 de abril de 1994 e 15 de maio de 2000 e que são do sexo masculino
SELECT NOMEDEPENDENTE
FROM DEPENDENTE
WHERE DTNASCIMENTO BETWEEN '1994-04-10' AND '2000-05-15' AND SEXO = 'M'

-- Exiba todos os dependentes que tem MARIA em qualquer parte do nome
SELECT NOMEDEPENDENTE
FROM DEPENDENTE
WHERE NOMEDEPENDENTE LIKE '% MARIA %'

-- Exiba os departamentos cujo o nome tem 10 caracteres
SELECT NOME
FROM DEPARTAMENTO
WHERE NOME LIKE '_________'

-- Exiba todos os empregados que possuem supervisor
SELECT NOME
FROM EMPREGADO
WHERE RGSUPERVISOR IS NOT NULL

-- Exiba todos os empregados que não possuem supervisor
SELECT NOME
FROM EMPREGADO
WHERE RGSUPERVISOR IS NULL

-- Exiba uma listagem unica com todos os nomes dos empregados e dependentes, caso exista nome repetidos, ambos devem ser exibidos.
SELECT NOME
FROM EMPREGADO
UNION ALL SELECT NOMEDEPENDENTE FROM DEPENDENTE

-- Exiba os empregados que possuem dependentes ou que trabalham em algum projeto
SELECT NOME FROM EMPREGADO WHERE RG IN (SELECT RGRESPONSAVEL FROM DEPENDENTE) OR RG IN (SELECT RGEMPREGADO FROM EMPREGADOPROJETO)

-- Exiba os empregados que tem salário amior que 4 mil e que não tem supervisor
SELECT NOME FROM EMPREGADO
WHERE SALARIO > 4000 AND RGSUPERVISOR IS NULL

-- Exiba os empregados que tem o João Luis como supervisor
SELECT NOME FROM EMPREGADO
WHERE RGSUPERVISOR IN (SELECT RG FROM EMPREGADO WHERE NOME LIKE 'João Luiz')

-- Exiba os empregados que trabalham no projeto Motor 3
SELECT NOME FROM EMPREGADO 
WHERE RG IN (SELECT RGEMPREGADO FROM EMPREGADOPROJETO WHERE NUMEROPROJETO IN (SELECT NUMERO FROM PROJETO WHERE NOME LIKE 'Motor 3'))

-- Exiba o nome dos empregados que trabalharam mais do que 5 horas no projeto Prédio Central.
-- Predio Central = Numero de Projeto 20
SELECT NOME FROM EMPREGADO
WHERE RG IN (SELECT RGEMPREGADO FROM EMPREGADOPROJETO WHERE HORAS > 5 AND NUMEROPROJETO IN (SELECT NUMERO FROM PROJETO WHERE NOME LIKE 'Predio Central'))

-- Exiba o departamento que é gerenciado pelo empregado Ricardo
SELECT NOME FROM DEPARTAMENTO
WHERE RGGERENTE IN (SELECT RG FROM EMPREGADO WHERE NOME LIKE 'Ricardo')

--------------- NOVOS EXERCÍCIOS ------------------
-- 1) Exiba o nome e o departamento de um empregado específico, buscando-o pelo seu CPF.
SELECT NOME, DEPARTAMENTO
FROM EMPREGADO
WHERE RG = '30303030'

-- 2) Liste o nome e a localização de todos os projetos que não estão localizados em 'São Paulo'
SELECT NOME, LOCALIZACAO
FROM PROJETO
WHERE LOCALIZACAO != 'S?o Paulo'

-- 3) Encontre o nome e a data de nascimento de todos os dependentes cujos nomes começam com 'A' ou 'F'
SELECT NOMEDEPENDENTE, DTNASCIMENTO
FROM DEPENDENTE
WHERE NOMEDEPENDENTE LIKE 'A%' OR NOMEDEPENDENTE LIKE 'F%'

-- 4) Exiba o nome e o CPF dos empregados que possuem um salário exatamente igual a 2500 ou 1300
SELECT NOME, CPF
FROM EMPREGADO
WHERE SALARIO = 2500 OR SALARIO = 1300

-- 5) Mostre o nome e a relação de todos os dependentes cuja relação com o responsável não seja 'Filho' ou 'Filha'
SELECT NOMEDEPENDENTE, RELACAO
FROM DEPENDENTE
WHERE RELACAO LIKE 'FILHO' OR RELACAO LIKE 'FILHA'

-- 6) Exiba todos os atributos dos empregados, ordenando-os pelo nome em ordem alfabética (A-Z) e, para nomes iguais, pelo salário em ordem decrescente
SELECT *
FROM EMPREGADO
ORDER BY NOME ASC, SALARIO DESC

-- 7) Liste todos os projetos cujo nome contém a palavra 'Central' ou 'Motor'
SELECT NOME
FROM PROJETO
WHERE NOME LIKE '%CENTRAL%' OR NOME LIKE '%MOTOR%'

-- 8) Encontre o nome e o salário de todos os empregados cujo primeiro nome tenha exatamente 6 letras.
SELECT NOME, SALARIO
FROM EMPREGADO
WHERE NOME LIKE '______'

-- 9) Exiba o nome e a data de nascimento de todos os dependentes que nasceram na década de 1990. Ordenados descendentemente.
SELECT NOMEDEPENDENTE, DTNASCIMENTO
FROM DEPENDENTE
WHERE DTNASCIMENTO BETWEEN '1990-01-01' AND '1999-12-31' 
ORDER BY DTNASCIMENTO DESC

-- 10) Liste o nome de todos os empregados que são supervisinados diretamente por 'Fernando'
SELECT NOME 
FROM EMPREGADO
WHERE RGSUPERVISOR IN (SELECT RG FROM EMPREGADO WHERE NOME LIKE 'FERNANDO')

-- 11) Exiba o nome de todos os empregados que não estão alocados no projeto 'Financeiro 1'
SELECT NOME
FROM EMPREGADO
WHERE RG NOT IN (SELECT RGEMPREGADO FROM EMPREGADOPROJETO WHERE NUMEROPROJETO = 1) 

SELECT * FROM PROJETO

-- 12) Mostre os nomes que aparecem tanto na lista de empregados quanto na lista de dependentes.
SELECT NOME
FROM EMPREGADO
WHERE NOME IN (SELECT NOMEDEPENDENTE FROM DEPENDENTE)

-- 13) Exiba o RG de todos os empregados. Em seguida, remova dessa lista os RGs dos empregados que possuem dependentes.
SELECT RG
FROM EMPREGADO
WHERE RG NOT IN (SELECT RGRESPONSAVEL FROM DEPENDENTE)

SELECT *
FROM DEPARTAMENTOPROJETO

-- 14) Liste o nome de todos os projetos associados ao departamento de 'Engenharia Civil'
SELECT NOME
FROM PROJETO
WHERE NUMERO IN (SELECT NOME FROM PROJETO WHERE NOME NOT LIKE 'Contabilidade' OR NOME LIKE 'Engenharia Mecanica')

-- 15) Liste o nome e o salário de todos os empregados que também são gerentes de algum departamento.
SELECT NOME, SALARIO
FROM EMPREGADO
WHERE RG IN (SELECT RGGERENTE FROM DEPARTAMENTO)

----------------------------------------------------

-- 1) Selecione todos os campos da tabela empregados ordenados por RG em ordem decrescente.
SELECT NOME, RG, CPF, DEPARTAMENTO, RGSUPERVISOR, SALARIO
FROM EMPREGADO
ORDER BY RG DESC

-- 2) Selecione o nome de todos os empregados e o nome, a data de nascimento e a relação dos depednentes ordenados por nome dependente.
SELECT e.Nome AS NomeEmpregado,
	d.NomeDependente AS NomeDependente,
	d.DtNascimento,
	d.Relacao
FROM EMPREGADO e
LEFT JOIN Dependente d ON e.RG = d.RGRESPONSAVEL
ORDER BY d.NomeDependente;

---------------------------------------------------------------

-- Exercícios de INNER JOIN
-- Liste todos os empregados com seus respectivos departamentos --
SELECT 
	e.Nome AS NomeEmpregado,
	d.Nome AS NomeDepartamento
FROM EMPREGADO e
INNER JOIN DEPARTAMENTO d ON e.departamento = d.numero
ORDER BY d.NOME, e.NOME

-- Mostre nome do empregado e nome do departamento
SELECT 
	e.nome AS NomeEmpregado,
	d.Nome AS NomeDepartamento
FROM EMPREGADO e
INNER JOIN DEPARTAMENTO d ON e.departamento = d.numero
ORDER BY d.Nome, e.nome

-- Mostre os projetos com seus departamentos associados
SELECT 
    p.NOME AS NomeProjeto,
    p.LOCALIZACAO,
    d.NOME AS NomeDepartamento
FROM PROJETO p
INNER JOIN DEPARTAMENTOPROJETO dp ON p.NUMERO = dp.NUMEROPROJETO
INNER JOIN DEPARTAMENTO d ON dp.NUMERODEPARTAMENTO = d.NUMERO
ORDER BY d.NOME, p.NOME;

-- Liste todos os empregados e seus departamentos
SELECT e.nome AS NomeEmpregado,
	d.nome AS NomeDepartamento
FROM EMPREGADO e
INNER JOIN DEPARTAMENTO d ON e.departamento = d.numero;

-- Mostre os dependentes com o nome de seu responsável
SELECT dp.nomedependente AS NomeDependente,
	e.nome AS NomeResponsavel
FROM DEPENDENTE dp
INNER JOIN EMPREGADO e ON e.RG = dp.RGRESPONSAVEL

-- Liste os projetos e suas localizações
SELECT NOME AS NomeProjeto,
	Localizacao
FROM PROJETO
ORDER BY NOME;

-- Mostre empregados e seus supervisores
SELECT e.nome AS NomeEmpregado,
	s.nome AS NomeSupervisor
FROM Empregado e
INNER JOIN EMPREGADO s ON e.RGSUPERVISOR = s.RG

-- Liste os departamentos e seus gerentes
SELECT d.nome AS NomeDepartamento,
	e.nome AS NomeGerente
FROM DEPARTAMENTO d
INNER JOIN EMPREGADO e ON d.RGGERENTE = e.RG
	
-- Liste todos os empregados, mesmo os sem dependentes.
SELECT e.nome AS NomeEmpregado,
	d.nomeDependente AS NomeDependente
FROM EMPREGADO e
LEFT JOIN DEPENDENTE d ON d.rgresponsavel = e.rg

-- Liste todos os departamentos, mesmo os sem projetos.
SELECT 
    d.NOME AS NomeDepartamento,
    p.NOME AS NomeProjeto
FROM DEPARTAMENTO d
LEFT JOIN DEPARTAMENTOPROJETO dp ON d.NUMERO = dp.NUMERODEPARTAMENTO
LEFT JOIN PROJETO p ON dp.NUMEROPROJETO = p.NUMERO
ORDER BY d.NOME, p.NOME;

-- Liste todos os projetos, mesmo os sem empregados alocados.
SELECT 
    p.NOME AS NomeProjeto,
    p.LOCALIZACAO,
    e.NOME AS NomeEmpregado,
    ep.HORAS AS HorasTrabalhadas
FROM PROJETO p
LEFT JOIN EMPREGADOPROJETO ep ON p.NUMERO = ep.NUMEROPROJETO
LEFT JOIN EMPREGADO e ON ep.RGEMPREGADO = e.RG
ORDER BY p.NOME, e.NOME;

-- Mostre todos os supervisores e seus supervisionados
SELECT 
    s.NOME AS NomeSupervisor,
    e.NOME AS NomeSupervisionado
FROM EMPREGADO s
LEFT JOIN EMPREGADO e ON s.RG = e.RGSUPERVISOR
ORDER BY s.NOME, e.NOME;

-- Liste os empregados e suas horas em projetos.
SELECT 
    e.NOME AS NomeEmpregado,
    p.NOME AS NomeProjeto,
    ep.HORAS AS HorasTrabalhadas
FROM EMPREGADO e
LEFT JOIN EMPREGADOPROJETO ep ON e.RG = ep.RGEMPREGADO
LEFT JOIN PROJETO p ON ep.NUMEROPROJETO = p.NUMERO
ORDER BY e.NOME, p.NOME;

-----------------------------------------------------------------------------
-- Selecione todos os campos da tabela empregados orgenados por RG em ordem decrescente.
SELECT *
FROM EMPREGADO
ORDER BY RG DESC

-- Selecione o nome de todos os empregados e o nome, data de nascimento e a relação dos dependentes ordenados por nome dependente.
SELECT e.Nome AS NomeEmpregado,
	d.NomeDependente AS NomeDependente,
	d.DtNascimento,
	d.Relacao
FROM EMPREGADO e
LEFT JOIN Dependente d ON e.RG = d.RGResponsavel;

-- Indique quantos empregados existem por departamento.

SELECT d.Nome AS NomeDepartamento,
count(e.RG) AS QuantidadeEmpregados
FROM DEPARTAMENTO d
LEFT JOIN Empregado e ON d.numero = e.departamento
GROUP BY d.numero, d.nome
ORDER BY QuantidadeEmpregados DESC;

-- Indique quantos projetos existem por departamento
SELECT 
    d.NOME AS NomeDepartamento,
    COUNT(dp.NUMEROPROJETO) AS QuantidadeProjetos
FROM DEPARTAMENTO d
LEFT JOIN DEPARTAMENTOPROJETO dp ON d.NUMERO = dp.NUMERODEPARTAMENTO
GROUP BY d.NUMERO, d.NOME
ORDER BY QuantidadeProjetos DESC;

-- Quais são os empregados que não participam de nenhum projeto?
SELECT 
    e.RG,
    e.NOME AS NomeEmpregado,
    d.NOME AS Departamento
FROM EMPREGADO e
LEFT JOIN EMPREGADOPROJETO ep ON e.RG = ep.RGEMPREGADO
LEFT JOIN DEPARTAMENTO d ON e.DEPARTAMENTO = d.NUMERO
WHERE ep.NUMEROPROJETO IS NULL
ORDER BY e.NOME;

-- Quais são os empregados que não tem dependentes?
SELECT 
    e.RG,
    e.NOME AS NomeEmpregado,
    d.NOME AS Departamento
FROM EMPREGADO e
LEFT JOIN DEPENDENTE dep ON e.RG = dep.RGRESPONSAVEL
LEFT JOIN DEPARTAMENTO d ON e.DEPARTAMENTO = d.NUMERO
WHERE dep.RGRESPONSAVEL IS NULL
ORDER BY e.NOME;

-- Quais são os empregados que não tem supervisor?
SELECT 
    e.RG, 
    e.NOME AS NomeEmpregado,
    d.NOME AS Departamento
FROM EMPREGADO e
LEFT JOIN DEPARTAMENTO d ON e.DEPARTAMENTO = d.NUMERO
WHERE e.RGSUPERVISOR IS NULL
ORDER BY e.NOME;

-- Quais são os empregados do departamento 1?
SELECT
	e.Nome AS NomeEmpregado,
	d.Nome AS Departamento
FROM EMPREGADO e
LEFT JOIN Departamento d ON d.NUMERO = e.DEPARTAMENTO
WHERE e.DEPARTAMENTO = 1;

-- Quais são os dependentes do Fernando?
SELECT
	d.nomedependente AS NomeDependente,
	d.rgresponsavel AS RGResponsavel,
	e.nome AS NomeResponsavel
FROM DEPENDENTE d
LEFT JOIN Empregado e ON e.RG = d.RGRESPONSAVEL
WHERE RGRESPONSAVEL = 20202020

-- Quantos dependentes do sexo feminino?
SELECT 
    COUNT(*) AS QuantidadeFemininos
FROM DEPENDENTE
WHERE SEXO = 'F';

-- Quantos dependentes tem mais que 15 anos?
SELECT
COUNT(*) AS MaioresQue15Anos
FROM DEPENDENTE
WHERE DTNASCIMENTO <= '2013-09-02'

-- Quem é o responsável pela Andreia?
SELECT
e.nome as NomeResponsavel,
d.RGRESPONSAVEL as RGResponsavel
FROM Dependente d
INNER JOIN EMPREGADO e ON d.RGRESPONSAVEL = e.RG
WHERE d.NOMEDEPENDENTE LIKE 'Andreia'

-- Quais os funcionários que trabalharam no projeto financeiro ?
SELECT 
    e.RG,
    e.NOME AS NomeFuncionario,
    p.NOME AS NomeProjeto,
    ep.HORAS AS HorasTrabalhadas
FROM EMPREGADO e
INNER JOIN EMPREGADOPROJETO ep ON e.RG = ep.RGEMPREGADO
INNER JOIN PROJETO p ON ep.NUMEROPROJETO = p.NUMERO
WHERE p.NOME = 'Financeiro 1'
ORDER BY e.NOME;

-- Quais os dependentes do sexo feminino que nasceram depois de 1990?
SELECT 
    d.NOMEDEPENDENTE AS NomeDependente,
    d.DTNASCIMENTO AS DataNascimento,
    d.SEXO,
    d.RELACAO,
    e.NOME AS NomeResponsavel
FROM DEPENDENTE d
INNER JOIN EMPREGADO e ON d.RGRESPONSAVEL = e.RG
WHERE d.SEXO = 'F'
AND d.DTNASCIMENTO > '1990-12-31'
ORDER BY d.DTNASCIMENTO DESC;

-- Qual o maior salário?
SELECT 
    MAX(SALARIO) AS MaiorSalario
FROM EMPREGADO;

-- Qual o menor salário?
SELECT
	MIN(SALARIO) AS MENORSALARIO
FROM EMPREGADO;

-- Qual a média dos salários?
SELECT
AVG(SALARIO) AS MediaSalarial
FROM EMPREGADO;

-- Qual o dependente mais novo?
SELECT 
    NOMEDEPENDENTE,
    DTNASCIMENTO
FROM DEPENDENTE
WHERE DTNASCIMENTO = (SELECT MAX(DTNASCIMENTO) FROM DEPENDENTE);

-- Qual a média salarial do departamento de engenharia civil?
SELECT 
    d.NOME AS Departamento,
    AVG(e.SALARIO) AS MediaSalarial
FROM EMPREGADO e
INNER JOIN DEPARTAMENTO d ON e.DEPARTAMENTO = d.NUMERO
WHERE d.NOME = 'Engenharia Civil'
GROUP BY d.NOME;

-- Qual são os projetos que ficam em Campinas?
SELECT 
    NUMERO,
    NOME AS NomeProjeto,
    Localizacao
FROM PROJETO
WHERE LOCALIZACAO = 'Campinas';

-- Quais são as pessoas que trabalham em Campinas?
SELECT 
    e.RG,
    e.NOME AS NomeEmpregado,
    p.NOME AS NomeProjeto,
    p.LOCALIZACAO
FROM EMPREGADO e
INNER JOIN EMPREGADOPROJETO ep ON e.RG = ep.RGEMPREGADO
INNER JOIN PROJETO p ON ep.NUMEROPROJETO = p.NUMERO
WHERE p.LOCALIZACAO = 'Campinas'
ORDER BY e.NOME;

-- Quais são os departamentos existentes e quais são os gerentes de cada um deles?
SELECT 
    d.NUMERO AS CodigoDepartamento,
    d.NOME AS NomeDepartamento,
    e.RG AS RG_Gerente,
    e.NOME AS NomeGerente
FROM DEPARTAMENTO d
LEFT JOIN EMPREGADO e ON d.RGGERENTE = e.RG
ORDER BY d.NOME;

-- Quais os funcionários que não tem dependentes e não trabalham em nenhum projeto?
SELECT 
    e.RG,
    e.NOME AS NomeFuncionario
FROM EMPREGADO e
WHERE e.RG NOT IN (SELECT RGRESPONSAVEL FROM DEPENDENTE)
AND e.RG NOT IN (SELECT RGEMPREGADO FROM EMPREGADOPROJETO);

-- Quais os funcionários que tem dependentes e trabalham em nenhum projeto?
SELECT 
    e.RG,
    e.NOME AS NomeFuncionario,
    d.NOME AS Departamento,
    COUNT(dep.NUMERODEPENDENTE) AS QuantidadeDependentes
FROM EMPREGADO e
INNER JOIN DEPENDENTE dep ON e.RG = dep.RGRESPONSAVEL
LEFT JOIN EMPREGADOPROJETO ep ON e.RG = ep.RGEMPREGADO
LEFT JOIN DEPARTAMENTO d ON e.DEPARTAMENTO = d.NUMERO
WHERE ep.RGEMPREGADO IS NULL
GROUP BY e.RG, e.NOME, d.NOME
ORDER BY e.NOME;

-- Qual o projeto que tem mais horas?
SELECT 
    p.NUMERO,
    p.NOME AS NomeProjeto,
    p.LOCALIZACAO,
    SUM(ep.HORAS) AS TotalHoras
FROM PROJETO p
INNER JOIN EMPREGADOPROJETO ep ON p.NUMERO = ep.NUMEROPROJETO
GROUP BY p.NUMERO, p.NOME, p.LOCALIZACAO
ORDER BY TotalHoras DESC;

-- Qual o projeto que tem menos horas?
SELECT 
    p.NUMERO,
    p.NOME AS NomeProjeto,
    p.LOCALIZACAO,
    SUM(ep.HORAS) AS TotalHoras
FROM PROJETO p
INNER JOIN EMPREGADOPROJETO ep ON p.NUMERO = ep.NUMEROPROJETO
GROUP BY p.NUMERO, p.NOME, p.LOCALIZACAO
ORDER BY TotalHoras ASC;