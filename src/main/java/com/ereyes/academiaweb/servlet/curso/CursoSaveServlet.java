package com.ereyes.academiaweb.servlet.curso;

import com.ereyes.academiaweb.config.JdbiConfig;
import com.ereyes.academiaweb.dao.CursoDao;
import com.ereyes.academiaweb.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;


@MultipartConfig
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
        String imagenActual = request.getParameter("imagenActual");
        String imagen = imagenActual;

        Part imagenPart = request.getPart("imagenFile");

        if (imagenPart != null && imagenPart.getSize() > 0) {
            String nombreOriginal = Paths.get(imagenPart.getSubmittedFileName()).getFileName().toString();

            String extension = "";
            int punto = nombreOriginal.lastIndexOf(".");
            if (punto >= 0) {
                extension = nombreOriginal.substring(punto);
            }

            String nombreArchivo = "curso_" + System.currentTimeMillis() + extension;

            String rutaUploads = getServletContext().getRealPath("/uploads/cursos");
            Files.createDirectories(Path.of(rutaUploads));

            Path rutaDestino = Path.of(rutaUploads, nombreArchivo);
            imagenPart.write(rutaDestino.toString());

            imagen = "uploads/cursos/" + nombreArchivo;
        }

        if (imagen == null || imagen.isBlank()) {
            imagen = "uploads/cursos/default-curso.png";
        }

        if (nombre == null || nombre.isBlank() || precio.compareTo(BigDecimal.ZERO) <= 0) {
            request.setAttribute("error", "El nombre es obligatorio y el precio debe ser mayor que 0");
            request.getRequestDispatcher("/admin/curso-form.jsp").forward(request, response);
            return;
        }
        final String imagenFinal = imagen;
        final String idParamFinal = idParam;


        JdbiConfig.getJdbi().useExtension(CursoDao.class, dao -> {
            if (idParam == null || idParam.isBlank()) {
                dao.insert(nombre, descripcion, horas, precio, fechaInicio, imagenFinal);
            } else {
                dao.update(nombre, descripcion, horas, precio, fechaInicio, imagenFinal, Integer.parseInt(idParamFinal));
            }
        });

        response.sendRedirect(request.getContextPath() + "/cursos");
    }
}
