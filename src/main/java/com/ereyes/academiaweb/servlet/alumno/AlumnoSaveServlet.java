package com.ereyes.academiaweb.servlet.alumno;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class AlumnoSaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        boolean beca = request.getParameter("beca") != null;

        if (nombre == null || nombre.isBlank() || dni == null || dni.isBlank()) {
            request.setAttribute("error", "El nombre y el DNI son obligatorios");
            request.getRequestDispatcher("/admin/alumno-form.jsp").forward(request, response);
            return;
        }

        try {
            JdbiConfig.getJdbi().useExtension(AlumnoDao.class, dao -> {
                if (idParam == null || idParam.isBlank()) {
                    dao.insert(nombre, apellidos, dni, telefono, email, fechaNacimiento, beca);
                } else {
                    dao.update(nombre, apellidos, dni, telefono, email, fechaNacimiento, beca, Integer.parseInt(idParam));
                }
            });

            response.sendRedirect(request.getContextPath() + "/alumnos");

        } catch (Exception e) {
            request.setAttribute("error", "No se pudo guardar el alumno. Revisa que el DNI no esté repetido.");
            request.getRequestDispatcher("/admin/alumno-form.jsp").forward(request, response);
        }
    }
}
