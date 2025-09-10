CREATE DATABASE sistema_RH;

USE sistema_RH;

CREATE TABLE departamentos(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    CONSTRAINT PKdepartamentos PRIMARY KEY(id)
);

CREATE TABLE funcionarios(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    idDepartamento INT NOT NULL,
    CONSTRAINT PKfuncionarios PRIMARY KEY(id),
    CONSTRAINT FKcodigoDepartamento FOREIGN KEY (idDepartamento) REFERENCES departamentos(id)
);


CREATE TABLE projetos(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    idFuncionario INT NOT NULL,
    CONSTRAINT PKprojetos PRIMARY KEY(id),
    CONSTRAINT FKfuncionarioResponsavel FOREIGN KEY (idFuncionario) REFERENCES funcionarios(id)
);

INSERT INTO departamentos (nome) VALUES
('Tecnologia da Informação'),
('Recursos Humanos'),
('Financeiro'),
('Marketing'),
('Operações');

INSERT INTO funcionarios (nome, email, idDepartamento) VALUES
('João Silva', 'joao.silva@empresa.com', 1),
('Maria Santos', 'maria.santos@empresa.com', 2),
('Pedro Costa', 'pedro.costa@empresa.com', 3),
('Ana Oliveira', 'ana.oliveira@empresa.com', 4),
('Carlos Pereira', 'carlos.pereira@empresa.com', 5),
('Juliana Almeida', 'juliana.almeida@empresa.com', 1),
('Ricardo Fernandes', 'ricardo.fernandes@empresa.com', 2),
('Fernanda Lima', 'fernanda.lima@empresa.com', 3),
('Lucas Martins', 'lucas.martins@empresa.com', 4),
('Patrícia Rocha', 'patricia.rocha@empresa.com', 5);

INSERT INTO projetos (nome, idFuncionario) VALUES
('Sistema de Gestão Interna', 1),
('Programa de Treinamento', 2),
('Otimização de Custos', 3),
('Campanha Publicitária Verão', 4),
('Expansão de Unidades', 5),
('Atualização de Infraestrutura', 6),
('Processo Seletivo 2024', 7),
('Auditoria Anual', 8),
('Lançamento de Produto', 9),
('Melhoria na Logística', 10);

CREATE VIEW equipeProjeto AS
SELECT
    d.id AS codigo_departamento,
    d.nome AS nome_departamento,
    f.id AS codigo_funcionario,
    f.nome AS nome_funcionario,
    f.email AS email_funcionario,
    p.id AS codigo_projeto,
    p.nome AS nome_projeto
FROM projetos p
INNER JOIN funcionarios f ON p.idFuncionario = f.id
INNER JOIN departamentos d ON f.idDepartamento = d.id
ORDER BY p.id, f.id;

