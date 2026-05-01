<%@ page import="com.ereyes.academiaweb.model.Alumno" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Alumno alumno = (Alumno) request.getAttribute("alumno");
    boolean editando = alumno != null;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= editando ? "Modificar alumno" : "Nuevo alumno" %> - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../includes/header.jsp"/>

<main class="container my-5">

    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h1 class="h4 mb-0"><%= editando ? "Modificar alumno" : "Nuevo alumno" %></h1>
        </div>

        <div class="card-body">

            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="../alumno-save" method="post">

                <% if (editando) { %>
                <input type="hidden" name="id" value="<%= alumno.getId() %>">
                <% } %>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Nombre *</label>
                        <input type="text"
                               name="nombre"
                               class="form-control"
                               required
                               value="<%= editando ? alumno.getNombre() : "" %>">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">Apellidos</label>
                        <input type="text"
                               name="apellidos"
                               class="form-control"
                               value="<%= editando ? alumno.getApellidos() : "" %>">
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">DNI *</label>
                        <input type="text"
                               name="dni"
                               class="form-control"
                               required
                               value="<%= editando ? alumno.getDni() : "" %>">
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Teléfono</label>
                        <input type="text"
                               name="telefono"
                               class="form-control"
                               value="<%= editando ? alumno.getTelefono() : "" %>">
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">Fecha nacimiento</label>
                        <input type="date"
                               name="fechaNacimiento"
                               class="form-control"
                               value="<%= editando && alumno.getFechaNacimiento() != null ? alumno.getFechaNacimiento() : "" %>">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email"
                           name="email"
                           class="form-control"
                           value="<%= editando ? alumno.getEmail() : "" %>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Foto</label>
                    <input type="text"
                           name="foto"
                           class="form-control"
                           placeholder="nombre-foto.jpg"
                           value="<%= editando && alumno.getFoto() != null ? alumno.getFoto() : "" %>">
                </div>

                <div class="form-check mb-4">
                    <input class="form-check-input"
                           type="checkbox"
                           name="beca"
                           id="beca"
                        <%= editando && alumno.isBeca() ? "checked" : "" %>>

                    <label class="form-check-label" for="beca">
                        Alumno con beca
                    </label>
                </div>

                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="../alumnos" class="btn btn-secondary">Cancelar</a>

            </form>

        </div>
    </div>

</main>

<jsp:include page="../includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>

</body>
</html>
