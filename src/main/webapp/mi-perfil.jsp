<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page import="com.ereyes.academiaweb.model.Alumno" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    Alumno alumno = (Alumno) request.getAttribute("alumno");

    String mensaje = (String) session.getAttribute("mensajePerfil");
    String error = (String) session.getAttribute("errorPerfil");

    session.removeAttribute("mensajePerfil");
    session.removeAttribute("errorPerfil");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi perfil - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/header.jsp"/>

<main class="container my-5">

    <h1 class="h3 mb-4">Mi perfil</h1>

    <% if (mensaje != null) { %>
    <div class="alert alert-success"><%= mensaje %></div>
    <% } %>

    <% if (error != null) { %>
    <div class="alert alert-danger"><%= error %></div>
    <% } %>

    <% if (alumno == null) { %>

    <div class="alert alert-warning">
        Tu usuario todavía no tiene un alumno asociado. Contacta con administración.
    </div>

    <% } else { %>

    <div class="row g-4">

        <div class="col-md-5">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-dark text-white">
                    Datos de acceso
                </div>
                <div class="card-body">
                    <p><strong>Usuario:</strong> <%= usuario.getNombre() %> <%= usuario.getApellidos() %></p>
                    <p><strong>Email de acceso:</strong> <%= usuario.getEmail() %></p>
                    <p><strong>Rol:</strong> <%= usuario.getRol() %></p>
                    <p><strong>Estado:</strong> <%= usuario.isActivo() ? "Activo" : "Baja" %></p>
                </div>
            </div>
        </div>

        <div class="col-md-7">
            <div class="card shadow-sm h-100">
                <div class="card-header bg-primary text-white">
                    Datos académicos del alumno
                </div>
                <div class="card-body">
                    <p><strong>Nombre:</strong> <%= alumno.getNombre() %> <%= alumno.getApellidos() %></p>
                    <p><strong>DNI:</strong> <%= alumno.getDni() %></p>
                    <p><strong>Fecha nacimiento:</strong> <%= alumno.getFechaNacimiento() %></p>
                    <p><strong>Beca:</strong> <%= alumno.isBeca() ? "Sí" : "No" %></p>
                </div>
            </div>
        </div>

    </div>

    <div class="card shadow-sm mt-4">
        <div class="card-header bg-secondary text-white">
            Modificar datos permitidos
        </div>

        <div class="card-body">
            <form action="<%= request.getContextPath() %>/mi-perfil-save" method="post"
                  onsubmit="return confirmarModificacion('este formulario')">

                <div class="mb-3">
                    <label class="form-label">Teléfono</label>
                    <input type="text"
                           name="telefono"
                           class="form-control"
                           value="<%= alumno.getTelefono() != null ? alumno.getTelefono() : "" %>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Email de contacto del alumno</label>
                    <input type="email"
                           name="emailAlumno"
                           class="form-control"
                           value="<%= alumno.getEmail() != null ? alumno.getEmail() : "" %>">
                </div>

                <div class="mb-3">
                    <label class="form-label">Foto</label>
                    <input type="text"
                           name="foto"
                           class="form-control"
                           value="<%= alumno.getFoto() != null ? alumno.getFoto() : "" %>"
                           placeholder="nombre-foto.jpg">
                </div>

                <div class="mb-4">
                    <label class="form-label">Nueva contraseña</label>
                    <input type="password"
                           name="nuevaPassword"
                           class="form-control"
                           placeholder="Dejar en blanco si no deseas cambiarla">
                </div>

                <button type="submit" class="btn btn-primary">
                    Guardar cambios
                </button>

                <a href="<%= request.getContextPath() %>/mis-matriculas" class="btn btn-outline-secondary">
                    Ver mis matrículas
                </a>

            </form>
        </div>
    </div>

    <% } %>

</main>

<jsp:include page="/includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/assets/js/main.js"></script>

</body>
</html>
