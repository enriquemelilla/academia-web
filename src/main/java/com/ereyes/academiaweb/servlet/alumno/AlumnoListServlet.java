package com.ereyes.academiaweb.servlet.alumno;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.AlumnoDao;
import com.ereyes.academiaweb.model.Alumno;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class AlumnoListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuarioSesion = (Usuario) request.getSession().getAttribute("usuario");

        if (usuarioSesion == null || !"ADMIN".equals(usuarioSesion.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String nombre = request.getParameter("nombre");
        String dni = request.getParameter("dni");

        if (nombre == null) nombre = "";
        if (dni == null) dni = "";

        final String nombreFiltro = nombre;
        final String dniFiltro = dni;

        List<Alumno> alumnos = JdbiConfig.getJdbi().withExtension(
                AlumnoDao.class,
                dao -> dao.search(nombreFiltro, dniFiltro)
        );

        request.setAttribute("alumnos", alumnos);
        request.setAttribute("nombre", nombreFiltro);
        request.setAttribute("dni", dniFiltro);

        request.getRequestDispatcher("/alumnos.jsp").forward(request, response);
    }
}
