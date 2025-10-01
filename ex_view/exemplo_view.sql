-- Criando o Database (Banco de Dados)
CREATE DATABASE exemplo_views;
Use exemplo_views;

-- Criando a Tabela de clientes
CREATE TABLE clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2)
);

-- Criando a Tabela de pedidos
CREATE TABLE pedidos(
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    produto VARCHAR(100),
    valor DECIMAL(10, 2),
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Inserindo dados na tabela cliente
INSERT INTO clientes(nome, cidade, estado) VALUES
('João Silva', 'São Paulo', 'SP'),
('Maria Oliveira', 'Rio de Janeiro', 'RJ'),
('Carlos Souza', 'Campinas', 'SP');

-- Inserindo Pedidos na tabela pedidos
INSERT INTO pedidos (cliente_id, produto, valor, data_pedido) VALUES
(1, 'Notebook', 3500.00, '2025-05-01'),
(2, 'Mouse', 80.00, '2025-05-03'),
(3, 'Teclado', 120.00, '2025-05-02'),
(3, 'Monitor', 800.00, '2025-05-04');

-- Criando uma View
CREATE VIEW relatorio_pedidos AS
SELECT
    c.nome AS cliente,
    c.cidade,
    p.produto,
    p.valor,
    p.data_pedido
    FROM pedidos p
    JOIN clientes c ON p.cliente_id = c.id;

-- Vizualizar a View
SELECT * FROM relatorio_pedidos;

