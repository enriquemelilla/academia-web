<%@ page import="com.ereyes.academiaweb.model.Alumno" %>
<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Alumno alumno = (Alumno) request.getAttribute("alumno");
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean admin = usuarioSesion != null && "ADMIN".equals(usuarioSesion.getRol());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle alumno - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="includes/header.jsp"/>

<main class="container my-5">

    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h1 class="h4 mb-0">Detalle del alumno</h1>
        </div>

        <div class="card-body">

            <% if (alumno != null) { %>

            <div class="row">
                <div class="col-md-4 text-center mb-4">
                    <div class="curso-img bg-secondary text-white rounded">
                        ALU
                    </div>

                    <p class="text-muted mt-3">
                        <%= alumno.getFoto() != null ? alumno.getFoto() : "Sin fotografía asociada" %>
                    </p>
                </div>

                <div class="col-md-8">
                    <h2 class="h4">
                        <%= alumno.getNombre() %> <%= alumno.getApellidos() %>
                    </h2>

                    <ul class="list-group mb-4">
                        <li class="list-group-item">
                            <strong>DNI:</strong> <%= alumno.getDni() %>
                        </li>
                        <li class="list-group-item">
                            <strong>Email:</strong> <%= alumno.getEmail() %>
                        </li>
                        <li class="list-group-item">
                            <strong>Teléfono:</strong> <%= alumno.getTelefono() %>
                        </li>
                        <li class="list-group-item">
                            <strong>Fecha nacimiento:</strong> <%= alumno.getFechaNacimiento() %>
                        </li>
                        <li class="list-group-item">
                            <strong>Beca:</strong> <%= alumno.isBeca() ? "Sí" : "No" %>
                        </li>
                        <li class="list-group-item">
                            <strong>Activo:</strong> <%= alumno.isActivo() ? "Sí" : "No" %>
                        </li>
                    </ul>

                    <a href="alumnos" class="btn btn-secondary">Volver</a>

                    <% if (admin) { %>
                    <a href="admin/alumno-form?id=<%= alumno.getId() %>" class="btn btn-warning">
                        Modificar
                    </a>
                    <% } %>
                </div>
            </div>

            <% } else { %>

            <div class="alert alert-warning">
                No se ha encontrado el alumno solicitado.
            </div>

            <a href="alumnos" class="btn btn-secondary">Volver</a>

            <% } %>

        </div>
    </div>

</main>

<jsp:include page="includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>
