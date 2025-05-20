<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, data.dto.Mensaje" %>
<%
    if(session.getAttribute("usuario") == null){
        response.sendRedirect("/mathle");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mensajes Blog</title>
</head>
<body>

<div>
    <h2>MENSAJES BLOG</h2>
</div>

<br>

<!-- Mostrar mensaje de error si existe -->
<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <p><%= error %></p>
<%
    }
%>

<!-- Botón para publicar nuevo mensaje -->
<form action="/mathle/mvc/view/publicarMensaje.jsp" method="get">
    <input type="submit" value="Publicar mensaje">
</form>

<!-- Listado de mensajes -->
<div>
<%
    List<Mensaje> mensajes = (List<Mensaje>) request.getAttribute("mensajes");
    if (mensajes != null && !mensajes.isEmpty()) {
        for (Mensaje m : mensajes) {
%>
    <div>
        <p>
            <strong>Autor:</strong> <%= m.getAutor() %><br>
            <strong>Mensaje:</strong> <%= m.getMensaje() %><br>
            <span><%= m.getFecha() %></span>
        </p>
    </div>
<%
        }
    } else {
%>
    <p>No hay mensajes todavía.</p>
<%
    }
%>
</div>

<br>

<!-- Botón para salir -->
<form action="<%= request.getContextPath() %>/index.jsp" method="get">
    <input type="submit" value="Salir">
</form>



</body>
</html>
