SELECT * FROM itens_notas_fiscais;

SELECT * FROM notas_fiscais;

SELECT NF.CPF, NF.DATA_VENDA, INF.QUANTIDADE FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO;

SELECT NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, INF.QUANTIDADE FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO;

/* Consulta com vendas de clientes por mês */
SELECT NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, SUM(INF.QUANTIDADE) AS QTD_VENDAS
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
GROUP BY NF.CPF, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');


/* Limite de compra por cliente */
SELECT * FROM tabela_de_clientes;
SELECT TC.CPF, TC.NOME, TC.VOLUME_DE_COMPRA AS QTD_LIMITE
FROM tabela_de_clientes TC;


SELECT NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, SUM(INF.QUANTIDADE) AS QTD_VENDAS,
TC.VOLUME_DE_COMPRA AS QTD_LIMITE
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
INNER JOIN tabela_de_clientes TC
ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');


SELECT NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, SUM(INF.QUANTIDADE) AS QTD_VENDAS,
MAX(TC.VOLUME_DE_COMPRA) AS QTD_LIMITE
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
INNER JOIN tabela_de_clientes TC
ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m');


SELECT X.CPF, X.NOME, X. MES_ANO, X.QTD_VENDAS, X.QTD_LIMITE,
X.QTD_LIMITE - X.QTD_VENDAS DIFERENÇA
FROM (
SELECT NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, SUM(INF.QUANTIDADE) AS QTD_VENDAS,
MAX(TC.VOLUME_DE_COMPRA) AS QTD_LIMITE
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
INNER JOIN tabela_de_clientes TC
ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')) X;


SELECT X.CPF, X.NOME, X. MES_ANO, X.QTD_VENDAS, X.QTD_LIMITE,
CASE WHEN (X.QTD_LIMITE - X.QTD_VENDAS) < 0 THEN 'Inválida'
ELSE 'Válida' END AS STATUS_VENDA
FROM (
SELECT NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, SUM(INF.QUANTIDADE) AS QTD_VENDAS,
MAX(TC.VOLUME_DE_COMPRA) AS QTD_LIMITE
FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
INNER JOIN tabela_de_clientes TC
ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')) X;



SELECT X.CPF, X.NOME, X. MES_ANO, X.QTD_VENDAS, X.QTD_LIMITE,
CASE WHEN (X.QTD_LIMITE - X.QTD_VENDAS) < 0 THEN 'Inválida'
ELSE 'Válida' END AS STATUS_VENDA,
ROUND((1-(X.QTD_LIMITE/X.QTD_VENDAS))*100,2) PORCENTAGEM
FROM (
SELECT NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m') AS MES_ANO, SUM(INF.QUANTIDADE) AS QTD_VENDAS,
MAX(TC.VOLUME_DE_COMPRA) AS QTD_LIMITE FROM notas_fiscais NF 
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
INNER JOIN tabela_de_clientes TC
ON TC.CPF = NF.CPF
GROUP BY NF.CPF, TC.NOME, DATE_FORMAT(NF.DATA_VENDA, '%Y-%m')

) X WHERE (X.QTD_LIMITE - X.QTD_VENDAS) < 0 ;