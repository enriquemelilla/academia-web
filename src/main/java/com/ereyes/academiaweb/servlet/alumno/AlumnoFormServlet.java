package com.ereyes.academiaweb.servlet.alumno;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.dao.UsuarioDao;
import com.ereyes.academiaweb.model.Alumno;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

public class AlumnoFormServlet extends HttpServlet {

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

            Optional<Alumno> alumno = JdbiConfig.getJdbi().withExtension(
                    AlumnoDao.class,
                    dao -> dao.findById(id)
            );

            alumno.ifPresent(value -> request.setAttribute("alumno", value));
        }

        Integer idUsuarioActual = null;

        Alumno alumnoActual = (Alumno) request.getAttribute("alumno");
        if (alumnoActual != null) {
            idUsuarioActual = alumnoActual.getIdUsuario();
        }

        final Integer idUsuarioActualFinal = idUsuarioActual;

        List<Usuario> usuariosUser = JdbiConfig.getJdbi().withExtension(
                UsuarioDao.class,
                dao -> dao.findUsuariosUserDisponibles(idUsuarioActualFinal)
        );

        request.setAttribute("usuariosUser", usuariosUser);

        request.getRequestDispatcher("/admin/alumno-form.jsp").forward(request, response);
    }
}

