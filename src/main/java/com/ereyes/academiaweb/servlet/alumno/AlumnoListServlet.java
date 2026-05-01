package com.ereyes.academiaweb.servlet.alumno;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.model.Alumno;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class AlumnoListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Alumno> alumnos = JdbiConfig.getJdbi()
                .withExtension(AlumnoDao.class, AlumnoDao::findAll);

        request.setAttribute("alumnos", alumnos);
        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
    }
}
