package com.ereyes.academiaweb.model;

import lombok.Data;

import java.time.LocalDate;

@Data
public class Matricula {

    private int id;
    private int alumnoId;
    private int cursoId;
    private LocalDate fechaMatricula;
    private String estado;
    private boolean becado;
    private boolean activo;

    // Campos adicionales para mostrar (JOIN)
    private String nombreCurso;
    private String nombreAlumno;
}