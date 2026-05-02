<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Usuario usuarioForm = (Usuario) request.getAttribute("usuarioForm");
    boolean editando = usuarioForm != null;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= editando ? "Modificar usuario" : "Nuevo usuario" %> - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/header.jsp"/>

<main class="container my-5">

    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h1 class="h4 mb-0"><%= editando ? "Modificar usuario" : "Nuevo usuario" %></h1>
        </div>

        <div class="card-body">

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/usuario-save" method="post">

                <% if (editando) { %>
                <input type="hidden" name="id" value="<%= usuarioForm.getId() %>">
                <% } %>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nombre *</label>
                        <input type="text" name="nombre" class="form-control" required
                               value="<%= editando ? usuarioForm.getNombre() : "" %>">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Apellidos</label>
                        <input type="text" name="apellidos" class="form-control"
                               value="<%= editando ? usuarioForm.getApellidos() : "" %>">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email *</label>
                    <input type="email" name="email" class="form-control" required
                           value="<%= editando ? usuarioForm.getEmail() : "" %>">
                </div>

                <div class="mb-3">
                    <label class="form-label">
                        Contraseña <%= editando ? "(dejar en blanco para no cambiar)" : "*" %>
                    </label>
                    <input type="password" name="password" class="form-control" <%= editando ? "" : "required" %>>
                </div>

                <div class="mb-4">
                    <label class="form-label">Rol *</label>
                    <select name="rol" class="form-select" required>
                        <option value="USER" <%= editando && "USER".equals(usuarioForm.getRol()) ? "selected" : "" %>>
                            USER
                        </option>
                        <option value="ADMIN" <%= editando && "ADMIN".equals(usuarioForm.getRol()) ? "selected" : "" %>>
                            ADMIN
                        </option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="<%= request.getContextPath() %>/usuarios" class="btn btn-secondary">Cancelar</a>

            </form>

        </div>
    </div>

</main>

<jsp:include page="/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/main.js"></script>

</body>
</html>
