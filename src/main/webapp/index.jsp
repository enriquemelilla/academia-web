<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Academia Web</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/css/styles.css" rel="stylesheet">
</head>

<body>

<jsp:include page="includes/header.jsp"/>

<main class="container my-5">

    <section class="mb-5">
        <div class="p-5 bg-light rounded-3 shadow-sm">
            <h1 class="display-5 fw-bold">Academia Web</h1>
            <p class="fs-5">
                Plataforma para la gestión de cursos, alumnos y matrículas.
            </p>
            <p class="text-muted">
                Proyecto desarrollado en Java, JSP, Servlets, MariaDB y Bootstrap.
            </p>
        </div>
    </section>

    <section>
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="h3">Cursos disponibles</h2>
            <span class="badge bg-primary">Demo inicial</span>
        </div>

        <div class="row g-4">

            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="curso-img bg-primary text-white">
                        JAVA
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Java Básico</h5>
                        <p class="card-text">
                            Curso inicial de programación orientada a objetos con Java.
                        </p>
                        <ul class="list-unstyled small text-muted">
                            <li>Horas: 80</li>
                            <li>Precio: 120 €</li>
                            <li>Estado: Activo</li>
                        </ul>
                    </div>
                    <div class="card-footer bg-white border-0 d-flex gap-2">
                        <a href="#" class="btn btn-outline-primary btn-sm">Ver detalle</a>
                        <a href="#" class="btn btn-primary btn-sm">Matricularme</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="curso-img bg-success text-white">
                        WEB
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">HTML y CSS</h5>
                        <p class="card-text">
                            Diseño de páginas web modernas utilizando HTML5, CSS3 y Bootstrap.
                        </p>
                        <ul class="list-unstyled small text-muted">
                            <li>Horas: 60</li>
                            <li>Precio: 90 €</li>
                            <li>Estado: Activo</li>
                        </ul>
                    </div>
                    <div class="card-footer bg-white border-0 d-flex gap-2">
                        <a href="#" class="btn btn-outline-primary btn-sm">Ver detalle</a>
                        <a href="#" class="btn btn-primary btn-sm">Matricularme</a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <div class="curso-img bg-warning text-dark">
                        SQL
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Bases de Datos</h5>
                        <p class="card-text">
                            Introducción a bases de datos relacionales, SQL y MariaDB.
                        </p>
                        <ul class="list-unstyled small text-muted">
                            <li>Horas: 100</li>
                            <li>Precio: 150 €</li>
                            <li>Estado: Activo</li>
                        </ul>
                    </div>
                    <div class="card-footer bg-white border-0 d-flex gap-2">
                        <a href="#" class="btn btn-outline-primary btn-sm">Ver detalle</a>
                        <a href="#" class="btn btn-primary btn-sm">Matricularme</a>
                    </div>
                </div>
            </div>

        </div>
    </section>

</main>

<jsp:include page="includes/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>