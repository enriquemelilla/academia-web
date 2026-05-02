package com.ereyes.academiaweb.servlet;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Curso;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.jdbi.v3.core.Jdbi;

import java.io.IOException;
import java.util.List;


//public class TestConnectionServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        response.setContentType("text/html;charset=UTF-8");
//        response.getWriter().println("<h1>Servlet funcionando correctamente</h1>");
//    }
//}


public class TestConnectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try {
            Jdbi jdbi = JdbiConfig.getJdbi();

            List<Curso> cursos = jdbi.withExtension(
                    CursoDao.class,
                    CursoDao::findAllActive
            );

            response.getWriter().println("<h1>Conexión correcta con MariaDB</h1>");
            response.getWriter().println("<h2>Cursos encontrados:</h2>");
            response.getWriter().println("<ul>");

            for (Curso curso : cursos) {
                response.getWriter().println(
                        "<li>" + curso.getNombre() + " - " + curso.getPrecio() + " €</li>"
                );
            }

            response.getWriter().println("</ul>");

        } catch (Exception e) {
            response.getWriter().println("<h1>Error de conexión con MariaDB</h1>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
        }
    }
}