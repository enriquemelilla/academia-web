package com.ereyes.academiaweb.servlet.usuario;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.dao.UsuarioDao;
import com.ereyes.academiaweb.model.Alumno;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

public class MiPerfilSaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null || !"USER".equals(usuarioSesion.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String telefono = request.getParameter("telefono");
        String emailAlumno = request.getParameter("emailAlumno");
        String foto = request.getParameter("foto");
        String nuevaPassword = request.getParameter("nuevaPassword");

        Optional<Alumno> alumno = JdbiConfig.getJdbi().withExtension(
                AlumnoDao.class,
                dao -> dao.findByUsuarioId(usuarioSesion.getId())
        );

        if (alumno.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/mi-perfil");
            return;
        }

        Alumno alumnoActual = alumno.get();

        try {
            JdbiConfig.getJdbi().useExtension(AlumnoDao.class, dao ->
                    dao.updatePerfilUsuario(telefono, emailAlumno, foto, alumnoActual.getId())
            );

            if (nuevaPassword != null && !nuevaPassword.isBlank()) {
                JdbiConfig.getJdbi().useExtension(UsuarioDao.class, dao ->
                        dao.updatePassword(nuevaPassword, usuarioSesion.getId())
                );

                usuarioSesion.setPassword(nuevaPassword);
                request.getSession().setAttribute("usuario", usuarioSesion);
            }

            request.getSession().setAttribute("mensajePerfil", "Perfil actualizado correctamente");

        } catch (Exception e) {
            request.getSession().setAttribute("errorPerfil", "No se pudo actualizar el perfil");
        }

        response.sendRedirect(request.getContextPath() + "/mi-perfil");
    }
}
