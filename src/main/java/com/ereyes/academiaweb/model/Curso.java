package com.ereyes.academiaweb.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Curso {

    private int id;
    private String nombre;
    private String descripcion;
    private int horas;
    private BigDecimal precio;
    private LocalDate fechaInicio;
    private boolean activo;
    private String imagen;
}