DROP DATABASE IF EXISTS minhaEmpresa;

CREATE DATABASE minhaEmpresa;

USE minhaEmpresa;

CREATE TABLE locais(
    id INT AUTO_INCREMENT,
    nome_cliente VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    estado VARCHAR(255) NOT NULL,
    regiao VARCHAR(255) NOT NULL,
    CONSTRAINT PKlocal PRIMARY KEY(id)
);

DELIMITER $$

CREATE PROCEDURE inserir_local(
    IN p_nome_cliente VARCHAR(255),
    IN p_cidade VARCHAR(255),
    IN p_estado VARCHAR(255),
    IN p_regiao VARCHAR(255)
)
BEGIN
    INSERT INTO locais (nome_cliente, cidade, estado, regiao) VALUES
    (p_nome_cliente, p_cidade, p_estado, p_regiao);
END $$

DELIMITER ;

CALL inserir_local('Maria Sila', 'São Paulo', 'SP', 'Sudeste');
CALL inserir_local('João Silva', 'Rio de Janeiro', 'RJ', 'Sudeste');
CALL inserir_local('Marta Tupinambá', 'Manaus', 'AM', 'Norte');
CALL inserir_local('Raquel Yamauti', 'Teresina', 'PI', 'Nordeste');
CALL inserir_local('João Felipe', 'São Luís', 'MA', 'Nordeste');
CALL inserir_local('Gustavo Piacente', 'Florianópolis', 'SC', 'Sul');
CALL inserir_local('Daniel Bonfim', 'Cuiabá', 'MT', 'Centro-Oeste');

SELECT * FROM locais;

DELIMITER $$

CREATE PROCEDURE SelecionarClientesPorCidade(IN p_cidade VARCHAR(255))
BEGIN
    SELECT *
    FROM locais
    WHERE cidade = p_cidade;
END $$

DELIMITER ;

CALL SelecionarClientesPorCidade('São Paulo');

DELIMITER $$

CREATE PROCEDURE ContaClientesPorCidade(
    IN p_cidade VARCHAR(255),
    OUT total INT
)
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM locais
    WHERE cidade = p_cidade;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE verificar_regiao(
    IN p_cidade VARCHAR(255),
    OUT mensagem VARCHAR(255)
)
BEGIN
    DECLARE reg VARCHAR(255);
    SELECT regiao INTO reg FROM locais WHERE cidade = p_cidade LIMIT 1;

    IF reg IS NULL THEN
        SET mensagem = 'Cidade não encontrada';
    ELSEIF reg = 'Sudeste' THEN
        SET mensagem = CONCAT('A cidade ', p_cidade, ' está na região Sudeste');
    ELSE
        SET mensagem = CONCAT('A cidade ', p_cidade, ' está em outra região');
    END IF;
END $$

DELIMITER ;