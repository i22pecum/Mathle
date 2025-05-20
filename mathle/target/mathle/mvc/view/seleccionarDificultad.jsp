<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seleccionar Dificultad</title>
</head>
<body>
    <h2>Selecciona una dificultad</h2>

    <form action="procesarDificultad.jsp" method="post">
        <input type="radio" id="d6" name="dificultad" value="6" required>
        <label for="d6">6 dígitos</label><br>

        <input type="radio" id="d8" name="dificultad" value="8">
        <label for="d8">8 dígitos</label><br>

        <input type="radio" id="d10" name="dificultad" value="10">
        <label for="d10">10 dígitos</label><br>

        <input type="radio" id="d12" name="dificultad" value="12">
        <label for="d12">12 dígitos</label><br><br>

        <input type="submit" value="Continuar">
    </form>
</body>
</html>