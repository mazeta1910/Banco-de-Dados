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
GROUP BY 
	e.RG,
	e.nome,
	e.cpf,
	e.departamento,
	e.salario,
	d.rgresponsavel
HAVING d.RGRESPONSAVEL IS NULL;