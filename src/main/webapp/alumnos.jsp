<%@ page import="java.util.List" %>
<%@ page import="com.ereyes.academiaweb.model.Alumno" %>
<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Alumno> alumnos = (List<Alumno>) request.getAttribute("alumnos");
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean admin = usuarioSesion != null && "ADMIN".equals(usuarioSesion.getRol());
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Alumnos - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="includes/header.jsp"/>

<main class="container my-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3">Gestión de alumnos</h1>

        <% if (admin) { %>
        <a href="<%= request.getContextPath() %>/admin/alumno-form" class="btn btn-success">
            Nuevo alumno
        </a>
        <% } %>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                <tr>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>DNI</th>
                    <th>Email</th>
                    <th>Teléfono</th>
                    <th>Beca</th>
                    <th>Acciones</th>
                </tr>
                </thead>

                <tbody>
                <% if (alumnos != null && !alumnos.isEmpty()) {
                    for (Alumno alumno : alumnos) { %>

                <tr>
                    <td><%= alumno.getNombre() %></td>
                    <td><%= alumno.getApellidos() %></td>
                    <td><%= alumno.getDni() %></td>
                    <td><%= alumno.getEmail() %></td>
                    <td><%= alumno.getTelefono() %></td>
                    <td>
                        <% if (alumno.isBeca()) { %>
                        <span class="badge bg-success">Sí</span>
                        <% } else { %>
                        <span class="badge bg-secondary">No</span>
                        <% } %>
                    </td>
                    <td>
                        <a href="alumno-detalle?id=<%= alumno.getId() %>" class="btn btn-outline-primary btn-sm">
                            Ver
                        </a>

                        <% if (admin) { %>
                        <a href="<%= request.getContextPath() %>/admin/alumno-form?id=<%= alumno.getId() %>"
                           class="btn btn-warning btn-sm">
                            Modificar
                        </a>

                        <a href="alumno-delete?id=<%= alumno.getId() %>"
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('¿Seguro que deseas dar de baja este alumno?')">
                            Dar de baja
                        </a>
                        <% } %>
                    </td>
                </tr>

                <%  }
                } else { %>

                <tr>
                    <td colspan="7" class="text-center text-muted">
                        No hay alumnos registrados.
                    </td>
                </tr>

                <% } %>
                </tbody>
            </table>

        </div>
    </div>

</main>

<jsp:include page="includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>
