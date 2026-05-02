package com.ereyes.academiaweb.dao;

import com.ereyes.academiaweb.model.Usuario;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.statement.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RegisterBeanMapper(Usuario.class)
public interface UsuarioDao {

    @SqlQuery("""
            SELECT id, nombre, apellidos, email, password, rol,
                   activo, fecha_alta AS fechaAlta
            FROM usuarios
            WHERE email = ?
              AND password = ?
              AND activo = TRUE
            """)
    Optional<Usuario> findByEmailAndPassword(String email, String password);

    @SqlQuery("""
            SELECT id, nombre, apellidos, email, password, rol,
                   activo, fecha_alta AS fechaAlta
            FROM usuarios
            ORDER BY id DESC
            """)
    List<Usuario> findAll();

    @SqlQuery("""
            SELECT id, nombre, apellidos, email, password, rol,
                   activo, fecha_alta AS fechaAlta
            FROM usuarios
            WHERE id = ?
            """)
    Optional<Usuario> findById(int id);

    @SqlQuery("""
        SELECT id, nombre, apellidos, email, password, rol,
               activo, fecha_alta AS fechaAlta
        FROM usuarios
        WHERE email LIKE CONCAT('%', ?, '%')
          AND (? = 'TODOS' OR rol = ?)
        ORDER BY id DESC
        """)
    List<Usuario> search(String email, String rolFiltro, String rolValor);

    @SqlUpdate("""
            INSERT INTO usuarios
            (nombre, apellidos, email, password, rol, activo, fecha_alta)
            VALUES (?, ?, ?, ?, ?, TRUE, ?)
            """)
    void insert(String nombre, String apellidos, String email, String password,
                String rol, LocalDate fechaAlta);

    @SqlUpdate("""
            UPDATE usuarios
            SET nombre = ?, apellidos = ?, email = ?, rol = ?
            WHERE id = ?
            """)
    void updateSinPassword(String nombre, String apellidos, String email,
                           String rol, int id);

    @SqlUpdate("""
            UPDATE usuarios
            SET nombre = ?, apellidos = ?, email = ?, password = ?, rol = ?
            WHERE id = ?
            """)
    void updateConPassword(String nombre, String apellidos, String email,
                           String password, String rol, int id);

    @SqlUpdate("""
            UPDATE usuarios
            SET activo = FALSE
            WHERE id = ?
            """)
    void bajaLogica(int id);

    @SqlUpdate("""
            UPDATE usuarios
            SET activo = TRUE
            WHERE id = ?
            """)
    void reactivar(int id);
}
