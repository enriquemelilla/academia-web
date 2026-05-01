package com.ereyes.academiaweb.dao;

import com.ereyes.academiaweb.model.Matricula;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.statement.*;

import java.util.List;

@RegisterBeanMapper(Matricula.class)
public interface MatriculaDao {

    // ✔ Ver matrículas de un alumno (MIS MATRÍCULAS)
    @SqlQuery("""
        SELECT m.id,
               m.alumno_id AS alumnoId,
               m.curso_id AS cursoId,
               m.fecha_matricula AS fechaMatricula,
               m.estado,
               m.becado,
               m.activo,
               c.nombre AS nombreCurso
        FROM matriculas m
        JOIN cursos c ON m.curso_id = c.id
        WHERE m.alumno_id = ?
          AND m.activo = TRUE
        ORDER BY m.fecha_matricula DESC
    """)
    List<Matricula> findByAlumno(int alumnoId);


    // ✔ Crear matrícula
    @SqlUpdate("""
        INSERT INTO matriculas
        (alumno_id, curso_id, fecha_matricula, estado, becado, activo)
        VALUES (?, ?, CURRENT_DATE, 'ACTIVA', FALSE, TRUE)
    """)
    void insert(int alumnoId, int cursoId);


    // ✔ Evitar duplicados
    @SqlQuery("""
        SELECT COUNT(*) 
        FROM matriculas
        WHERE alumno_id = ?
          AND curso_id = ?
          AND activo = TRUE
    """)
    int exists(int alumnoId, int cursoId);


    // ✔ Baja lógica
    @SqlUpdate("""
        UPDATE matriculas
        SET activo = FALSE,
            estado = 'BAJA'
        WHERE id = ?
    """)
    void delete(int id);
}
