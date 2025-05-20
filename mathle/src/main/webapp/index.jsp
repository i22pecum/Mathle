<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String color = (String) session.getAttribute("color");
    String fondo = "white";

    if (color != null) {
        switch (color) {
            case "oscuro": fondo = "#333"; break;
            case "azul": fondo = "#cce6ff"; break;
            case "verde": fondo = "#ccffcc"; break;
            default: fondo = "white"; break;
        }
    }
%>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Menu Principal</title>
    </head>
    <body>

        <h1>Menu Principal</h1>

        <div class="button-container">

        <%
        if (session.getAttribute("usuario") == null) {
        %>
            <form action="/mathle/mvc/view/registro.jsp" method="get">
                <button type="submit" class="button">Registrarse</button>
            </form>
            <form action="/mathle/mvc/view/inicioSesion.jsp" method="get">
                <button type="submit" class="button">Iniciar Sesión</button>
            </form>
        <%
        }
        %>
            <form action="/mathle/mvc/view/seleccionarModoDeJuego.jsp" method="get">
                <button type="submit" class="button">Jugar Partida</button>
            </form>
            <form action="/mathle/mvc/view/tutorial.jsp" method="get">
                <button type="submit" class="button">Ver Tutorial</button>
            </form>
            <form action="/mathle/RankingServlet" method="get">
                <button type="submit" class="button">Ver Ranking</button>
            </form>
            <form action="/mathle/mvc/view/personalizarWeb.jsp" method="get">
                <button type="submit" class="button">Personalizar Web</button>
            </form>
        </div>
        <%
        if (session.getAttribute("usuario") != null) {
        %>
            <form action="/mathle/MensajeServlet" method="get">
                <button type="submit" class="button">Ver Blog</button>
            </form>

            <form action="/mathle/logout" method="get">
                <input type="submit" value="Cerrar sesión">
            </form>

        <%
        }
        %>
            
    </body>
</html>
