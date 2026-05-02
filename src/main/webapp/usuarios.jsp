<%@ page import="java.util.List" %>
<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Usuarios - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/header.jsp"/>

<main class="container my-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3">Gestión de usuarios</h1>
        <a href="<%= request.getContextPath() %>/admin/usuario-form" class="btn btn-success">Nuevo usuario</a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                <tr>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Email</th>
                    <th>Rol</th>
                    <th>Estado</th>
                    <th>Fecha alta</th>
                    <th>Acciones</th>
                </tr>
                </thead>

                <tbody>
                <% if (usuarios != null && !usuarios.isEmpty()) {
                    for (Usuario usuario : usuarios) { %>

                <tr>
                    <td><%= usuario.getNombre() %></td>
                    <td><%= usuario.getApellidos() %></td>
                    <td><%= usuario.getEmail() %></td>
                    <td>
                        <% if ("ADMIN".equals(usuario.getRol())) { %>
                        <span class="badge bg-danger">ADMIN</span>
                        <% } else { %>
                        <span class="badge bg-primary">USER</span>
                        <% } %>
                    </td>
                    <td>
                        <% if (usuario.isActivo()) { %>
                        <span class="badge bg-success">Activo</span>
                        <% } else { %>
                        <span class="badge bg-secondary">Baja</span>
                        <% } %>
                    </td>
                    <td><%= usuario.getFechaAlta() %></td>
                    <td>
                        <a href="<%= request.getContextPath() %>/admin/usuario-form?id=<%= usuario.getId() %>"
                           class="btn btn-warning btn-sm">
                            Modificar
                        </a>

                        <% if (usuario.isActivo()) { %>
                        <a href="<%= request.getContextPath() %>/usuario-delete?id=<%= usuario.getId() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('¿Seguro que deseas dar de baja este usuario?')">
                            Dar de baja
                        </a>
                        <% } else { %>
                        <a href="<%= request.getContextPath() %>/usuario-reactivate?id=<%= usuario.getId() %>"
                           class="btn btn-success btn-sm"
                           onclick="return confirm('¿Seguro que deseas reactivar este usuario?')">
                            Reactivar
                        </a>
                        <% } %>
                    </td>
                </tr>

                <%  }
                } else { %>

                <tr>
                    <td colspan="7" class="text-center text-muted">
                        No hay usuarios registrados.
                    </td>
                </tr>

                <% } %>
                </tbody>
            </table>

        </div>
    </div>

</main>

<jsp:include page="/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/main.js"></script>

</body>
</html>
