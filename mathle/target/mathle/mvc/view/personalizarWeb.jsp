<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Personalizar Página Web</title>
</head>
<body>

  <h1>Personalizar Página Web</h1>

  <form method="post">
    <!-- Opción 1: Selección de tema de color -->
    <label for="color">Tema de color:</label><br>
    <select id="color" name="color">
      <option value="claro">Claro</option>
      <option value="oscuro">Oscuro</option>
      <option value="azul">Azul</option>
      <option value="verde">Verde</option>
    </select><br><br>

    <!-- Opción 2: Selección de fuente -->
    <label for="fuente">Tipo de letra:</label><br>
    <select id="fuente" name="fuente">
      <option value="arial">Arial</option>
      <option value="verdana">Verdana</option>
      <option value="times">Times New Roman</option>
      <option value="courier">Courier New</option>
    </select><br><br>

    <!-- Opción 3: Diseño general -->
    <label for="diseño">Diseño de la página:</label><br>
    <select id="diseño" name="diseño">
      <option value="clasico">Clásico</option>
      <option value="moderno">Moderno</option>
      <option value="minimalista">Minimalista</option>
    </select><br><br>

    <!-- Botones de acción -->
    <input type="submit" value="Confirmar personalización">
    <input type="reset" value="Cancelar"><br><br>

    <!-- Resultado simulado -->
    <p><em>Nota:</em> Al confirmar, se mostraría un mensaje de confirmación (esto requiere JavaScript o backend).</p>
  </form>

</body>
</html>
