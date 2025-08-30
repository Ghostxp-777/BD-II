CREATE DATABASE academySystem;

USE academySystem;

CREATE TABLE alunos(
    matricula CHAR(8) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
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
    idTurma INT NOT NULL,
    CONSTRAINT PKdisciplinas PRIMARY KEY(id),
    CONSTRAINT FKcodigoProfessor FOREIGN KEY (idProfessor) REFERENCES professores(id),
    CONSTRAINT FKcodigoTurma FOREIGN KEY (idTurma) REFERENCES turmas(id),
);

CREATE TABLE historicosEscolares(
    id INT AUTO_INCREMENT NOT NULL,
    idAluno CHAR(8) NOT NULL,
    idDisciplina INT NOT NULL,
    ano INT NOT NULL,
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

CREATE TABLE profCursos(
    idProfessor INT NOT NULL,
    idCurso INT NOT NULL,
    CONSTRAINT PKprofCursos PRIMARY KEY (idProfessor, idCurso),
    CONSTRAINT FKcodigoProfessor FOREIGN KEY (idProfessor) REFERENCES professores(id),
    CONSTRAINT FKcodigoCurso FOREIGN KEY (idCursos) REFERENCES cursos(id)
);

CREATE TABLE turmas(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    idProfResponsavel INT NOT NULL,
    CONSTRAINT PKturmas PRIMARY KEY(id),
    CONSTRAINT FKcodigoProfResponsavel FOREIGN KEY (idProfResponsavel) REFERENCES professores(id)
);

-- Talvez eu exclua
CREATE TABLE alunosTurmas(
    idAluno CHAR(8) NOT NULL,
    idTurma INT NOT NULL,
    CONSTRAINT PKalunosTurmas PRIMARY KEY (idAluno, idTurma),
    CONSTRAINT FKcodigoAluno FOREIGN KEY (idAluno) REFERENCES alunos(matricula),
    CONSTRAINT FKcodigoTurma FOREIGN KEY (idTurma) REFERENCES turmas(id)
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
('20230005', 'Carlos Rodrigues'),
('20230006', 'Fernanda Lima'),
('20230007', 'Rafael Mendes'),
('20230008', 'Luisa Nogueira'),
('20230009', 'Gustavo Pires'),
('20230010', 'Sofia Martins');

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

INSERT INTO profCursos (idProfessor, idCurso) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(1, 3);

INSERT INTO turmas (nome) VALUES
('Turma ADS Manhã 2023.1'),
('Turma ADS Noite 2023.1'),
('Turma ENG Comp 2023.1'),
('Turma ADM Noturno 2023.1');

INSERT INTO alunosTurmas (idAluno, idTurma) VALUES
('20230001', 1),
('20230002', 1),
('20230003', 2),
('20230004', 3),
('20230005', 1),
('20230001', 4),
('20230006', 1),
('20230007', 2),
('20230008', 3),
('20230009', 1),
('20230010', 4),
('20230006', 2);

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
INNER JOIN alunos a ON historicosEscolares.idAluno = alunos.matricula
INNER JOIN disciplinas d ON historicosEscolares.idDisciplina = disciplinas.id;

CREATE VIEW responsavelDisc AS
SELECT
    d.nome AS nomeDisciplina
    p.nome AS nomeProfessor
FROM disciplinas d
INNER JOIN professores p ON disciplinas.idProfessor = professores.id

CREATE VIEW profCurso AS
SELECT 
    c.id AS idCurso
    c.nome AS nomeCurso
    p.id AS idProfessor
    p.nome AS nomeProfessor
    p.email AS emailProfessor
FROM profCurso
INNER JOIN professores p ON profCurso.idProfessor = professores.id
INNER JOIN disciplinas d ON profCurso.idCurso = cursos.id

CREATE VIEW alunoSituacao AS 
SELECT
    a.nome AS nomeAluno
    d.nome AS nomeDisciplina
    h.ano
    h.media
FROM historicosEscolares
INNER JOIN alunos a ON historicosEscolares.idAluno = alunos.id
INNER JOIN disciplinas d ON historicosEscolares.idDisciplina = disciplinas.id
WHERE faltas <= 5;

-- Eu acho que está certo...
CREATE VIEW disciplina AS
SELECT
    d.id AS codigoDisciplina
    d.nome AS nomeDisciplina
    t.id AS codigoTurma
    d.idProfessor AS professorResponsavel
FROM disciplinas
INNER JOIN turmas AS t ON disciplinas.idTurma = turmas.id

-- Também desconfio desse
CREATE VIEW alunos AS
SELECT
    a.matricula
    a.nome AS nomeAluno
    a.cidade
    COUNT(DISTINCT he.idDisciplina) AS totalDisciplinasCursadas
FROM alunos AS a
LEFT JOIN historicosEscolares h ON a.matricula = h.idAluno
GROUP BY a.matricula, a.nome, a.cidade
ORDER BY a.nome;




