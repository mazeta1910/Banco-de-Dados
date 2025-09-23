-- a) Crie um comando de sele��o que liste os bois que nasceram entre o dia 01 de janeiro e a data de hoje.
-- O Select deve exibir dos bois: nome, data de nascimento, cor e ra�a e as informa��es dos seus genitores: nome, cor e ra�a, se n�o houver genitores, o boi deve ser exibido.
SELECT DISTINCT
	ga.nome AS 'Nome',
	ga.data_nascimento AS 'Data de Nascimento',
	co.descricao AS 'Cor',
	ra.descricao AS 'Ra�a',
	ga_genf.nome AS 'Nome da Genitora',
	co_genf.descricao AS 'Cor',
	ra_genf.descricao AS 'Ra�a',
	ga_genm.nome AS 'Nome do Genitor',
	co_genm.descricao AS 'Cor',
	ra_genm.descricao AS 'Ra�a'
FROM Gado ga
INNER JOIN Cor co ON ga.IDCOR = co.IDCOR
INNER JOIN Raca ra ON ga.IDRACA = ra.IDRACA
LEFT JOIN Gado ga_genf ON ga.IDGENITORA = ga_genf.IDGADO
LEFT JOIN Cor co_genf ON ga_genf.IDCOR = co_genf.IDCOR
LEFT JOIN Raca ra_genf ON ga_genf.IDRACA = ra_genf.IDRACA
LEFT JOIN Gado ga_genm ON ga.IDGENITOR = ga_genm.IDGADO
LEFT JOIN Cor co_genm ON ga_genf.IDCOR = co_genm.IDCOR
LEFT JOIN Raca ra_genm ON ga_genf.IDRACA = ra_genm.IDRACA;

-- b) Exiba o nome, data de nascimento de todos os animais que nunca estiveram no pasto "GREY".
SELECT 
	ga.nome AS 'Nome do Animal',
	ga.data_nascimento AS 'Data de Nascimento'
FROM Gado ga
LEFT JOIN Gado_Pasto ga_pa ON ga.IDGADO = ga_pa.IDGADO
LEFT JOIN Pasto pa ON ga_pa.IDPASTO = pa.IDPASTO
WHERE pa.NOMEPASTO != 'GREY';


-- c) Mostre a m�dia de peso no abate por ra�a, e ordene o resultado pela m�dia. Exiba somente ra�as cuja m�dia seja maior que 255 quilos.
SELECT 
	ra.IDRaca,
	ra.Descricao,
	AVG(ra.Peso_Medio_Femea + ra.Peso_Medio_Macho) AS 'M�dia de Pesos'
FROM Raca ra
GROUP BY ra.IDRaca, ra.Descricao
HAVING AVG(ra.Peso_Medio_Femea + ra.Peso_Medio_Macho) > 255

-- d) Exiba todos os atributos da tabela pasto, por�m apenas pastos que fiquem na localiza��o "BIG APPLE"
SELECT
	pa.IDPasto AS 'ID Pasto',
	pa.NomePasto AS 'Nome do Pasto',
	pa.Localizacao AS 'Localiza��o do Pasto',
	pa.Capacidade AS 'Capacidade do Pasto'
FROM Pasto pa
WHERE pa.Localizacao = 'BIG APPLE';

-- e) Exiba o nome do animal, sua ra�a e o n�mero total de pastos que este animal j� exsteve.
SELECT 
	ga.nome AS 'Nome do Animal',
	ra.descricao AS 'Ra�a',
COUNT(pa.IDPasto) AS 'N�mero Total de Pastos'
FROM Gado ga
INNER JOIN Gado_Pasto ga_pa ON ga.IDGADO = ga_pa.IDGADO
INNER JOIN Raca ra ON ga.IDRACA = ra.IDRACA
INNER JOIN Pasto pa ON ga_pa.IDPASTO = pa.IDPASTO
GROUP BY 
	ga.nome, 
	ra.descricao;

-- f) Exiba os animais e a idade dos animais em meses, mas exiba somente aqueles que tenham nascimento h� mais de 5 meses.

-- g) Exiba uma listagem contendo o nome de todos os animais que s�o genitor ou genitora de outros animais. Utilize operadores de conjuntos para resolver a quest�o. 
-- N�o devem ser exibidos genitores duplicados/repetidos.
SELECT ga.nome
FROM Gado ga

-- h) Liste nome, cor e ra�a, bem como os dados das vacinas, como nome, data aplica��o, data da pr�xima vacina. O nome, a cor e a ra�a devem ser retornado em um mesmo campo, no 
-- seguinte formato: 'Nome - Cor - Ra�a' e este deve ser apelidado de animal. Ordene pela data de aplica��o da vacina de forma decrescenten.
SELECT 
	ga.nome,
	co.descricao,
	ra.descricao,
	va.nome,
	ga_va.data_aplicacao,
	ga_va.data_proxima
FROM Gado ga
INNER JOIN Cor co ON ga.IDCOR = co.IDCOR
INNER JOIN Raca ra ON ga.IDRACA = ra.IDRACA
INNER JOIN Gado_Vacina ga_va ON ga.IDGADO = ga_va.IDGADO
INNER JOIN Vacina va ON ga_va.IDVACINA = va.IDVACINA
ORDER BY ga_va.data_aplicacao DESC;

-- i) Exiba o nome, ra�a, cor de todos os animais que estiveram no pasto "BLUE" e que nunca estiveram no pasto "GREY"
SELECT 
	ga.nome,
	ra.descricao,
	co.descricao
FROM Gado ga
INNER JOIN Cor co ON ga.IDCOR = co.IDCOR
INNER JOIN Raca ra ON ga.IDRACA = ra.IDRACA
INNER JOIN Gado_Pasto ga_pa ON ga.IDGADO = ga_pa.IDGADO
LEFT JOIN Pasto pa ON ga_pa.IDPASTO = pa.IDPASTO
WHERE pa.NOMEPASTO = 'BLUE' AND pa.NOMEPASTO != 'GREY';

-- j) Elabore um select que exiba se existem animais g�meos, considere que para ser g�meos eles devem ter nascido no mesmo dia
-- e possuir os mesmos genitores.
SELECT 
	ga1.nome AS 'Nome do Gado 1',
	ga1.data_nascimento AS 'Data de Nascimento do Gado 2',
	ga1.idgenitor AS 'ID do Genitor do Gado 1',
	ga1.idgenitora AS 'ID da Genitora do Gado 1',
	ga2.nome AS 'Nome do Gado 2',
	ga2.data_nascimento AS 'Data de Nascimento do Gado 2',
	ga2.idgenitor AS 'ID do Genitor do Gado 1',
	ga2.idgenitora AS 'ID da Genitora do Gado 2'
FROM Gado ga1
INNER JOIN Gado ga2 ON ga1.IDGENITOR = ga2.IDGENITOR AND ga1.DATA_NASCIMENTO = ga2.DATA_NASCIMENTO AND ga1.IDGENITORA = ga2.IDGENITORA
WHERE ga1.nome != ga2.nome;


