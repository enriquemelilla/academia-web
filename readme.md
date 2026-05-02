# Academia Web
## Descripción

Academia Web es una aplicación desarrollada en Java que permite la gestión de cursos, alumnos, matrículas y usuarios.

El sistema incluye control de acceso por roles (ADMIN y USER), zona privada para usuarios, gestión de relaciones entre entidades y funcionalidades completas de administración.

## Instalación

**1. Base de datos**

CREATE DATABASE academia_web;

Ejecutar el script:

01_schema.sql

**2. Configuración conexión**

Revisar el archivo:

JdbiConfig.java

Cadena de conexión:

jdbc:mariadb://localhost:3306/academia_web

**3. Ejecutar proyecto**

Abrir en IntelliJ
Configurar Tomcat
Ejecutar la aplicación

Acceso:

(http://localhost:8080/)

Acceso

Usuario ADMIN

Permite:

- Gestionar cursos
- Gestionar alumnos
- Gestionar usuarios

Usuario USER

Permite:

- Ver cursos
- Matricularse
- Ver sus matrículas
- Acceder a su perfil

## Funcionalidades principales

CRUD

- Cursos
- Alumnos
- Usuarios (cuarta tabla)
- Matrículas

Búsqueda avanzada

- Cursos ->  nombre + estado
- Alumnos -> nombre + DNI
- Usuarios -> email + rol

Relaciones

Usuario <-> Alumno (1:1)
Alumno <-> Matrícula (1:N)
Curso <-> Matrícula (1:N)

Zona privada

Mi perfil

- Edición de datos personales
- Cambio de contraseña

Imágenes

-Subida de imagen en cursos
-Imagen por defecto
-Adaptación automática al contenedor

Confirmaciones JavaScript

-Antes de modificar
-Antes de borrar
-Antes de matricularse

Validaciones

- Campos obligatorios
- Control de duplicados en matrículas
- Restricción de usuario único por alumno

Endpoints principales

/                -> Inicio

/login           -> Login

/logout          -> Logout

/cursos          -> Listado cursos

/curso-detalle   -> Detalle curso

/alumnos         -> Gestión alumnos (ADMIN)

/usuarios        -> Gestión usuarios (ADMIN)

/mis-matriculas  -> Matrículas usuario

/mi-perfil       -> Perfil usuario

Control de versiones

Se ha utilizado GitFlow:

main

develop

feature/*

Repositorio:

https://github.com/enriquemelilla/academia-web

## Cumplimiento de la AA2

**Obligatorio**

- Dar de alta: Se podrá dar de alta, a través de formulario web, información de al menos 3 tablas de la Base de Datos. Se validarán al   menos 2 campos de cada tabla en cada formulario. Al menos uno de los formularios podrá aceptar imágenes para subirlas y relacionarlas   con el elemento que se registra.
- Listado y Vista Detalle: Se podrá listar toda la información de las 3 tablas que hayas decidido que se pueden dar de alta y se podrá   visualizar, haciendo click en cada uno de ellos, la información completa sobre dicho elemento
- Búsqueda: Los usuarios podrán realizar búsquedas de las 3 tablas con los que hayas decidido trabajar. En la búsqueda se podrán   emplear, al menos, 2 criterios de búsqueda al mismo tiempo.
- Modificar y dar de baja: Se podrá modificar la información de cualquier elemento desde su vista detalle. También podrá dar de baja   información de cualquiera de las tablas existentes (por ejemplo desde la vista Listado o la Vista Detalle)
- Login de usuarios: Implementa un sistema de login de forma que los usuarios de la web puedan iniciar/cerrar sesión. De alguna manera   la web se adaptará o modificará sus características para los usuarios que inicien sesión (por ejemplo, sólo un tipo determinado de   usuario puede eliminar/modificar/añadir información). Contempla al menos 2 roles de usuarios diferentes.

**Voluntarios**

- Repositorio GitHub para el proyecto: Crea un repositorio en GitHub para guardar el código del proyecto. Utiliza Git Flow para subir   los cambios que vayas haciendo
- Funcionalidad (relaciones): Implementa funcionalidades en la web que permitan establecer relaciones entre datos de diferentes tablas.   Por ejemplo: que un usuario pueda comprar un producto.
- Permite trabajar con la información de una cuarta tabla (alta, baja, listado) de la misma forma que has hecho con las anteriores
- Zona privada: Diseña una zona privada para los usuarios, de forma que puedan modificar su perfil (sus datos personales y contraseña de   acceso)
- (Javascript) Pide confirmación antes de realizar cualquier operación de modificación o borrado