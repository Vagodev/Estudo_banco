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
SELECT C.NOME, C.ID_CLIENTE FROM CLIENTE  C
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


/* QUAL DISTRIBUIDOR POSSUI MAIS PRODUTOS CADASTRADOS NA BASE DE DADOS? */
SELECT RAZAO_SOCIAL,  COUNT(1) AS total  FROM DISTRIBUIDOR D
JOIN PRODUTO P  ON D.ID_DISTRIBUIDOR = P.DISTRIBUIDOR_ID 
GROUP BY D.ID_DISTRIBUIDOR
ORDER BY TOTAL DESC 
LIMIT 1;

/* QUAL O PRODUTO MAIS VENDIDO NA BASE DE DADOS ? */
SELECT DESCRICAO,  COUNT(1),SUM(TOTAL) TOTAL_PRODUTOS FROM VENDA
GROUP BY DESCRICAO
ORDER BY TOTAL_PRODUTOS DESC
LIMIT 1;

SELECT DESCRICAO FROM (
SELECT P.DESCRICAO, sum(IV.QUANTIDADE) TOTAL FROM ITEM_VENDA IV INNER JOIN VENDA V ON V.ID_VENDA = IV.VENDA_ID
INNER JOIN PRODUTO P ON IV.PRODUTO_ID = P.ID_PRODUTO GROUP BY IV.PRODUTO_ID ORDER BY sum(IV.QUANTIDADE) DESC LIMIT 1) SUB;

/* QUAIS VENDAS TEM A FORMA DE PAGAMENTO IGUAL A BOLETO? DEVE USAR SUBQUERY */
SELECT DESCRICAO FROM (
SELECT V.DESCRICAO FROM VENDA V INNER JOIN FORMA_PAGAMENTO FP ON FP.ID_FORMA_PAGAMENTO = V.FORMA_PAGAMENTO_ID 
WHERE FP.DESCRICAO = "BOLETO"
) SUB;


-- Criando a TABELA que receberá os dados pela TRIGGER
DROP TABLE IF EXISTS clientes_auditoria;
 
CREATE TABLE clientes_auditoria (
    id_cliente_auditoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_antigo VARCHAR(100) NOT NULL,
    nome_novo VARCHAR(100) NOT NULL,
    cnpj_cpf_antigo VARCHAR(16) NOT NULL,
    cnpj_cpf_novo VARCHAR(16) NOT NULL,
    endereco_antigo VARCHAR(100) NOT NULL,
    endereco_novo VARCHAR(100) NOT NULL,
    tipo_cliente_antigo VARCHAR(20) NOT NULL,
    tipo_cliente_novo VARCHAR(20) NOT NULL ,
    data_hora DATETIME 
);
 
-- Criando a TRIGGER 
DROP TRIGGER IF EXISTS tg_auditoria_clientes;
 
CREATE TRIGGER tg_auditoria_clientes
AFTER UPDATE ON clientes 
FOR EACH ROW 
BEGIN 
    INSERT INTO clientes_auditoria 
    (nome_antigo, nome_novo, cnpj_cpf_antigo, cnpj_cpf_novo, endereco_antigo, endereco_novo, 
    tipo_cliente_antigo, tipo_cliente_novo, data_hora)
    VALUES (OLD.nome, NEW.nome, OLD.cnpj_cpf, NEW.cnpj_cpf, OLD.endereco, NEW.endereco, 
    OLD.tipo_cliente, NEW.tipo_cliente ,  NOW()
    );
    
END ;   
 
-- Acionando a TRIGGER através de um gatilho.
UPDATE cliente
SET nome='victor', cnpj_cpf='47507', endereco='rua dois', tipo_cliente='PJ'
WHERE id_cliente=1;
 
-- Verificando os resultados nas tabelas
SELECT * FROM cliente;
SELECT * FROM clientes_auditoria;
 
 
/*
==================================
 
            PROCEDURE
  
================================== 
*/
 
 
CREATE PROCEDURE total_clientes(in tabela int)
BEGIN
    DECLARE qtde int;
 
    IF tabela = 1 THEN 
        SELECT COUNT(*) INTO qtde FROM cliente; 
        SELECT 'o valor da tabela cliente é' + qtde;
    END IF;
        
END
 
-- CALL (comando para chamar e executar o procedimento)
 
CALL total_clientes(1);
 

 
 
 
 
/* * * * * * * * * * * * * * * * *
 *                               *
 *      EXERCÍCIOS               *
 *                               *
 * * * * * * * * * * * * * * * * */
 
 
-- Criar uma trigger para fazer auditoria da forma_pagamento
 
 
CREATE table forma_pagamento_auditoria (
    id_forma_pagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    forma_pagamento_antigo  VARCHAR(100) NOT NULL,
    forma_pagamento_novo  VARCHAR(100) NOT NULL);
 
CREATE TRIGGER tg_forma_pagamento_auditoria
AFTER UPDATE ON forma_pagamento  
FOR EACH ROW 
BEGIN 
    INSERT INTO forma_pagamento_auditoria 
    (forma_pagamento_antigo, forma_pagamento_novo)
    VALUES (OLD.forma_pagamento, NEW.forma_pagamento
    );
    
END ;   
 
UPDATE forma_pagamento 
SET forma_pagamento ='dinheiro'
WHERE id_forma_pagamento =3;
 
SELECT * FROM forma_pagamento fp ;
SELECT * FROM forma_pagamento_auditoria ;

/* criando trigger para auditoria na tabela cliente */
CREATE TRIGGER tg_auditoria_cliente
AFTER UPDATE ON cliente 
FOR EACH ROW
BEGIN
INSERT INTO cliente_autitoria (nome_antigo, nome_novo, cnpj_cpf_antigo, cnpj_cpf_novo, endereco_antigo, endereco_novo, tipo_cliente_antigo, tipo_cliente_novo) 
VALUES(OLD.nome, NEW.nome, OLD.cnpj_cpf, NEW.cnpj_cpf, OLD.endereco, NEW.endereco, OLD.tipo_cliente, NEW.tipo_cliente);
END;

-- Criar uma procedure para imprimir o total de registros da tabela vendas
 
CREATE PROCEDURE total_vendas(IN tabela INT)
BEGIN
    DECLARE qtde INT;
    IF tabela = 1 THEN 
        SELECT COUNT(*) INTO qtde FROM venda; 
        SELECT 'o total de registros na tabela vendas é' + qtde;
    END IF;
    
END
 
 
 
CALL total_vendas(1);