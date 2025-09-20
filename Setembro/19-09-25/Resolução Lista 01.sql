---------- RESOLUÇÃO LISTA 01 ------------

-- Selecione todos os campos da tabela empregados ordenados por RG em ordem decrescente
SELECT 
	RG, 
	NOME, 
	CPF, 
	DEPARTAMENTO, 
	RGSUPERVISOR, 
	SALARIO
FROM EMPREGADO
ORDER BY RG DESC;

-- Selecione o nome de todos os empregados e o nome, a data de nascimento e a realação dos dependentes ordenados por nome de dependente.
SELECT 
	e.nome,
	d.nomedependente, 
	d.DTNASCIMENTO,
	d.RELACAO
FROM Empregado e
LEFT JOIN Dependente d ON e.rg = d.RGRESPONSAVEL
ORDER BY d.NOMEDEPENDENTE;

-- Indique quantos empregados existem por departamento.
SELECT
	d.numero,
	d.nome,
	d.rggerente,
	COUNT(e.departamento) AS 'Número de Empregados'
FROM Departamento d
INNER JOIN Empregado e ON d.NUMERO = e.DEPARTAMENTO
GROUP BY d.numero, d.nome, d.rggerente;

-- Indique quantos projetos existem por departamento.
SELECT
	d.numero,
	d.nome,
	COUNT(DISTINCT dp.numeroprojeto) AS 'Número de Projetos'
FROM Departamento d
LEFT JOIN DEPARTAMENTOPROJETO dp ON d.numero = dp.numerodepartamento
GROUP BY d.numero, d.nome;

-- Quais são os empregados que não participam de nenhum projeto.
SELECT 
	e.rg,
	e.nome,
	e.cpf,
	e.departamento,
	e.salario,
	ep.rgempregado
FROM Empregado e
LEFT JOIN EMPREGADOPROJETO ep ON e.rg = ep.RGEMPREGADO
WHERE ep.RGEMPREGADO IS NULL;

-- Quais são os empregados que não tem dependentes?
SELECT
	e.RG,
	e.nome,
	e.cpf,
	e.departamento,
	e.salario,
	d.rgresponsavel AS 'Responsável por'
FROM Empregado e
LEFT JOIN DEPENDENTE d ON e.RG = d.RGRESPONSAVEL
WHERE d.RGRESPONSAVEL IS NULL;
 
--g.	Qual(is) o(s) empregado(s) que não tem supervisor?
SELECT 
	e.rg,
	e.nome,
	e.cpf,
	e.departamento,
	e.rgsupervisor
FROM Empregado e
WHERE e.RGSUPERVISOR IS NULL;

--h.	Quais são os empregados do departamento 1?
SELECT 
	e.rg,
	e.nome,
	e.cpf,
	e.departamento
FROM Empregado e
INNER JOIN Departamento d ON d.numero = e.departamento
WHERE d.NUMERO = 1;

--i.	Quais são os dependentes do Fernando?
SELECT 
	d.numerodependente,
	d.nomedependente,
	d.dtnascimento,
	d.relacao,
	d.sexo
FROM Dependente d
INNER JOIN Empregado e ON d.RGRESPONSAVEL = e.RG
WHERE e.NOME LIKE 'Fernando';

--j.	Quantos dependentes do sexo feminino?
SELECT COUNT(NUMERODEPENDENTE) AS 'Quantidade de Mulheres'
FROM Dependente
WHERE SEXO LIKE 'F';

--k.	Quantos dependentes tem mais que 15 anos?
SELECT COUNT(NUMERODEPENDENTE) AS 'Maiores que 15 anos'
FROM Dependente
WHERE DATEDIFF(YEAR, DTNASCIMENTO,GETDATE())>15;

--l.	Quem é o responsável pela Andreia?
SELECT
	e.rg,
	e.nome,
	e.cpf,
	e.departamento
FROM Empregado e
INNER JOIN Dependente d ON e.rg = d.rgresponsavel
WHERE d.NOMEDEPENDENTE LIKE 'Andreia'

