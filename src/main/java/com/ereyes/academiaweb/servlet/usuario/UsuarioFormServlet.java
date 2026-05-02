package com.ereyes.academiaweb.servlet.usuario;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.UsuarioDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

public class UsuarioFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null || !"ADMIN".equals(usuarioSesion.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isBlank()) {
            int id = Integer.parseInt(idParam);

            Optional<Usuario> usuario = JdbiConfig.getJdbi().withExtension(
                    UsuarioDao.class,
                    dao -> dao.findById(id)
            );

            usuario.ifPresent(value -> request.setAttribute("usuarioForm", value));
        }

        request.getRequestDispatcher("/admin/usuario-form.jsp").forward(request, response);
    }
}
