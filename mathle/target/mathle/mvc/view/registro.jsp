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
        <label for="username">Nombre de usuario:</label><br>
        <input type="text" id="username" name="username" required><br><br>

        <!-- Correo electronico -->
        <label for="email">Correo electrónico:</label><br>
        <input type="email" id="email" name="email" required
               pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
               title="Introduce un correo electrónico válido"><br><br>

        <!-- Contraseña -->
        <label for="password">Contraseña:</label><br>
        <input type="password" id="password" name="password" required><br><br>

        <input type="submit" value="Registrarse">
    </form>
</body>
</html>