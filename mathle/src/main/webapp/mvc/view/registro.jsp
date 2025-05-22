<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Registro de Usuario</title>
  <%
    String tema = (String) session.getAttribute("color");
    if (tema == null) {
        tema = "claro";
    }
  %>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Tema<%= tema.substring(0,1).toUpperCase() + tema.substring(1) %>.css">

  <script src="/js/notificacionMensaje.js" defer></script>
</head>

<body>
  <div class="container">
  <h2>Formulario de Registro</h2>

  <!-- Mensaje de error del servidor o del JS -->
  <%
    String mensaje = (String) request.getAttribute("mensaje");
  %>
  <% if (mensaje != null) { %>
    <div id="mensaje" class="mensaje">
      <%= mensaje %>
    </div>
  <% } %>

  <form action="/mathle/registro" method="post">
    <label for="nombre">Nombre de usuario:</label><br>
    <input type="text" id="nombre" name="nombre" required><br><br>

    <label for="correo">Correo electrónico:</label><br>
    <input type="email" id="correo" name="correo" required><br><br>

    <label for="contrasena">Contraseña:</label><br>
    <input type="password" id="contrasena" name="contrasena" required><br><br>

    <input type="submit" value="Registrarse">
  </form>

  <button onclick="history.back()">Atrás</button>
  <div>
</body>
</html>
