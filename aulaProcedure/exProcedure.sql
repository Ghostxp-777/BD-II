DROP DATABASE IF EXISTS autenticacao;

CREATE DATABASE autenticacao; 

USE autenticacao;

CREATE TABLE usuarios(
    id INT AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    usuario VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    CONSTRAINT PKusuario PRIMARY KEY usuarios(id)
);

DELIMITER $$

CREATE PROCEDURE autentica_usuario(
    IN p_usuario VARCHAR(255),
    IN p_senha VARCHAR(255),
    OUT p_autenticado INT
)
BEGIN
    SELECT COUNT(*) INTO p_autenticado
    FROM usuarios
    WHERE usuario = p_usuario AND senha = p_senha;
END $$

DELIMITER ;

CALL autentica_usuario('exemplo', 'minnhasenha', @resultado);

SELECT @resultado;

INSERT INTO usuarios (nome, usuario, senha)
VALUES ('João Silva', 'jao gay', 'senhalegal');

INSERT INTO usuarios (nome, usuario, senha)
VALUES ('Maria Júlia', 'julia minegirl', 'senhanaolegal');

CALL autentica_usuario('julia minegirl', 'senhanaolegal', @resultado);

SELECT @resultado;