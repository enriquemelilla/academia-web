package com.ereyes.academiaweb.servlet.curso;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Curso;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

public class CursoDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Optional<Curso> curso = JdbiConfig.getJdbi().withExtension(
                CursoDao.class,
                dao -> dao.findById(id)
        );

        if (curso.isPresent()) {
            request.setAttribute("curso", curso.get());
            request.getRequestDispatcher("/curso-detalle.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/cursos");
        }
    }
}
