package com.ereyes.academiaweb.servlet.usuario;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.UsuarioDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class UsuarioListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null || !"ADMIN".equals(usuarioSesion.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Usuario> usuarios = JdbiConfig.getJdbi().withExtension(
                UsuarioDao.class,
                UsuarioDao::findAll
        );

        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("/usuarios.jsp").forward(request, response);
    }
}
