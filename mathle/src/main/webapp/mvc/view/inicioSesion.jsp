<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <script src="${pageContext.request.contextPath}/js/login.js" defer></script> --%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Iniciar Sesión</title>
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
  <h2>Iniciar Sesión</h2>

  <%
    String mensaje = (String) request.getAttribute("mensaje");
  %>
  <% if (mensaje != null) { %>
    <div id="mensaje" class="mensaje">
      <%= mensaje %>
    </div>
  <% } %>

  <form action="/mathle/login" method="post">
    <label for="correo">Correo electrónico:</label><br>
    <input type="email" id="correo" name="correo" required><br><br>

    <label for="contrasena">Contraseña:</label><br>
    <input type="password" id="contrasena" name="contrasena" required><br><br>

    <input type="submit" value="Entrar">
  </form>

  <button onclick="history.back()">Atrás</button>
<div>
</body>
</html>
