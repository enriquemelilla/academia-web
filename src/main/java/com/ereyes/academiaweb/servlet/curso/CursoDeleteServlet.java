package com.ereyes.academiaweb.servlet.curso;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class CursoDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        JdbiConfig.getJdbi().useExtension(
                CursoDao.class,
                dao -> dao.bajaLogica(id)
        );

        response.sendRedirect(request.getContextPath() + "/cursos");
    }
}
