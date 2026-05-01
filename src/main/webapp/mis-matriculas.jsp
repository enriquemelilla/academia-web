<%@ page import="java.util.List" %>
<%@ page import="com.ereyes.academiaweb.model.Matricula" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    List<Matricula> matriculas = (List<Matricula>) request.getAttribute("matriculas");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis matrículas - Academia Web</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/assets/css/styles.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/header.jsp"/>

<main class="container my-5">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="h3">Mis matrículas</h1>
        <a href="<%= request.getContextPath() %>/cursos" class="btn btn-outline-primary">
            Ver cursos
        </a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">

            <table class="table table-striped table-hover align-middle">
                <thead class="table-dark">
                <tr>
                    <th>Curso</th>
                    <th>Fecha matrícula</th>
                    <th>Estado</th>
                    <th>Becado</th>
                </tr>
                </thead>

                <tbody>
                <% if (matriculas != null && !matriculas.isEmpty()) {
                    for (Matricula matricula : matriculas) { %>

                <tr>
                    <td><%= matricula.getNombreCurso() %></td>
                    <td><%= matricula.getFechaMatricula() %></td>
                    <td>
                            <span class="badge bg-success">
                                <%= matricula.getEstado() %>
                            </span>
                    </td>
                    <td>
                        <% if (matricula.isBecado()) { %>
                        <span class="badge bg-success">Sí</span>
                        <% } else { %>
                        <span class="badge bg-secondary">No</span>
                        <% } %>
                    </td>
                </tr>

                <%  }
                } else { %>

                <tr>
                    <td colspan="4" class="text-center text-muted">
                        Todavía no tienes matrículas registradas.
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
