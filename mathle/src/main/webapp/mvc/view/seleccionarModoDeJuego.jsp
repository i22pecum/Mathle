<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seleccionar Modod de Juego</title>
</head>
<body>
    <h2>Selecciona un modo de juego</h2>

    <form action="juego.jsp" method="post">
        <input type="radio" id="nino" name="dificultad" value="nino" required>
        <label for="nino">Niño</label><br>

        <input type="radio" id="normal" name="dificultad" value="normal">
        <label for="normal">Normal</label><br>

        <input type="radio" id="desafio" name="dificultad" value="desafio">
        <label for="desafio">Desafío</label><br>

        <input type="radio" id="anteriores" name="dificultad" value="anteriores">
        <label for="anteriores">Desafíos anteriores</label><br><br>

        <input type="submit" value="Continuar">
    </form>
</body>
</html>
