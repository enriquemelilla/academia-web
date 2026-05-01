package com.ereyes.academiaweb.dao;

import com.ereyes.academiaweb.model.Curso;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;

import java.util.List;

@RegisterBeanMapper(Curso.class)
public interface CursoDao {

    @SqlQuery("""
            SELECT 
                id,
                nombre,
                descripcion,
                horas,
                precio,
                fecha_inicio AS fechaInicio,
                activo,
                imagen
            FROM cursos
            ORDER BY fecha_inicio ASC
            """)
    List<Curso> findAll();
}
