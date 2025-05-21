<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, data.dto.Usuario" %>

<h2>Ranking Global de Usuarios</h2>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/Tema<%= tema.substring(0,1).toUpperCase() + tema.substring(1) %>.css">

<%
    String tema = (String) session.getAttribute("color");
    if (tema == null) {
        tema = "claro";
    }

    List<Usuario> ranking = (List<Usuario>) request.getAttribute("ranking");
    int posicion = 1;
    if (ranking != null && !ranking.isEmpty()) {
%>
    <table>
        <tr>
            <th>Posición</th>
            <th>Nombre</th>
            <th>Puntuación</th>
        </tr>
        <%
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
    </table>
<%
    } else {
%>
    <p style="text-align: center;">No hay datos de usuarios disponibles para mostrar el ranking.</p>
<%
    }
%>

<button onclick="history.back()">Atrás</button>

</body> </html>