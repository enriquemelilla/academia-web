<%@ page import="com.ereyes.academiaweb.model.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    boolean logueado = usuarioSesion != null;
    boolean admin = logueado && "ADMIN".equals(usuarioSesion.getRol());
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/cursos">Academia Web</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuPrincipal">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menuPrincipal">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">

                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/cursos">Cursos</a>
                </li>

                <% if (logueado && !admin) { %>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/mis-matriculas">Mis matrículas</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Mi perfil</a>
                </li>
                <% } %>

                <% if (admin) { %>

                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/alumnos">Alumnos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/usuarios">Usuarios</a>
                </li>
                <% } %>

            </ul>

            <div class="d-flex align-items-center gap-2">
                <% if (logueado) { %>
                <span class="text-white small">
                        <%= usuarioSesion.getNombre() %> (<%= usuarioSesion.getRol() %>)
                    </span>
                <a href="<%= request.getContextPath() %>/logout" class="btn btn-outline-light btn-sm">Cerrar sesión</a>
                <% } else { %>
                <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-outline-light btn-sm">Login</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>
