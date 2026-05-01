package com.ereyes.academiaweb.dao;

import com.ereyes.academiaweb.model.Curso;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.statement.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RegisterBeanMapper(Curso.class)
public interface CursoDao {

    @SqlQuery("""
            SELECT id, nombre, descripcion, horas, precio,
                   fecha_inicio AS fechaInicio, activo, imagen
            FROM cursos
            WHERE activo = TRUE
            ORDER BY fecha_inicio ASC
            """)
    List<Curso> findAllActive();

    @SqlQuery("""
            SELECT id, nombre, descripcion, horas, precio,
                   fecha_inicio AS fechaInicio, activo, imagen
            FROM cursos
            WHERE id = ?
            """)
    Optional<Curso> findById(int id);

    @SqlUpdate("""
            INSERT INTO cursos 
            (nombre, descripcion, horas, precio, fecha_inicio, activo, imagen)
            VALUES (?, ?, ?, ?, ?, TRUE, ?)
            """)
    void insert(String nombre, String descripcion, int horas, BigDecimal precio,
                LocalDate fechaInicio, String imagen);

    @SqlUpdate("""
            UPDATE cursos
            SET nombre = ?, descripcion = ?, horas = ?, precio = ?,
                fecha_inicio = ?, imagen = ?
            WHERE id = ?
            """)
    void update(String nombre, String descripcion, int horas, BigDecimal precio,
                LocalDate fechaInicio, String imagen, int id);

    @SqlUpdate("""
            UPDATE cursos
            SET activo = FALSE
            WHERE id = ?
            """)
    void bajaLogica(int id);
}
