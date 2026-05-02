function confirmarAccion(mensaje) {
    return confirm(mensaje);
}

function confirmarBaja(entidad) {
    return confirm("¿Seguro que deseas dar de baja " + entidad + "?");
}

function confirmarModificacion(entidad) {
    return confirm("¿Seguro que deseas guardar los cambios de " + entidad + "?");
}

function confirmarMatricula() {
    return confirm("¿Deseas matricularte en este curso?");
}

function confirmarReactivacion(entidad) {
    return confirm("¿Seguro que deseas reactivar " + entidad + "?");
}