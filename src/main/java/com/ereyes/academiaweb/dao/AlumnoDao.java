package com.ereyes.academiaweb.dao;

import com.ereyes.academiaweb.model.Alumno;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.statement.*;

import java.util.List;
import java.util.Optional;

@RegisterBeanMapper(Alumno.class)
public interface AlumnoDao {

    @SqlQuery("""
        SELECT id, nombre, apellidos, dni, telefono, email,
               fecha_nacimiento AS fechaNacimiento,
               beca, activo, foto, id_usuario AS idUsuario
        FROM alumnos
        WHERE activo = TRUE
        ORDER BY nombre
    """)
    List<Alumno> findAll();

    @SqlQuery("""
        SELECT id, nombre, apellidos, dni, telefono, email,
               fecha_nacimiento AS fechaNacimiento,
               beca, activo, foto, id_usuario AS idUsuario
        FROM alumnos
        WHERE activo = TRUE
          AND nombre LIKE CONCAT('%', ?, '%')
          AND dni LIKE CONCAT('%', ?, '%')
        ORDER BY nombre
        """)
    List<Alumno> search(String nombre, String dni);

    @SqlQuery("""
        SELECT id, nombre, apellidos, dni, telefono, email,
               fecha_nacimiento AS fechaNacimiento,
               beca, activo, foto, id_usuario AS idUsuario
        FROM alumnos
        WHERE id = ?
    """)
    Optional<Alumno> findById(int id);

    @SqlUpdate("""
        INSERT INTO alumnos
        (nombre, apellidos, dni, telefono, email, fecha_nacimiento, beca, activo)
        VALUES (?, ?, ?, ?, ?, ?, ?, TRUE)
    """)
    void insert(String nombre, String apellidos, String dni, String telefono,
                String email, String fechaNacimiento, boolean beca);

    @SqlUpdate("""
        UPDATE alumnos
        SET nombre=?, apellidos=?, dni=?, telefono=?, email=?, 
            fecha_nacimiento=?, beca=?
        WHERE id=?
    """)
    void update(String nombre, String apellidos, String dni, String telefono,
                String email, String fechaNacimiento, boolean beca, int id);

    @SqlUpdate("UPDATE alumnos SET activo = FALSE WHERE id = ?")
    void delete(int id);
}
