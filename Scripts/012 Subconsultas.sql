SELECT DISTINCT BAIRRO FROM tabela_de_vendedores;

#Subconsulta:
SELECT * FROM tabela_de_clientes
	WHERE BAIRRO IN (SELECT DISTINCT BAIRRO FROM tabela_de_vendedores);

SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) FROM tabela_de_produtos
GROUP BY EMBALAGEM;

SELECT X.EMBALAGEM, X.PRECO_MAXIMO FROM 
(SELECT EMBALAGEM, MAX(PRECO_DE_LISTA) as PRECO_MAXIMO FROM tabela_de_produtos
GROUP BY EMBALAGEM) X WHERE X.PRECO_MAXIMO >= 10;



SELECT CPF, COUNT(*) FROM notas_fiscais GROUP BY CPF


  SELECT CPF, COUNT(*) qtd FROM notas_fiscais
  WHERE YEAR(DATA_VENDA) = 2016
  GROUP BY CPF
  HAVING COUNT(*) > 2000;
  
  select CPF, MAX(QTD) from (
     SELECT CPF, COUNT(*) qtd FROM notas_fiscais
  WHERE YEAR(DATA_VENDA) = 2016
  GROUP BY CPF) T 
  GROUP BY T.CPF
  
  

