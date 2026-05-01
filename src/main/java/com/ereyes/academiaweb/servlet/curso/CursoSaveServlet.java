package com.ereyes.academiaweb.servlet.curso;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;

public class CursoSaveServlet extends HttpServlet {

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
        String descripcion = request.getParameter("descripcion");
        int horas = Integer.parseInt(request.getParameter("horas"));
        BigDecimal precio = new BigDecimal(request.getParameter("precio"));
        LocalDate fechaInicio = LocalDate.parse(request.getParameter("fechaInicio"));
        String imagen = request.getParameter("imagen");

        if (nombre == null || nombre.isBlank() || precio.compareTo(BigDecimal.ZERO) <= 0) {
            request.setAttribute("error", "El nombre es obligatorio y el precio debe ser mayor que 0");
            request.getRequestDispatcher("/admin/curso-form.jsp").forward(request, response);
            return;
        }

        JdbiConfig.getJdbi().useExtension(CursoDao.class, dao -> {
            if (idParam == null || idParam.isBlank()) {
                dao.insert(nombre, descripcion, horas, precio, fechaInicio, imagen);
            } else {
                dao.update(nombre, descripcion, horas, precio, fechaInicio, imagen, Integer.parseInt(idParam));
            }
        });

        response.sendRedirect(request.getContextPath() + "/cursos");
    }
}
