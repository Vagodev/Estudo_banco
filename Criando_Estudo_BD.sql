CREATE TABLE cliente(
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cnpj_cpf VARCHAR(16) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    tipo_cliente VARCHAR(2) NOT NULL,
    PRIMARY KEY (id_cliente)
);
 
CREATE TABLE venda(
    id_venda INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL,
    hora TIMESTAMP NOT NULL,
    total INT NOT NULL,
    cliente_id INT NOT NULL,
    forma_pagamento_id INT NOT NULL,
    PRIMARY KEY (id_venda),
    FOREIGN KEY (cliente_id) REFERENCES cliente(id_cliente),
    FOREIGN KEY (forma_pagamento_id) REFERENCES forma_pagamento(id_forma_pagamento)  
    
);
CREATE TABLE forma_pagamento(
    id_forma_pagamento INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(100) NOT NULL,        
    PRIMARY KEY (id_forma_pagamento)
);
 
CREATE TABLE item_venda(    
    quantidade INT NOT NULL,
    numero_nf INT NOT NULL,
    venda_id INT NOT NULL,
  produto_id INT NOT NULL,
  FOREIGN KEY (venda_id) REFERENCES venda(id_venda),
  FOREIGN KEY (produto_id) REFERENCES produto(id_produto)   
);
 
CREATE TABLE produto(
    id_produto INT NOT NULL AUTO_INCREMENT,
    preco_venda DOUBLE NOT NULL,
    data_validade DATE NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    distribuidor_id INT NOT NULL,
    PRIMARY KEY (id_produto),
    FOREIGN KEY (distribuidor_id) REFERENCES distribuidor(id_distribuidor)
);
 
 
CREATE TABLE distribuidor(
    id_distribuidor INT NOT NULL AUTO_INCREMENT,
    telefone VARCHAR(11) NOT NULL,
    razao_social VARCHAR(100) NOT NULL, 
    PRIMARY KEY (id_distribuidor)
);
 
 
 