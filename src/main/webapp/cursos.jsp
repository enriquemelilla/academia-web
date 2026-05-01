<%@ page import="java.util.List" %>
<%@ page import="com.ereyes.academiaweb.model.Curso" %>
<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Curso> cursos = (List<Curso>) request.getAttribute("cursos");
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean admin = usuarioSesion != null && "ADMIN".equals(usuarioSesion.getRol());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cursos - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="includes/header.jsp"/>

<main class="container my-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3">Cursos disponibles</h1>

        <% if (admin) { %>
        <a href="admin/curso-form" class="btn btn-success">Nuevo curso</a>
        <% } %>
    </div>

    <div class="row g-4">
        <% if (cursos != null) {
            for (Curso curso : cursos) { %>

        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="curso-img bg-primary text-white">
                    <%= curso.getNombre().substring(0, Math.min(3, curso.getNombre().length())).toUpperCase() %>
                </div>

                <div class="card-body">
                    <h5 class="card-title"><%= curso.getNombre() %></h5>
                    <p class="card-text"><%= curso.getDescripcion() %></p>

                    <ul class="list-unstyled small text-muted">
                        <li>Horas: <%= curso.getHoras() %></li>
                        <li>Precio: <%= curso.getPrecio() %> €</li>
                        <li>Fecha inicio: <%= curso.getFechaInicio() %></li>
                    </ul>
                </div>

                <div class="card-footer bg-white border-0 d-flex flex-wrap gap-2">
                    <a href="curso-detalle?id=<%= curso.getId() %>" class="btn btn-outline-primary btn-sm">Ver detalle</a>

                    <% if (!admin) { %>
                    <a href="#" class="btn btn-primary btn-sm">Matricularme</a>
                    <% } %>

                    <% if (admin) { %>
                    <a href="admin/curso-form?id=<%= curso.getId() %>" class="btn btn-warning btn-sm">Modificar</a>
                    <a href="curso-delete?id=<%= curso.getId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirm('¿Seguro que deseas dar de baja este curso?')">
                        Dar de baja
                    </a>
                    <% } %>
                </div>
            </div>
        </div>

        <%  }
        } %>
    </div>

</main>

<jsp:include page="includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/main.js"></script>
</body>
</html>
