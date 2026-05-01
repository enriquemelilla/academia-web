<%@ page import="com.ereyes.academiaweb.model.Curso" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Curso curso = (Curso) request.getAttribute("curso");
    boolean editando = curso != null;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= editando ? "Modificar curso" : "Nuevo curso" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../includes/header.jsp"/>

<main class="container my-5">

    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h1 class="h4 mb-0"><%= editando ? "Modificar curso" : "Nuevo curso" %></h1>
        </div>

        <div class="card-body">

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="../curso-save" method="post">

                <% if (editando) { %>
                <input type="hidden" name="id" value="<%= curso.getId() %>">
                <% } %>

                <div class="mb-3">
                    <label class="form-label">Nombre *</label>
                    <input type="text" name="nombre" class="form-control" required
                           value="<%= editando ? curso.getNombre() : "" %>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Descripción</label>
                    <textarea name="descripcion" class="form-control" rows="4"><%= editando ? curso.getDescripcion() : "" %></textarea>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Horas</label>
                        <input type="number" name="horas" class="form-control" min="1" required
                               value="<%= editando ? curso.getHoras() : "" %>">
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Precio *</label>
                        <input type="number" name="precio" class="form-control" step="0.01" min="0.01" required
                               value="<%= editando ? curso.getPrecio() : "" %>">
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Fecha inicio</label>
                        <input type="date" name="fechaInicio" class="form-control" required
                               value="<%= editando ? curso.getFechaInicio() : "" %>">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Imagen</label>
                    <input type="text" name="imagen" class="form-control"
                           placeholder="nombre-imagen.jpg"
                           value="<%= editando && curso.getImagen() != null ? curso.getImagen() : "" %>">
                </div>

                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="../cursos" class="btn btn-secondary">Cancelar</a>

            </form>
        </div>
    </div>

</main>

<jsp:include page="../includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
