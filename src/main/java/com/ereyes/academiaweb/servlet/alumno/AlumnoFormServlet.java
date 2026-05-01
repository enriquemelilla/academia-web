package com.ereyes.academiaweb.servlet.alumno;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Alumno;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

public class AlumnoFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isBlank()) {
            int id = Integer.parseInt(idParam);

            Optional<Alumno> alumno = JdbiConfig.getJdbi().withExtension(
                    AlumnoDao.class,
                    dao -> dao.findById(id)
            );

            alumno.ifPresent(value -> request.setAttribute("alumno", value));
        }

        request.getRequestDispatcher("/admin/alumno-form.jsp").forward(request, response);
    }
}

