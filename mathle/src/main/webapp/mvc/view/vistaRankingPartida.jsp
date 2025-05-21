<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="data.dto.Usuario" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ranking de Partida</title>
    <%
        String tema = (String) session.getAttribute("color");
        if (tema == null) {
            tema = "claro";
        }
    %>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Tema<%= tema.substring(0,1).toUpperCase() + tema.substring(1) %>.css">

</head>
<body>

<h2>Ranking de Partida</h2>

<%
    String error = (String) request.getAttribute("error");
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
    }
%>

<%
    List<Usuario> ranking = (List<Usuario>) request.getAttribute("ranking");
    if (ranking == null || ranking.isEmpty()) {
%>
    <p>No hay datos de ranking para esta partida.</p>
<%
    } else {
%>
    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>Posición</th>
                <th>Nombre de Usuario</th>
                <th>Puntuación</th>
            </tr>
        </thead>
        <tbody>
        <%
            int posicion = 1;
            for (Usuario usuario : ranking) {
        %>
            <tr>
                <td><%= posicion++ %></td>
                <td><%= usuario.getNombre() %></td>
                <td><%= usuario.getPuntuacion() %></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
<%
    }
%>

<!-- Botón para volver al menú o página anterior -->
<button onclick="history.back()">Atrás</button>

</body>
</html>
