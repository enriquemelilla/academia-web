package com.ereyes.academiaweb.servlet.alumno;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.model.Alumno;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

public class AlumnoDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Optional<Alumno> alumno = JdbiConfig.getJdbi().withExtension(
                AlumnoDao.class,
                dao -> dao.findById(id)
        );

        if (alumno.isPresent()) {
            request.setAttribute("alumno", alumno.get());
            request.getRequestDispatcher("/alumno-detalle.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/alumnos");
        }
    }
}
