package com.ereyes.academiaweb.servlet.usuario;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.model.Alumno;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

public class MiPerfilServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null || !"USER".equals(usuarioSesion.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Optional<Alumno> alumno = JdbiConfig.getJdbi().withExtension(
                AlumnoDao.class,
                dao -> dao.findByUsuarioId(usuarioSesion.getId())
        );

        alumno.ifPresent(value -> request.setAttribute("alumno", value));
        request.setAttribute("usuario", usuarioSesion);

        request.getRequestDispatcher("/mi-perfil.jsp").forward(request, response);
    }
}
