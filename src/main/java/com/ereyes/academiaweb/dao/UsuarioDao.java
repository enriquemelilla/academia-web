package com.ereyes.academiaweb.dao;

import com.ereyes.academiaweb.model.Usuario;
import org.jdbi.v3.sqlobject.config.RegisterBeanMapper;
import org.jdbi.v3.sqlobject.statement.SqlQuery;

import java.util.Optional;

@RegisterBeanMapper(Usuario.class)
public interface UsuarioDao {

    @SqlQuery("""
            SELECT 
                id,
                nombre,
                apellidos,
                email,
                password,
                rol,
                activo,
                fecha_alta AS fechaAlta
            FROM usuarios
            WHERE email = ?
              AND password = ?
              AND activo = TRUE
            """)
    Optional<Usuario> findByEmailAndPassword(String email, String password);
}
