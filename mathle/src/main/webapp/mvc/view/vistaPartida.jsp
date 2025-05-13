<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Partida - Resolver Operación</title>
</head>
<body>

  <h1>Partida Matemática</h1>

  <p>Introduce una operación matemática válida que sea igual a 12:</p>

  <!-- Formulario para introducir la operación -->
  <form action="verificar_operacion.html" method="get">
    <label for="operacion">Tu respuesta:</label><br>
    <input type="text" id="operacion" name="operacion" placeholder="Ej: 4+4+4=12" required><br><br>

    <input type="submit" value="Enviar">
    <input type="reset" value="Cancelar">
  </form>

</body>
</html>
