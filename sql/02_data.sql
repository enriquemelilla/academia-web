USE academia_web;

-- USUARIO ADMIN
INSERT INTO usuarios (nombre, apellidos, email, password, rol, activo, fecha_alta)
VALUES ('Admin', 'Sistema', 'admin@academia.com', '1234', 'ADMIN', TRUE, CURDATE());

-- USUARIO NORMAL
INSERT INTO usuarios (nombre, apellidos, email, password, rol, activo, fecha_alta)
VALUES ('Usuario', 'Prueba', 'user@academia.com', '1234', 'USER', TRUE, CURDATE());

-- ALUMNOS
INSERT INTO alumnos (nombre, apellidos, dni, telefono, email, fecha_nacimiento, beca, activo, id_usuario)
VALUES
    ('Enrique', 'Reyes', '12345678A', '600111222', 'enrique@academia.com', '1995-05-10', FALSE, TRUE, 2),
    ('Ana', 'López', '87654321B', '600333444', 'ana@academia.com', '2000-02-15', TRUE, TRUE, NULL);

-- CURSOS
INSERT INTO cursos (nombre, descripcion, horas, precio, fecha_inicio, activo)
VALUES
    ('Java Básico', 'Introducción a Java', 80, 120.00, '2026-05-01', TRUE),
    ('HTML y CSS', 'Diseño web', 60, 90.00, '2026-06-01', TRUE),
    ('Bases de Datos', 'SQL y MariaDB', 100, 150.00, '2026-07-01', TRUE);

-- MATRICULAS
INSERT INTO matriculas (alumno_id, curso_id, fecha_matricula, estado, becado, activo)
VALUES
    (1, 1, CURDATE(), 'ACTIVA', FALSE, TRUE),
    (2, 2, CURDATE(), 'ACTIVA', TRUE, TRUE);