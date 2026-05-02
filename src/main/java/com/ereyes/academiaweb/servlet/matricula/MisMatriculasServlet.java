package com.ereyes.academiaweb.servlet.matricula;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.MatriculaDao;
import com.ereyes.academiaweb.model.Matricula;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.model.Alumno;
import java.util.Optional;

import java.io.IOException;
import java.util.List;

public class MisMatriculasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        if (usuario == null || !"USER".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        /*
         Temporalmente usamos alumnoId = 1 para el usuario de prueba.
         Más adelante, en zona privada, lo resolveremos desde la relación alumno.id_usuario.
        */
        Optional<Alumno> alumno = JdbiConfig.getJdbi().withExtension(
                AlumnoDao.class,
                dao -> dao.findByUsuarioId(usuario.getId())
        );

        if (alumno.isEmpty()) {
            request.setAttribute("matriculas", List.of());
            request.getRequestDispatcher("/mis-matriculas.jsp").forward(request, response);
            return;
        }

        int alumnoId = alumno.get().getId();

        List<Matricula> matriculas = JdbiConfig.getJdbi().withExtension(
                MatriculaDao.class,
                dao -> dao.findByAlumno(alumnoId)
        );

        request.setAttribute("matriculas", matriculas);
        request.getRequestDispatcher("/mis-matriculas.jsp").forward(request, response);
    }
}
