<%@ page import="com.ereyes.academiaweb.model.Curso" %>
<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Curso curso = (Curso) request.getAttribute("curso");
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean admin = usuarioSesion != null && "ADMIN".equals(usuarioSesion.getRol());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Detalle curso</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="includes/header.jsp"/>

<main class="container my-5">

    <div class="card shadow-sm">
        <div class="curso-img bg-primary text-white">
            <%= curso.getNombre() %>
        </div>

        <div class="card-body">
            <h1 class="h3"><%= curso.getNombre() %></h1>

            <p><%= curso.getDescripcion() %></p>

            <ul class="list-group mb-4">
                <li class="list-group-item">Horas: <%= curso.getHoras() %></li>
                <li class="list-group-item">Precio: <%= curso.getPrecio() %> €</li>
                <li class="list-group-item">Fecha inicio: <%= curso.getFechaInicio() %></li>
                <li class="list-group-item">Activo: <%= curso.isActivo() ? "Sí" : "No" %></li>
            </ul>

            <a href="cursos" class="btn btn-secondary">Volver</a>

            <% if (admin) { %>
            <a href="admin/curso-form?id=<%= curso.getId() %>" class="btn btn-warning">Modificar</a>
            <% } else { %>
            <a href="#" class="btn btn-primary">Matricularme</a>
            <% } %>
        </div>
    </div>

</main>

<jsp:include page="includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
