package com.ereyes.academiaweb.servlet.curso;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Curso;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Optional;

public class CursoFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");

        if (usuario == null || !"ADMIN".equals(usuario.getRol())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isBlank()) {
            int id = Integer.parseInt(idParam);

            Optional<Curso> curso = JdbiConfig.getJdbi().withExtension(
                    CursoDao.class,
                    dao -> dao.findById(id)
            );

            curso.ifPresent(value -> request.setAttribute("curso", value));
        }

        request.getRequestDispatcher("/admin/curso-form.jsp").forward(request, response);
    }
}
