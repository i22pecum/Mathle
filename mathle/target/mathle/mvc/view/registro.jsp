<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Registro de Usuario</title>
</head>
<body>
    <h2>Formulario de Registro</h2>
    <form action="registro" method="post">
        <!-- Nombre de usuario -->
        <label for="nombre">Nombre de usuario:</label><br>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <!-- Correo electronico -->
        <label for="correo">Correo electrónico:</label><br>
        <input type="correo" id="correo" name="correo" required
               pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
               title="Introduce un correo electrónico válido"><br><br>

        <!-- Contraseña -->
        <label for="contrasena">Contrasena:</label><br>
        <input type="contrasena" id="contrasena" name="contrasena" required><br><br>

        <input type="submit" value="Registrarse">
    </form>
</body>
</html>