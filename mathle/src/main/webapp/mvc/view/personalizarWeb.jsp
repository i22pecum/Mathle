<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Lógica para procesar el formulario y redirigir
    String color = request.getParameter("color");
    if (color != null) {
        session.setAttribute("color", color); // Guardar el color seleccionado
        response.sendRedirect("/mathle/mvc/view/inicioSesion.jsp");  // Redirigir al index
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Personalizar Página Web</title>

  <%
    String tema = (String) session.getAttribute("color");
    if (tema == null) {
        tema = "claro";
    }
  %>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Tema<%= tema.substring(0,1).toUpperCase() + tema.substring(1) %>.css">
</head>
<body>
  <div class="container">
  <h1>Personalizar Página Web</h1>

  <form method="post" action="/mathle/PersonalizarServlet">
    <label for="color">Tema de color:</label><br>
    <select id="color" name="color">
      <option value="claro">Claro</option>
      <option value="oscuro">Oscuro</option>
      <option value="azul">Azul</option>
      <option value="verde">Verde</option>
    </select><br><br>

    <input type="submit" value="Confirmar personalización">
    <button onclick="history.back()">Atrás</button>

    <p><em>Nota:</em> Al confirmar, se aplicará el fondo y se volverá al inicio.</p>
  </form>
<div>

</body>
</html>