--m.	Quais os funcionários que trabalharam no projeto financeiro 1?
SELECT
	e.rg,
	e.nome,
	e.cpf,
	e.salario
FROM EMPREGADO e
INNER JOIN EMPREGADOPROJETO ep ON e.rg = ep.rgempregado
INNER JOIN PROJETO p ON ep.numeroprojeto = p.numero
WHERE p.nome LIKE 'Financeiro 1';

--n.	Quais os dependentes do sexo feminino que nasceram depois de 1990?
SELECT
	d.numerodependente,
	d.nomedependente
FROM Dependente d
WHERE d.sexo = 'F' AND DTNASCIMENTO > '1990-12-31';

--o.	Qual o maior salário?
SELECT TOP 1
	nome, 
	cpf, 
	salario as 'Maior Salário'
FROM Empregado
ORDER BY SALARIO DESC;

--p.	Qual o menor salário?
SELECT TOP 1
	nome,
	cpf,
	salario
FROM EMPREGADO
ORDER BY SALARIO ASC;

--q.	Qual a média dos salários?
SELECT AVG(SALARIO) AS 'Média de Salários'
FROM EMPREGADO;

--r.	Qual o dependente mais novo?
SELECT nomedependente
FROM dependente
WHERE dtnascimento = (SELECT MIN(dtnascimento) FROM DEPENDENTE);

--s.	Qual a média salarial do departamento de Engenharia Civil?
SELECT AVG(E.SALARIO) AS 'Média Salarial'
FROM EMPREGADO E
INNER JOIN DEPARTAMENTO D ON E.DEPARTAMENTO = D.NUMERO
WHERE D.NOME LIKE 'Engenharia Civil';

--t.	Quais são os projetos que ficam em Campinas?
SELECT Nome
FROM Projeto 
WHERE LOCALIZACAO LIKE 'Campinas';

--u.	Quais são as pessoas que trabalham em Campinas?
SELECT 
	e.rg,
	e.nome, 
	e.cpf,
	e.departamento
FROM Empregado e
INNER JOIN EMPREGADOPROJETO ep ON ep.RGEMPREGADO = e.RG
INNER JOIN PROJETO p ON ep.NUMEROPROJETO = p.NUMERO
WHERE p.LOCALIZACAO LIKE 'Campinas'

--v.	Quais os departamentos existentes e quais são os gerentes de cada um deles?
SELECT 
	nome,
	rggerente
FROM Departamento;

--w.	Quais os funcionários que não tem dependentes e não trabalham em nenhum projeto?
SELECT
	e.rg,
	e.nome,
	e.cpf,
	e.salario
FROM Empregado e
LEFT JOIN Dependente d ON e.rg = d.rgresponsavel
LEFT JOIN EmpregadoProjeto ep ON e.rg = ep.rgempregado
WHERE d.rgresponsavel IS NULL AND ep.rgempregado IS NULL;

--x.	Quais os funcionários que tem dependentes e trabalham em nenhum projeto?
SELECT DISTINCT
	e.rg,
	e.nome,
	e.cpf,
	e.salario
FROM Empregado e
INNER JOIN Dependente d ON e.rg = d.rgresponsavel
LEFT JOIN EmpregadoProjeto ep ON e.rg = ep.rgempregado
WHERE ep.rgempregado IS NULL;

--y.	Qual o projeto que tem mais horas?
SELECT TOP 1
	p.numero,
	p.nome,
	SUM(ep.HORAS) AS 'Máximo de Horas'
FROM Projeto p
INNER JOIN EmpregadoProjeto ep ON p.numero = ep.numeroprojeto
GROUP BY p.numero, p.nome
ORDER BY SUM(ep.HORAS) DESC;

--z.	Qual o projeto que tem menos horas?
SELECT TOP 1
	p.numero,
	p.nome,
	SUM(ep.HORAS) AS 'Máximo de Horas'
FROM Projeto p
INNER JOIN EmpregadoProjeto ep ON p.numero = ep.numeroprojeto
GROUP BY p.numero, p.nome
ORDER BY SUM(ep.HORAS);