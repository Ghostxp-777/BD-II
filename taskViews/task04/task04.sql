CREATE DATABASE academySystem;

USE academySystem;

CREATE TABLE alunos(
    matricula CHAR(8) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    CONSTRAINT PKalunos PRIMARY KEY(matricula)
);

CREATE TABLE professores(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT PKprofessores PRIMARY KEY(id)
);

CREATE TABLE disciplinas(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    idProfessor INT NOT NULL,
    CONSTRAINT PKdisciplinas PRIMARY KEY(id),
    CONSTRAINT FKcodigoProfessor FOREIGN KEY (idProfessor) REFERENCES professores(id)
);

CREATE TABLE historicosEscolares(
    id INT AUTO_INCREMENT NOT NULL,
    idAluno CHAR(8) NOT NULL,
    idDisciplina INT NOT NULL,
    semestre INT NOT NULL,
    media DECIMAL(4,2) NOT NULL,
    faltas INT NOT NULL,
    situacao VARCHAR(255) NOT NULL,
    CONSTRAINT PKhistoricos PRIMARY KEY(id),
    CONSTRAINT FKcodigoDisciplina FOREIGN KEY (idDisciplina) REFERENCES disciplinas(id),
    CONSTRAINT FKmatriculaAluno FOREIGN KEY (idAluno) REFERENCES alunos(matricula)
);

CREATE TABLE cursos(
    id INT AUTO_INCREMENT NOT NULL,
    codigo CHAR(6) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cargaHoraria INT NOT NULL,
    duracaoMeses INT NOT NULL,
    CONSTRAINT PKcursos PRIMARY KEY(id)
);

INSERT INTO professores (nome, email) VALUES
('Ana Silva', 'ana.silva@academy.com'),
('Carlos Oliveira', 'carlos.oliveira@academy.com'),
('Mariana Santos', 'mariana.santos@academy.com'),
('Pedro Costa', 'pedro.costa@academy.com');

INSERT INTO alunos (matricula, nome) VALUES
('20230001', 'João Pereira'),
('20230002', 'Maria Souza'),
('20230003', 'Pedro Almeida'),
('20230004', 'Ana Costa'),
('20230005', 'Carlos Rodrigues');

INSERT INTO disciplinas (nome, idProfessor) VALUES
('Programação em C', 1),
('Banco de Dados', 2),
('Matemática Discreta', 3),
('Engenharia de Software', 4),
('Redes de Computadores', 1),
('Estrutura de Dados', 2);

INSERT INTO cursos (codigo, nome, cargaHoraria, duracaoMeses) VALUES
('ADS001', 'Análise e Desenvolvimento de Sistemas', 2400, 24),
('ENG002', 'Engenharia da Computação', 3600, 60),
('ADM003', 'Administração', 3000, 48);

INSERT INTO historicosEscolares (idAluno, idDisciplina, semestre, media, faltas, situacao) VALUES
('20230001', 1, 20231, 8.50, 2, 'Aprovado'),
('20230001', 2, 20231, 7.80, 4, 'Aprovado'),
('20230001', 3, 20231, 6.20, 8, 'Recuperação'),
('20230002', 1, 20231, 9.00, 1, 'Aprovado'),
('20230002', 4, 20231, 8.70, 3, 'Aprovado'),
('20230003', 2, 20231, 5.50, 12, 'Reprovado'),
('20230003', 5, 20231, 7.00, 6, 'Aprovado'),
('20230004', 3, 20231, 4.80, 15, 'Reprovado'),
('20230004', 6, 20231, 8.90, 2, 'Aprovado'),
('20230005', 1, 20231, 6.80, 10, 'Recuperação'),
('20230005', 4, 20231, 7.50, 5, 'Aprovado');

CREATE VIEW boletim AS
SELECT
    a.matricula,
    a.nome AS nomeAluno,
    d.id AS codigoDisciplina,
    h.semestre,
    h.media,
    h.faltas AS quantidadeFaltas
    h.situacao
FROM historicosEscolares h
JOIN alunos a ON historicosEscolares.idAluno = alunos.matricula
JOIN disciplinas d ON historicosEscolares.idDisciplina = disciplinas.id;

CREATE VIEW responsavelDisc AS
SELECT
    d.nome AS nomeDisciplina
    p.nome AS nomeProfessor
FROM disciplinas d
JOIN professores p ON disciplinas.idProfessor = professores.id

CREATE VIEW profCurso AS
SELECT 
    c.id AS idCurso
    c.nome AS nomeCurso
    p.id AS idProfessor
    p.nome AS nomeProfessor
    p.email AS emailProfessor
-- acho que precisar criar uma tabela pois as tabelas professores e cursos não se relacionam

