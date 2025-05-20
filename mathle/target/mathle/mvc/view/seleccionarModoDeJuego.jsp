<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Seleccionar Modo de Juego</title>
    <script>
        function mostrarDesplegable() {
            const modo = document.querySelector('input[name="modo"]:checked')?.value;
            const contenedor = document.getElementById("opcionesAnteriores");
            if (modo === "anteriores") {
                contenedor.style.display = "block";
            } else {
                contenedor.style.display = "none";
            }
        }

        function generarFechas() {
            const select = document.getElementById("fechaSeleccionada");
            const hoy = new Date();
            for (let i = 1; i <= 7; i++) {
                const fecha = new Date(hoy);
                fecha.setDate(hoy.getDate() - i);
                const opcion = document.createElement("option");
                opcion.value = fecha.toISOString().split('T')[0]; // formato YYYY-MM-DD
                opcion.text = fecha.toLocaleDateString(); // formato local
                select.appendChild(opcion);
            }
        }

        window.onload = generarFechas;
    </script>
</head>
<body>
    <h2>Selecciona un modo de juego</h2>

    <form action="/mathle/modoJuego" method="post">
        <input type="radio" id="nino" name="modo" value="nino" required onclick="mostrarDesplegable()">
        <label for="nino">Niño</label><br>

        <input type="radio" id="desafio" name="modo" value="normal" onclick="mostrarDesplegable()">
        <label for="desafio">Desafío</label><br>

        <input type="radio" id="anteriores" name="modo" value="anteriores" onclick="mostrarDesplegable()">
        <label for="anteriores">Desafíos anteriores</label><br><br>

        <!-- Opciones adicionales para "anteriores" -->
        <div id="opcionesAnteriores" style="display:none;">
            <label>Selecciona el modo del desafío anterior:</label><br>
            <input type="radio" id="anterioresNino" name="modoAnterior" value="nino" required>
            <label for="anterioresNino">Niño</label><br>
            <input type="radio" id="anterioresNormal" name="modoAnterior" value="normal">
            <label for="anterioresNormal">Normal</label><br><br>

            <label for="fechaSeleccionada">Selecciona el día para realizar la operación:</label><br>
            <select name="fechaSeleccionada" id="fechaSeleccionada"></select><br><br>
        </div>

        <input type="submit" value="Continuar">
    </form>

    <button onclick="history.back()">Atrás</button>
</body>
</html>
