package com.ereyes.academiaweb.servlet.usuario;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.UsuarioDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;

public class UsuarioSaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null || !"ADMIN".equals(usuarioSesion.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");

        if (nombre == null || nombre.isBlank()
                || email == null || email.isBlank()
                || rol == null || rol.isBlank()) {

            request.setAttribute("error", "Nombre, email y rol son obligatorios");
            request.getRequestDispatcher("/admin/usuario-form.jsp").forward(request, response);
            return;
        }

        if (idParam == null || idParam.isBlank()) {
            if (password == null || password.isBlank()) {
                request.setAttribute("error", "La contraseña es obligatoria para crear un usuario");
                request.getRequestDispatcher("/admin/usuario-form.jsp").forward(request, response);
                return;
            }
        }

        try {
            JdbiConfig.getJdbi().useExtension(UsuarioDao.class, dao -> {
                if (idParam == null || idParam.isBlank()) {
                    dao.insert(nombre, apellidos, email, password, rol, LocalDate.now());
                } else {
                    int id = Integer.parseInt(idParam);

                    if (password != null && !password.isBlank()) {
                        dao.updateConPassword(nombre, apellidos, email, password, rol, id);
                    } else {
                        dao.updateSinPassword(nombre, apellidos, email, rol, id);
                    }
                }
            });

            response.sendRedirect(request.getContextPath() + "/usuarios");

        } catch (Exception e) {
            request.setAttribute("error", "No se pudo guardar el usuario. Revisa que el email no esté repetido.");
            request.getRequestDispatcher("/admin/usuario-form.jsp").forward(request, response);
        }
    }
}
