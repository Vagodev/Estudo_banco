INSERT INTO cliente (nome, cnpj_cpf, endereco, tipo_cliente) VALUES ('Larissa', 1111111, 'Rua Primavera', 'PF');
INSERT INTO cliente (nome, cnpj_cpf, endereco, tipo_cliente) VALUES ('Oziel', 2222222, 'Rua Três', 'PJ');
INSERT INTO cliente (nome, cnpj_cpf, endereco, tipo_cliente) VALUES ('Fernanda', 333333, 'Rua B', 'PF');
  
INSERT INTO distribuidor(telefone,razao_social) VALUES (777777, 'Distribuidora A');
INSERT INTO distribuidor(telefone,razao_social) VALUES (88888, 'Distribuidora B');
INSERT INTO distribuidor(telefone,razao_social) VALUES (999999, 'Distribuidora C');
  
INSERT INTO produto (preco_venda, data_validade, descricao, distribuidor_id) VALUES ( 25.96, '2022-02-02','Produto A', 1); 
INSERT INTO produto (preco_venda, data_validade, descricao, distribuidor_id) VALUES ( 896.63, '2021-02-05','Produto B', 2);
INSERT INTO produto (preco_venda, data_validade, descricao, distribuidor_id) VALUES ( 8963.63, '2023-05-05','Produto C', 3);  
INSERT INTO forma_pagamento(descricao) VALUES ('PIX');
INSERT INTO forma_pagamento(descricao) VALUES ('BOLETO');
INSERT INTO forma_pagamento(descricao) VALUES ('DEBITO');
INSERT INTO venda(descricao, hora, total, cliente_id, forma_pagamento_id) VALUES ( 'Venda 1', current_timestamp(), 89.6, 1, 1);
INSERT INTO venda(descricao, hora, total, cliente_id, forma_pagamento_id) VALUES ( 'Venda 2', now(), 69.6, 2, 2);
INSERT INTO venda(descricao, hora, total, cliente_id, forma_pagamento_id) VALUES ( 'Venda 3', '2022-01-01 00:00:01', 890.6, 3, 3);
INSERT INTO item_venda(quantidade,numero_nf, venda_id, produto_id) VALUES (896, 111111, 1, 1);
INSERT INTO item_venda(quantidade,numero_nf, venda_id, produto_id) VALUES (1526,22222, 2, 2);
INSERT INTO item_venda(quantidade,numero_nf, venda_id, produto_id) VALUES (89689, 333333, 3, 3);