---------------- LISTA 03

-- 5)	Liste o nome de cada garçom (usuário) e o valor total em pedidos que cada um fez. 
SELECT 
	us.login,
	AVG(pe.ValorTotal) AS 'Valor total em pedidos'
FROM Usuario us
INNER JOIN Pedido pe ON us.CodUsuario = pe.Usuario
GROUP BY us.login;

-- 6) Mostre a soma do valor totalde todas as contas que não tiveram data e hora de fechamento.
SELECT
	co.CodConta,
	co.Mesa,
	SUM(co.total) AS 'Soma do Valor Total'
FROM Conta co
WHERE co.HoraFechamento IS NULL
GROUP BY
	co.CodConta,
	co.Mesa
ORDER BY Sum(co.total);

-- 7) Liste o nome dos garçons que nunca fizeram nenhum pedido. 
SELECT
	us.CodUsuario,
	us.Login
FROM Usuario us
LEFT JOIN Pedido pe ON us.CodUsuario = pe.Usuario
WHERE pe.Usuario is NULL;

-- 8) Mostre a média de preço de cada produto agrupado pelo tipo do produto.
SELECT 
	pr.Tipo,
	AVG(pr.Preco) AS 'Média de preço'
FROM Produto pr
GROUP BY pr.Tipo;

-- 9) Mostre a soma de preço de todos os produtos os consumidos para a conta cod = 10.
SELECT
	pr.Nome,
	SUM(pr.Preco) AS 'Soma de Preço'
FROM Produto pr
INNER JOIN Pedido pe ON pr.CodProduto = pe.Produto
WHERE pe.Conta = 10
GROUP BY pr.Nome;

---------------------------------------- LISTA EXERCICIOS

--1) Selecione todos os campos da tabela empregados ordenados por RG em ordem decrescente.
SELECT 
	em.RG, 
	em.NOME, 
	em.CPF, 
	em.DEPARTAMENTO, 
	em.RGSUPERVISOR, 
	em.SALARIO
FROM Empregado em
ORDER BY em.RG DESC;

--2) Selecione o nome de todos os empregados e o nome, a data de nascimento e a relação
-- dos dependentes ordenados por nome do dependente.
SELECT 
	em.Nome,
	de.NomeDependente,
	de.DtNascimento,
	de.Relacao
FROM Empregado em
LEFT JOIN Dependente de ON de.RGResponsavel = em.RG
ORDER BY de.NomeDependente;
	
-- 3) Indique quantos empregados existem por departamentos.
SELECT 
	de.Numero,
	de.Nome,
	SUM(DISTINCT em.Departamento) AS 'Número de Empregados'
FROM Departamento de
LEFT JOIN Empregado em ON de.Numero = em.Departamento
GROUP BY 
	de.Numero,
	de.Nome;

-- 4) Indique quantos projetos existem por departamento.
SELECT 
	de.Numero,
	de.Nome,
	COUNT(de_pr.NumeroProjeto) AS 'Número de Projetos'
FROM Departamento de
LEFT JOIN DepartamentoProjeto de_pr ON de.Numero = de_pr.NumeroDepartamento
GROUP BY
	de.Numero,
	de.Nome;

-- 5) Quais são os empregados que não participam de nenhum projeto?
SELECT 
	em.RG,
	em.Nome,
	em.CPF,
	em.Salario
FROM Empregado em
LEFT JOIN EmpregadoProjeto em_pr ON em.RG = em_pr.RGEmpregado
WHERE RGEMPREGADO IS NULL
GROUP BY 
	em.RG,
	em.Nome,
	em.CPF,
	em.Salario
ORDER BY em.Nome ASC;

-- f) Quais são os empregados que não tem dependentes?
SELECT
	em.RG,
	em.Nome,
	em.CPF,
	em.Departamento,
	em.Salario
FROM Empregado em
LEFT JOIN Dependente de ON em.rg = de.RGRESPONSAVEL
WHERE de.RGRESPONSAVEL IS NULL;

-- g) Quais os empregados que não possuem supervisor?
SELECT
	em.RG,
	em.Nome,
	em.CPF,
	em.Departamento,
	em.Salario
FROM Empregado em
WHERE RGSupervisor IS NULL;

-- h) Quais são os empregados do departamento 1?
SELECT 
	em.RG,
	em.Nome,
	em.CPF,
	em.Departamento,
	em.Salario
FROM Empregado em
WHERE Departamento = 1;

-- i) Quais são os dependentes do Fernando?
SELECT
	de.NumeroDependente,
	de.RGResponsavel,
	de.NomeDependente,
	de.DtNascimento,
	de.Relacao,
	de.Sexo
FROM Dependente de
LEFT JOIN Empregado em ON de.RGRESPONSAVEL = em.RG
WHERE em.Nome LIKE 'Fernando';

-- j) Quantos dependentes do sexo feminino?
SELECT
	COUNT(*) AS 'Quantidade de dependentes do sexo feminino'
FROM Dependente
WHERE Sexo = 'F';

-- k) Quantos dependentes tem mais que 15 anos?
SELECT
	COUNT(*) AS 'Dependentes com mais de 15 anos'
FROM Dependente
WHERE DATEDIFF(YEAR,DtNascimento,getDate()) > 15;

-- l. Quem é o responsável pela Andreia?
SELECT 
	em.Nome
FROM Empregado em
LEFT JOIN Dependente de ON em.RG = de.RGRESPONSAVEL
WHERE de.NomeDependente LIKE 'Andreia';