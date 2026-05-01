package com.ereyes.academiaweb.servlet.matricula;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.MatriculaDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

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
        int alumnoId = 1;

        try {
            JdbiConfig.getJdbi().useExtension(MatriculaDao.class, dao -> {
                if (dao.exists(alumnoId, cursoId) == 0) {
                    dao.insert(alumnoId, cursoId);
                }
            });

            response.sendRedirect(request.getContextPath() + "/mis-matriculas");

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/cursos");
        }
    }
}
