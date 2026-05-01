package com.ereyes.academiaweb.model;

import lombok.Data;
import java.time.LocalDate;

@Data
public class Alumno {
 private int id;
 private String nombre;
 private String apellidos;
 private String dni;
 private String telefono;
 private String email;
 private LocalDate fechaNacimiento;
 private boolean beca;
 private boolean activo;
 private String foto;
 private Integer idUsuario;
}
