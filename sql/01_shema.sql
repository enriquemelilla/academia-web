CREATE DATABASE IF NOT EXISTS academia_web
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'academia_user'@'localhost'
IDENTIFIED BY 'academia1234';

GRANT ALL PRIVILEGES ON academia_web.*
TO 'academia_user'@'localhost';

FLUSH PRIVILEGES;

USE academia_web;

-- TABLA USUARIOS
CREATE TABLE usuarios (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          nombre VARCHAR(100) NOT NULL,
                          apellidos VARCHAR(150),
                          email VARCHAR(150) NOT NULL UNIQUE,
                          password VARCHAR(255) NOT NULL,
                          rol ENUM('ADMIN','USER') NOT NULL,
                          activo BOOLEAN DEFAULT TRUE,
                          fecha_alta DATE
);

-- TABLA ALUMNOS
CREATE TABLE alumnos (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         nombre VARCHAR(100) NOT NULL,
                         apellidos VARCHAR(150) NOT NULL,
                         dni VARCHAR(20) NOT NULL UNIQUE,
                         telefono VARCHAR(20),
                         email VARCHAR(150),
                         fecha_nacimiento DATE,
                         beca BOOLEAN DEFAULT FALSE,
                         activo BOOLEAN DEFAULT TRUE,
                         foto VARCHAR(255),
                         id_usuario INT NULL,

                         FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);
-- TABLA CURSOS
CREATE TABLE cursos (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        nombre VARCHAR(150) NOT NULL,
                        descripcion TEXT,
                        horas INT,
                        precio DECIMAL(8,2),
                        fecha_inicio DATE,
                        activo BOOLEAN DEFAULT TRUE,
                        imagen VARCHAR(255)
);

-- TABLA MATRICULAS
CREATE TABLE matriculas (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            alumno_id INT NOT NULL,
                            curso_id INT NOT NULL,
                            fecha_matricula DATE NOT NULL,
                            estado ENUM('ACTIVA','FINALIZADA','BAJA') DEFAULT 'ACTIVA',
                            becado BOOLEAN DEFAULT FALSE,
                            activo BOOLEAN DEFAULT TRUE,

                            FOREIGN KEY (alumno_id) REFERENCES alumnos(id),
                            FOREIGN KEY (curso_id) REFERENCES cursos(id),

                            UNIQUE (alumno_id, curso_id)
);