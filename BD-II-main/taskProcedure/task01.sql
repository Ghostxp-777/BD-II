DROP DATABASE IF EXISTS pet_shop;

CREATE DATABASE pet_shop;

USE pet_shop;

CREATE TABLE cliente(
    cpf CHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    telefone CHAR(11) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    CONSTRAINT PKcliente PRIMARY KEY(cpf)
);

CREATE TABLE animal(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100),
    tipo VARCHAR(50) NOT NULL,
    clienteCPF CHAR(11) NOT NULL,
    CONSTRAINT PKanimal PRIMARY KEY(id),
    CONSTRAINT FKDonoAnimal FOREIGN KEY (clienteCPF) REFERENCES cliente(cpf)
);

CREATE TABLE funcionario(
    cpf CHAR(11) NOT NULL,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    telefone CHAR(11) NOT NULL,
    funcao VARCHAR(100),
    CONSTRAINT PKfuncionario PRIMARY KEY(cpf)
);

CREATE TABLE servico_animal(
    id INT AUTO_INCREMENT NOT NULL,
    clienteCPF CHAR(11) NOT NULL,
    funcionarioCPF CHAR(11) NOT NULL,
    idAnimal INT NOT NULL,
    descServico VARCHAR(300),
    preco DECIMAL(10,2) NOT NULL,
    dataServico DATE NOT NULL,
    CONSTRAINT PKservico PRIMARY KEY(id),
    CONSTRAINT FKclienteServico FOREIGN KEY (clienteCPF) REFERENCES cliente(cpf),
    CONSTRAINT FKfuncionarioServico FOREIGN KEY (funcionarioCPF) REFERENCES funcionario(cpf)
);

CREATE TABLE produto(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100),
    descProd VARCHAR(300),
    preco DECIMAL(10,2) NOT NULL,
    qtdEstoque INT NOT NULL,
    CONSTRAINT PKproduto PRIMARY KEY(id)
);

INSERT INTO cliente (cpf, nome, telefone, endereco) VALUES
(12345678901, 'João da Silva', 21987654321, 'Rua das Flores, 123 - Rio de Janeiro/RJ'),
(23456789012, 'Maria Oliveira', 11976543210, 'Avenida Brasil, 456 - São Paulo/SP'),
(34567890123, 'Carlos Pereira', 31965432109, 'Rua dos Pinheiros, 789 - Belo Horizonte/MG'),
(45678901234, 'Ana Santos', 41954321098, 'Alameda Santos, 101 - Curitiba/PR'),
(56789012345, 'Pedro Costa', 51943210987, 'Rua das Palmeiras, 202 - Porto Alegre/RS');

INSERT INTO animal (nome, tipo, clienteCPF) VALUES
('Rex', 'Cachorro', 12345678901),
('Mimi', 'Gato', 12345678901),
('Thor', 'Cachorro', 23456789012),
('Luna', 'Gato', 34567890123),
('Pipoca', 'Coelho', 45678901234),
('Nemo', 'Peixe', 56789012345),
('Mel', 'Cachorro', 23456789012),
('Bola', 'Hamster', 34567890123);

INSERT INTO funcionario (cpf, nome, endereco, telefone, funcao) VALUES
(98765432109, 'Roberto Almeida', 'Rua dos Funcionários, 100 - Rio de Janeiro/RJ', 21912345678, 'Veterinário'),
(87654321098, 'Juliana Mendes', 'Avenida Trabalho, 200 - São Paulo/SP', 11923456789, 'Banhista'),
(76543210987, 'Fernando Costa', 'Rua Serviço, 300 - Belo Horizonte/MG', 31934567890, 'Tosador'),
(65432109876, 'Patrícia Lima', 'Alameda Profissional, 400 - Curitiba/PR', 41945678901, 'Atendente'),
(54321098765, 'Ricardo Souza', 'Rua do Trabalho, 500 - Porto Alegre/RS', 51956789012, 'Veterinário');

