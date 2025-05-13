<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar Sesión</title>
</head>
<body>

  <h2>Iniciar Sesión</h2>

  <form onsubmit="return validarLogin(event)">
    <label for="correo">Correo electrónico:</label><br>
    <input type="email" id="correo" name="correo" required><br><br>

    <label for="contrasena">Contraseña:</label><br>
    <input type="password" id="contrasena" name="contrasena" required><br><br>

    <input type="submit" value="Entrar">
    <p id="mensaje"></p>
  </form>

  <script>
    function validarLogin(event) {
      event.preventDefault();

      var correo = document.getElementById("correo").value;
      var contrasena = document.getElementById("contrasena").value;
      var mensaje = document.getElementById("mensaje");

      // Simulación de credenciales
      if (correo === "ejemplo@correo.com" && contrasena === "123456") {
        mensaje.textContent = "Inicio de sesión exitoso.";
      } else {
        mensaje.textContent = "Correo o contraseña incorrectos.";
      }

      return false;
    }
  </script>

</body>
</html>
