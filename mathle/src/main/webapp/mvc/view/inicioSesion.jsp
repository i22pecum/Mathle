<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar Sesión</title>
</head>
<body>

  <h2>Iniciar Sesión</h2>

  <form action="/mathle/login" method="post">
    <label for="correo">Correo electrónico:</label><br>
    <input type="email" id="correo" name="correo" required><br><br>

    <label for="contrasena">Contraseña:</label><br>
    <input type="password" id="contrasena" name="contrasena" required><br><br>

    <input type="submit" value="Entrar">
    <p id="mensaje"></p>
  </form>
  <button onclick="history.back()">Atrás</button>

</body>
</html>
