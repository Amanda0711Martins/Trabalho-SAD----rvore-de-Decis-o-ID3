CREATE DATABASE medical_diagnosis;
USE medical_diagnosis;

CREATE TABLE symptoms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE diseases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE training_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    symptom_id INT,
    disease_id INT,
    intensity ENUM('Irrelevante', 'Médio', 'Forte'),
    FOREIGN KEY (symptom_id) REFERENCES symptoms(id),
    FOREIGN KEY (disease_id) REFERENCES diseases(id)
);

INSERT INTO symptoms (name) VALUES
('Dores de cabeça'),
('Dores no peito'),
('Dores nos olhos'),
('Nariz escorrendo'),
('Dores no estômago'),
('Tosse'),
('Espirros'),
('Dor de garganta'),
('Palpitações'),
('Soluços'),
('Diarreia'),
('Náusea'),
('Dormência'),
('Insônia'),
('Desmaio'),
('Perda de olfato');

-- Inserindo doenças fictícias
INSERT INTO diseases (name) VALUES
('Ansiedade'),
('Cardiopatia'),
('Covid 19'),
('Meningite');

-- Associando sintomas a doenças com diferentes intensidades
INSERT INTO training_data (symptom_id, disease_id, intensity) VALUES
-- Ansiedade
(1, 1, 'Forte'),  -- Dores de cabeça
(2, 1, 'Médio'),  -- Dores no peito
(3, 1, 'Irrelevante'),  -- Dores nos olhos
(4, 1, 'Médio'),  -- Nariz escorrendo
(5, 1, 'Forte'),  -- Dores no estômago
(6, 1, 'Médio'),  -- Tosse
(7, 1, 'Irrelevante'),  -- Espirros
(8, 1, 'Médio'),  -- Dor de garganta

-- Cardiopatia 
(1, 2, 'Médio'),
(2, 2, 'Forte'),
(3, 2, 'Médio'),
(4, 2, 'Irrelevante'),
(5, 2, 'Forte'),
(6, 2, 'Forte'),
(7, 2, 'Médio'),
(8, 2, 'Irrelevante'),

-- Covid 19
(1, 3, 'Irrelevante'),
(2, 3, 'Médio'),
(3, 3, 'Forte'),
(4, 3, 'Médio'),
(5, 3, 'Irrelevante'),
(6, 3, 'Médio'),
(7, 3, 'Forte'),
(8, 3, 'Forte'),

-- Meningite
(1, 4, 'Forte'),
(2, 4, 'Irrelevante'),
(3, 4, 'Médio'),
(4, 4, 'Forte'),
(5, 4, 'Médio'),
(6, 4, 'Irrelevante'),
(7, 4, 'Forte'),
(8, 4, 'Médio');