INSERT INTO produto (nome, descProd, preco, qtdEstoque) VALUES
('Ração Premium Cães', 'Ração super premium para cães adultos', 149.90, 50),
('Ração Light Gatos', 'Ração para gatos com tendência à obesidade', 89.90, 30),
('Shampoo Hidratante', 'Shampoo para pets com pele sensível', 39.90, 100),
('Brinquedo Pelúcia', 'Brinquedo macio em formato de osso', 24.90, 75),
('Coleira Antipulgas', 'Coleira com proteção contra pulgas por 8 meses', 79.90, 40),
('Areia Sanitária', 'Areia higiênica aglomerante para gatos', 34.90, 60),
('Transporte Pet', 'Caixa de transporte para animais pequenos', 129.90, 15);

INSERT INTO servico_animal (clienteCPF, funcionarioCPF, idAnimal, descServico, preco, dataServico) VALUES
(12345678901, 98765432109, 1, 'Consulta de rotina anual', 150.00, '2023-01-15'),
(12345678901, 87654321098, 1, 'Banho e Tosa completo', 120.00, '2023-01-16'),
(23456789012, 76543210987, 3, 'Tosa higiênica', 80.00, '2023-02-05'),
(34567890123, 98765432109, 4, 'Vacinação anual', 90.00, '2023-02-10'),
(45678901234, 87654321098, 5, 'Banho especial', 65.00, '2023-03-01'),
(56789012345, 76543210987, 6, 'Limpeza de aquário', 45.00, '2023-03-15'),
(23456789012, 98765432109, 7, 'Consulta emergência', 200.00, '2023-04-02'),
(34567890123, 87654321098, 8, 'Banho medicinal', 75.00, '2023-04-10'),
(12345678901, 98765432109, 2, 'Exame de sangue', 180.00, '2023-05-05'),
(45678901234, 76543210987, 5, 'Tosa de coelho', 60.00, '2023-05-20');

CREATE VIEW boletim_servicos AS
SELECT
    c.cpf AS cliente_cpf,
    c.nome AS nome_cliente,
    a.nome AS nome_animal,
    sa.descServico,
    f.nome AS nome_funcionario,
    sa.preco,
    sa.dataServico
FROM servico_animal sa
JOIN cliente c ON sa.clienteCPF = c.cpf
JOIN animal a ON sa.idAnimal = a.id
JOIN funcionario f ON sa.funcionarioCPF = f.cpf;

CREATE TABLE compra(
    id INT AUTO_INCREMENT NOT NULL,
    clienteCPF CHAR(11) NOT NULL,
    funcionarioCPF CHAR(11) NOT NULL,
    valorTotal DECIMAL(10, 2) NOT NULL,
    dataCompra DATE NOT NULL,
    CONSTRAINT PKcompra PRIMARY KEY(id),
    CONSTRAINT FKclienteCompra FOREIGN KEY (clienteCPF) REFERENCES cliente(cpf),
    CONSTRAINT FKfuncionarioCompra FOREIGN KEY (funcionarioCPF) REFERENCES funcionario(cpf)
);

CREATE TABLE compraProduto(
    idProduto INT NOT NULL,
    idCompra INT NOT NULL,
    CONSTRAINT FKprodutoComprado FOREIGN KEY (idProduto) REFERENCES produto(id),
    CONSTRAINT FKcompraDoProduto FOREIGN KEY (idCompra) REFERENCES compra(id)
);

DELIMITER $$

CREATE PROCEDURE servicos_prestados_por_cliente (
    IN p_cpf_busca CHAR(11),
    IN p_data_filtro DATE
)
BEGIN
    SELECT * FROM boletim_servicos
    WHERE cliente_cpf = p_cpf_busca
        AND dataServico > p_data_filtro;
END $$

DELIMITER ;

CALL servicos_prestados_por_cliente('12345678901', '2020-02-01');

DELIMITER $$

CREATE PROCEDURE relatorio_compras_por_periodo (
    
)

