package com.ereyes.academiaweb.servlet.matricula;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.MatriculaDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.model.Alumno;
import java.util.Optional;

import java.io.IOException;

public class MatriculaCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        if (usuario == null || !"USER".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int cursoId = Integer.parseInt(request.getParameter("cursoId"));

        /*
         IMPORTANTE:
         De momento usamos el id del alumno asociado al usuario normal de prueba.
         En nuestro script inicial:
         usuario USER tiene id = 2
         alumno Enrique tiene id = 1 y está vinculado a id_usuario = 2
        */
        Optional<Alumno> alumno = JdbiConfig.getJdbi().withExtension(
                AlumnoDao.class,
                dao -> dao.findByUsuarioId(usuario.getId())
        );

        if (alumno.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cursos");
            return;
        }

        int alumnoId = alumno.get().getId();

        try {
            final boolean[] yaMatriculado = {false};

            JdbiConfig.getJdbi().useExtension(MatriculaDao.class, dao -> {
                if (dao.exists(alumnoId, cursoId) == 0) {
                    dao.insert(alumnoId, cursoId);
                } else {
                    yaMatriculado[0] = true;
                }
            });

            if (yaMatriculado[0]) {
                request.getSession().setAttribute("errorCursos", "Ya estabas matriculado en este curso.");
            } else {
                request.getSession().setAttribute("mensajeCursos", "Matrícula realizada correctamente.");
            }

            response.sendRedirect(request.getContextPath() + "/cursos");

        } catch (Exception e) {
            request.getSession().setAttribute("errorCursos", "No se pudo realizar la matrícula.");
            response.sendRedirect(request.getContextPath() + "/cursos");
        }
    }
}
