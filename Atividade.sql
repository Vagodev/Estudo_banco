SELECT * FROM CLIENTE;
SELECT * FROM VENDA;
SELECT * FROM FORMA_PAGAMENTO;

/* Qual cliente tem mais vendas? */
SELECT id_cliente, nome, COUNT(1) AS total  FROM cliente c
JOIN venda v ON c.id_cliente = v.cliente_id 
GROUP BY c.NOME 
ORDER BY total DESC
LIMIT 1;

/* Qual forma de pagamento foi menos utilizada em vendas? */
SELECT descricao, MIN(total) FROM (
	SELECT fp.descricao , count(1) total
	FROM venda v
	INNER JOIN forma_pagamento fp
	ON fp.id_forma_pagamento = v.forma_pagamento_id
    GROUP BY forma_pagamento_id 
    ORDER BY count(1) ASC
)subquery;

/*Quais são os clientes cadastrados que nunca efetuaram compra ? */
SELECT C.NOME, C.ID_CLIENTE FROM CLIENTE C
LEFT JOIN VENDA V ON V.CLIENTE_ID = C.ID_CLIENTE WHERE ID_VENDA IS NULL;

/*Qual o nome do cliente que gastou mais dinheiro em compras?*/
SELECT NOME, ID_CLIENTE,  SUM(TOTAL) AS TOTAL_GASTO 
FROM 
CLIENTE C
INNER JOIN VENDA V ON C.ID_CLIENTE = V.CLIENTE_ID
GROUP BY C.NOME
ORDER BY 2 DESC
LIMIT 1;

/*Existem quantos clientes PF e quantos Clientes PJ?*/
SELECT TIPO_CLIENTE,  COUNT(1) TOTAL_TIPO_CLIENTE FROM CLIENTE
GROUP BY TIPO_CLIENTE;

/*Qual total de vendas efetuadas até hoje ?*/
SELECT SUM(TOTAL) TOTAL_EM_VENDAS FROM VENDA;