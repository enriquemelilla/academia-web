package com.ereyes.academiaweb.servlet.usuario;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.UsuarioDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class UsuarioDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null || !"ADMIN".equals(usuarioSesion.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        JdbiConfig.getJdbi().useExtension(
                UsuarioDao.class,
                dao -> dao.bajaLogica(id)
        );

        response.sendRedirect(request.getContextPath() + "/usuarios");
    }
}
