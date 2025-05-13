<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Visualizar Ranking Global</title>
</head>
<body>

  <h1>Ranking Global</h1>

  <!-- Nota para condiciones previas -->
  <p><strong>Nota:</strong> Esta sección requiere haber iniciado sesión y haber jugado al menos una partida.</p>

  <!-- Tabla de ranking -->
  <table border="1" cellpadding="5" cellspacing="0">
    <thead>
      <tr>
        <th>Posición</th>
        <th>Nombre de Usuario</th>
        <th>Puntaje</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>1</td>
        <td>JugadorPro</td>
        <td>9800</td>
      </tr>
      <tr>
        <td>2</td>
        <td>SuperUser123</td>
        <td>9500</td>
      </tr>
      <tr>
        <td>3</td>
        <td>LegendX</td>
        <td>9400</td>
      </tr>
      <!-- Puedes agregar más filas aquí -->

      <!-- Ejemplo de posición del usuario actual -->
      <tr>
        <td><strong>27</strong></td>
        <td><strong>TuUsuario</strong></td>
        <td><strong>4100</strong></td>
      </tr>
    </tbody>
  </table>

  <br>

  <!-- Botón simulado para cancelar o regresar -->
  <form action="pantalla_anterior.html" method="get">
    <input type="submit" value="Cancelar / Volver">
  </form>

</body>
</html>
