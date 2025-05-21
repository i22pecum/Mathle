<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("/mathle");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Publicar Mensaje</title>

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
    <div class="titulo">PUBLICAR MENSAJE</div>

    <div class="contenedor-mensaje">
        <form action="<%= request.getContextPath() %>/MensajeServlet" method="post">
            <label for="mensaje">Introduce el mensaje:</label>
            <textarea id="mensaje" name="mensaje" required></textarea>

            <div class="botones">
                <button onclick="history.back()">Atrás</button>
                <input type="submit" value="Enviar">
            </div>
        </form>



    </div>

    <div class="pie">Publicar mensajes blog</div>
</div>

</body>
</html>
