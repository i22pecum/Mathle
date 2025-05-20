<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, tu.paquete.Usuario" %>

<!DOCTYPE html> <html> <head> <meta charset="UTF-8"> <title>Ranking Global</title> <style> body { font-family: Arial, sans-serif; background-color: #f4f6f8; margin: 0; padding: 20px; } h2 { text-align: center; color: #333; } table { margin: 0 auto; width: 60%; border-collapse: collapse; background-color: #fff; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); } th, td { padding: 12px; text-align: center; border-bottom: 1px solid #ddd; } th { background-color: #007bff; color: white; } tr:hover { background-color: #f1f1f1; } </style> </head> <body>
<h2>Ranking Global de Usuarios</h2>

<%
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
</body> </html>