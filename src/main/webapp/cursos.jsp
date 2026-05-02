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
    <link href="<%= request.getContextPath() %>/assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="includes/header.jsp"/>

<main class="container my-5">

    <%
        String mensajeCursos = (String) session.getAttribute("mensajeCursos");
        String errorCursos = (String) session.getAttribute("errorCursos");
        session.removeAttribute("mensajeCursos");
        session.removeAttribute("errorCursos");
    %>

    <% if (mensajeCursos != null) { %>
    <div class="alert alert-success"><%= mensajeCursos %></div>
    <% } %>

    <% if (errorCursos != null) { %>
    <div class="alert alert-warning"><%= errorCursos %></div>
    <% } %>



    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3">Cursos disponibles</h1>


    </div>

    <form method="get" action="<%= request.getContextPath() %>/cursos" class="card card-body shadow-sm mb-4">
        <div class="row g-3 align-items-end">
            <div class="col-md-6">
                <label class="form-label">Buscar por nombre</label>
                <input type="text" name="nombre" class="form-control"
                       value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>">
            </div>

            <div class="col-md-4">
                <label class="form-label">Estado</label>
                <select name="estado" class="form-select">
                    <option value="ACTIVOS" <%= "ACTIVOS".equals(request.getAttribute("estado")) ? "selected" : "" %>>Activos</option>
                    <option value="TODOS" <%= "TODOS".equals(request.getAttribute("estado")) ? "selected" : "" %>>Todos</option>
                </select>
            </div>

            <div class="col-md-2">
                <button type="submit" class="btn btn-primary w-100">Buscar</button>
            </div>
        </div>
    </form>
    <div class="d-flex justify-content-end align-items-center mb-4">

        <% if (admin) { %>
        <a href="admin/curso-form" class="btn btn-success">Nuevo curso</a>
        <% } %>
    </div>

    <div class="row g-4">
        <% if (cursos != null) {
            for (Curso curso : cursos) { %>

        <div class="col-md-3">
            <div class="card h-100 shadow-sm curso-card">

                <div class="curso-img-frame">
                    <img src="<%= request.getContextPath() %>/<%= curso.getImagen() != null && !curso.getImagen().isBlank() ? curso.getImagen() : "uploads/cursos/default-curso.png" %>"
                         class="curso-card-img"
                         alt="Imagen del curso">
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
                    <a href="curso-detalle?id=<%= curso.getId() %>" class="btn btn-secondary">Detalle</a>

                    <% if (!admin) { %>
                    <a href="<%= request.getContextPath() %>/matricula-create?cursoId=<%= curso.getId() %>"
                       class="btn btn-primary"
                       onclick="return confirmarMatricula()">
                        Matricularme
                    </a>
                    <% } %>

                    <% if (admin) { %>
                    <a href="admin/curso-form?id=<%= curso.getId() %>" class="btn btn-warning btn-sm">Modificar</a>
                    <a href="curso-delete?id=<%= curso.getId() %>"
                       class="btn btn-danger btn-sm"
                       onclick="return confirmarBaja('este curso')">
                        Dar de Baja
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
