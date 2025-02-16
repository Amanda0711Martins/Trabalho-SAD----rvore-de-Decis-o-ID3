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
