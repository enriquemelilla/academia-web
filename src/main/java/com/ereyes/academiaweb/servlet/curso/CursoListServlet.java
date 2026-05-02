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

        String nombre = request.getParameter("nombre");
        String estado = request.getParameter("estado");

        if (nombre == null) nombre = "";
        if (estado == null || estado.isBlank()) estado = "ACTIVOS";

        final String nombreFiltro = nombre;
        final String estadoFiltro = estado;
        final boolean activo = "ACTIVOS".equals(estadoFiltro);

        List<Curso> cursos = JdbiConfig.getJdbi().withExtension(
                CursoDao.class,
                dao -> dao.search(nombreFiltro, estadoFiltro, activo)
        );

        request.setAttribute("cursos", cursos);
        request.setAttribute("nombre", nombreFiltro);
        request.setAttribute("estado", estadoFiltro);

        request.getRequestDispatcher("/cursos.jsp").forward(request, response);
    }
}
