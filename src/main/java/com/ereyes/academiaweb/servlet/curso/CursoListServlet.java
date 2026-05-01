package com.ereyes.academiaweb.servlet.curso;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Curso;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class CursoListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Curso> cursos = JdbiConfig.getJdbi().withExtension(
                CursoDao.class,
                CursoDao::findAllActive
        );

        request.setAttribute("cursos", cursos);
        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
    }
}
