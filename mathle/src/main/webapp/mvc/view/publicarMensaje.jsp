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
</head>
<body>

<div class="contenedor-principal">
    <div class="titulo">PUBLICAR MENSAJE</div>

    <div class="contenedor-mensaje">
        <form action="<%= request.getContextPath() %>/MensajeServlet" method="post">
    <label for="mensaje">Introduce el mensaje:</label>
    <textarea id="mensaje" name="mensaje" required></textarea>

    <div class="botones">
        <input type="button" value="Cancelar"
               onclick="window.location.href='<%= request.getContextPath() %>/mvc/view/visualizarMensaje.jsp'">
        <input type="submit" value="Enviar">
    </div>
</form>



    </div>

    <div class="pie">Publicar mensajes blog</div>
</div>

</body>
</html>
