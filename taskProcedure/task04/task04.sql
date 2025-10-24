DROP DATABASE IF EXISTS academySystem;

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

CREATE TABLE cursos(
    id INT AUTO_INCREMENT NOT NULL,
    codigo CHAR(6) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cargaHoraria INT NOT NULL,
    duracaoMeses INT NOT NULL,
    CONSTRAINT PKcursos PRIMARY KEY(id)
);

CREATE TABLE turmas(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    idProfResponsavel INT NOT NULL,
    qntd_alunos INT NOT NULL,
    CONSTRAINT PKturmas PRIMARY KEY(id),
    CONSTRAINT FKcodigoProfResponsavel FOREIGN KEY (idProfResponsavel) REFERENCES professores(id)
);

CREATE TABLE disciplinas(
    id INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    idProfessorResponsavel INT NOT NULL,
    nomeProfResponsavel VARCHAR(255) NOT NULL,
    idTurma INT NOT NULL,
    CONSTRAINT PKdisciplinas PRIMARY KEY(id),
    CONSTRAINT FKcodigoProfessor FOREIGN KEY (idProfessorResponsavel) REFERENCES professores(id),
    CONSTRAINT FKcodigoTurma FOREIGN KEY (idTurma) REFERENCES turmas(id)
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

CREATE TABLE profCursos(
    idProfessor INT NOT NULL,
    idCurso INT NOT NULL,
    CONSTRAINT PKprofCursos PRIMARY KEY (idProfessor, idCurso),
    CONSTRAINT FKcodigoProfessorPC FOREIGN KEY (idProfessor) REFERENCES professores(id),
    CONSTRAINT FKcodigoCursoPC FOREIGN KEY (idCurso) REFERENCES cursos(id)
);

-- Inserções
INSERT INTO professores (nome, email) VALUES
('Ana Silva', 'ana.silva@academy.com'),
('Carlos Oliveira', 'carlos.oliveira@academy.com'),
('Mariana Santos', 'mariana.santos@academy.com'),
('Pedro Costa', 'pedro.costa@academy.com'),
('MARCO MACHADO', 'marco.machado@academy.com');

INSERT INTO alunos (matricula, nome, cidade) VALUES
('20230001', 'João Pereira', 'São Paulo'),
('20230002', 'Maria Souza', 'Rio de Janeiro'),
('20230003', 'Pedro Almeida', 'Belo Horizonte'),
('20230004', 'Ana Costa', 'Brasília'),
('20230005', 'Carlos Rodrigues', 'Salvador'),
('20230006', 'Fernanda Lima', 'Fortaleza'),
('20230007', 'Rafael Mendes', 'Curitiba'),
('20230008', 'Luisa Nogueira', 'Recife'),
('20230009', 'Gustavo Pires', 'Porto Alegre'),
('20230010', 'Sofia Martins', 'Manaus');

INSERT INTO turmas (nome, idProfResponsavel, qntd_alunos) VALUES
('Turma ADS Manhã 2023.1', 1, 5),
('Turma ADS Noite 2023.1', 2, 12),
('Turma ENG Comp 2023.1', 3, 3),
('Turma ADM Noturno 2023.1', 4, 20);

INSERT INTO disciplinas (nome, idProfessorResponsavel, nomeProfResponsavel, idTurma) VALUES
('Programação em C', 1, 'Ana Silva', 1),
('Banco de Dados', 2, 'Carlos Oliveira', 1),
('Matemática Discreta', 3, 'Mariana Santos', 2),
('Engenharia de Software', 4, 'Pedro Costa', 2),
('Redes de Computadores', 1, 'Ana Silva', 3),
('Estrutura de Dados', 2, 'Carlos Oliveira', 3),
('Programação Java', 5, 'MARCO MACHADO', 1),
('Desenvolvimento Web', 5, 'MARCO MACHADO', 2),
('Mobile Development', 5, 'MARCO MACHADO', 3);

INSERT INTO cursos (codigo, nome, cargaHoraria, duracaoMeses) VALUES
('ADS001', 'Análise e Desenvolvimento de Sistemas', 2400, 24),
('ENG002', 'Engenharia da Computação', 3600, 60),
('ADM003', 'Administração', 3000, 48);

INSERT INTO historicosEscolares (idAluno, idDisciplina, ano, semestre, media, faltas, situacao) VALUES
('20230001', 1, 2023, 1, 8.50, 2, 'Aprovado'),
('20230001', 2, 2023, 1, 7.80, 4, 'Aprovado'),
('20230001', 3, 2023, 1, 6.20, 8, 'Recuperação'),
('20230002', 1, 2023, 1, 9.00, 1, 'Aprovado'),
('20230002', 4, 2023, 1, 8.70, 3, 'Aprovado'),
('20230003', 2, 2023, 1, 5.50, 12, 'Reprovado'),
('20230003', 5, 2023, 1, 7.00, 6, 'Aprovado'),
('20230004', 3, 2023, 1, 4.80, 15, 'Reprovado'),
('20230004', 6, 2023, 1, 8.90, 2, 'Aprovado'),
('20230005', 1, 2023, 1, 6.80, 10, 'Recuperação'),
('20230005', 4, 2023, 1, 7.50, 5, 'Aprovado'),
('20230001', 7, 2023, 1, 8.50, 2, 'Aprovado'),
('20230002', 7, 2023, 1, 9.20, 1, 'Aprovado'),
('20230003', 8, 2023, 1, 8.80, 3, 'Aprovado'),
('20230004', 8, 2023, 1, 7.50, 4, 'Aprovado'),
('20230005', 9, 2023, 1, 8.90, 2, 'Aprovado'),
('20230001', 9, 2023, 1, 6.50, 8, 'Recuperação');

INSERT INTO profCursos (idProfessor, idCurso) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(1, 3),
(5, 1);

-- Views corrigidas
CREATE VIEW boletim AS
SELECT
    a.matricula,
    a.nome AS nomeAluno,
    d.id AS codigoDisciplina,
    d.nome AS nomeDisciplina,
    h.semestre,
    h.media,
    h.faltas AS quantidadeFaltas,
    h.situacao
FROM historicosEscolares h
INNER JOIN alunos a ON h.idAluno = a.matricula
INNER JOIN disciplinas d ON h.idDisciplina = d.id;

CREATE VIEW responsavelDisc AS
SELECT
    d.nome AS nomeDisciplina,
    p.nome AS nomeProfessor
FROM disciplinas d
INNER JOIN professores p ON d.idProfessorResponsavel = p.id;

CREATE VIEW profCurso AS
SELECT 
    c.id AS idCurso,
    c.codigo AS codigoCurso,
    c.nome AS nomeCurso,
    p.id AS idProfessor,
    p.nome AS nomeProfessor,
    p.email AS emailProfessor
FROM profCursos pc
INNER JOIN professores p ON pc.idProfessor = p.id
INNER JOIN cursos c ON pc.idCurso = c.id;

CREATE VIEW alunoSituacao AS 
SELECT
    a.nome AS nomeAluno,
    d.nome AS nomeDisciplina,
    h.ano,
    h.media
FROM historicosEscolares h
INNER JOIN alunos a ON h.idAluno = a.matricula
INNER JOIN disciplinas d ON h.idDisciplina = d.id
WHERE h.faltas <= 5;

CREATE VIEW disciplina AS
SELECT
    d.id AS codigoDisciplina,
    d.nome AS nomeDisciplina,
    t.id AS codigoTurma,
    d.nomeProfResponsavel AS professorResponsavel
FROM disciplinas d
INNER JOIN turmas t ON d.idTurma = t.id
WHERE t.qntd_alunos > 8;

CREATE VIEW alunos_view AS
SELECT
    a.matricula,
    a.nome AS nomeAluno,
    a.cidade,
    COUNT(DISTINCT h.idDisciplina) AS totalDisciplinasCursadas
FROM alunos a
LEFT JOIN historicosEscolares h ON a.matricula = h.idAluno
GROUP BY a.matricula, a.nome, a.cidade
ORDER BY a.nome;

CREATE VIEW professores_view AS
SELECT
    d.nomeProfResponsavel AS profResponsavel,
    d.nome AS nomeDisciplina,
    AVG(h.media) AS mediaAlunos
FROM historicosEscolares h
INNER JOIN disciplinas d ON h.idDisciplina = d.id
GROUP BY d.nomeProfResponsavel, d.nome;

CREATE VIEW semAluno AS
SELECT 
    d.id, 
    d.nome AS disciplina, 
    p.nome AS professor, 
    t.nome AS turma
FROM disciplinas d
INNER JOIN professores p ON d.idProfessorResponsavel = p.id
INNER JOIN turmas t ON d.idTurma = t.id
WHERE d.id NOT IN (
    SELECT DISTINCT idDisciplina 
    FROM historicosEscolares 
    WHERE ano = 2015
);

CREATE VIEW Prof_Marco AS
SELECT 
    a.matricula,
    a.nome as aluno,
    d.nome as disciplina,
    h.media,
    p.nome as professor,
    (SELECT AVG(media) FROM historicosEscolares WHERE idAluno = a.matricula) as media_geral
FROM alunos a
INNER JOIN historicosEscolares h ON a.matricula = h.idAluno
INNER JOIN disciplinas d ON h.idDisciplina = d.id
INNER JOIN professores p ON d.idProfessorResponsavel = p.id
WHERE p.nome = 'MARCO MACHADO' 
AND h.media > 8
ORDER BY h.media DESC;

-- Procedures

DELIMITER $$

CREATE PROCEDURE Proc_BoletimAluno (
    IN p_busca_matricula CHAR(8)
)
BEGIN
    SELECT
        d.nome AS nome_disciplina,
        h.semestre,
        h.media,
        h.faltas,
        h.situacao AS situacao_do_aluno
        FROM historicosEscolares h
        INNER JOIN disciplinas d ON h.idDisciplina = d.id
        INNER JOIN alunos a ON h.idAluno = a.matricula
        WHERE a.matricula = p_busca_matricula;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE Proc_ProfessoresCurso (
    IN p_codigo_curso CHAR(6)
)
BEGIN
    SELECT
        idProfessor,
        nomeProfessor,
        emailProfessor
    FROM profCurso
    WHERE codigoCurso = p_codigo_curso;
END $$

DELIMITER ;

-- Mudar essa procedure (o aluno não é id, mas sim codigo eu acho)

DELIMITER $$

CREATE PROCEDURE Proc_AlunosSituacao ()
BEGIN
    SELECT 
        a.nome AS nomeAluno,
        d.nome AS disciplina,
        h.media
        FROM historicosEscolares h
        INNER JOIN alunos a ON h.idAluno = a.id
        INNER JOIN disciplinas d ON h.idDisciplina = d.id
        WHERE faltas <= 5;
END $$

DELIMITER ;