<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer dificultad = (Integer) session.getAttribute("dificultad");
    String operacion = (String) session.getAttribute("operacion");

    if (dificultad == null || operacion == null) {
        throw new RuntimeException("Error: No se ha definido la dificultad u operación en la sesión.");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Jugar Partida</title>
    <link rel="stylesheet" href="css/estilos-juego.css" />
    <style>
        .casilla {
            width: 40px;
            height: 40px;
            text-align: center;
            font-size: 24px;
            margin: 2px;
        }

        .verde {
            background-color: #6aaa64 !important;
            color: white;
        }

        .amarillo {
            background-color: #c9b458 !important;
            color: white;
        }

        .gris {
            background-color: #787c7e !important;
            color: white;
        }
    </style>
    <script>
        const operacionCorrecta = "<%= operacion %>";
        const dificultad = <%= dificultad %>;
        let filaActual = 0;
        let intentos = 0;
        let tiempoInicio = Date.now();
        let tiempo;

        function avanzarFocus(event, fila, col) {
            fila = parseInt(fila);
            col = parseInt(col);

            const key = event.key;
            const siguiente = document.getElementById("input-" + fila + "-" + (col + 1));
            const anterior = document.getElementById("input-" + fila + "-" + (col - 1));

            if (key.length === 1 && siguiente) {
                setTimeout(() => siguiente.focus(), 10);
            } else if (key === "Backspace" && anterior && event.target.value === "") {
                setTimeout(() => anterior.focus(), 10);
            }
        }

        function leerFila(fila) {
            let intento = "";
            for (let col = 0; col < dificultad; col++) {
                const input = document.getElementById(`input-${fila}-${col}`);
                intento += input.value;
            }
            return intento;
        }

        function esOperacionValida(op) {
            try {
                const [izq, der] = op.split("=");
                if (!der) return false;
                return eval(izq) == eval(der);
            } catch (e) {
                return false;
            }
        }

        function activarFila(fila) {
            for (let col = 0; col < dificultad; col++) {
                const input = document.getElementById(`input-${fila}-${col}`);
                if (input) {
                    input.disabled = false;
                }
            }
            document.getElementById(`input-${fila}-0`).focus();
        }

        function desactivarFila(fila) {
            for (let col = 0; col < dificultad; col++) {
                const input = document.getElementById(`input-${fila}-${col}`);
                if (input) {
                    input.disabled = true;
                }
            }
        }

        function comprobarIntento() {
            const intento = leerFila(filaActual);

            if (intento.length !== dificultad) {
                alert("Completa toda la fila.");
                return;
            }

            if (!esOperacionValida(intento)) {
                alert("La operación no es válida.");
                return;
            }

            intentos++;

            const resultado = Array(dificultad).fill("gris");
            const usados = Array(dificultad).fill(false);

            // Verde
            for (let i = 0; i < dificultad; i++) {
                if (intento[i] === operacionCorrecta[i]) {
                    resultado[i] = "verde";
                    usados[i] = true;
                }
            }

            // Amarillo
            for (let i = 0; i < dificultad; i++) {
                if (resultado[i] !== "gris") continue;
                for (let j = 0; j < dificultad; j++) {
                    if (!usados[j] && intento[i] === operacionCorrecta[j]) {
                        resultado[i] = "amarillo";
                        usados[j] = true;
                        break;
                    }
                }
            }

            // Aplicar colores y desactivar inputs actuales
            for (let col = 0; col < dificultad; col++) {
                const input = document.getElementById(`input-${filaActual}-${col}`);
                input.classList.add(resultado[col]);
                input.disabled = true;
            }

            if (intento === operacionCorrecta) {
                setTimeout(() => {
                    tiempo = calcularTiempo();
                    alert("¡Correcto! Has ganado.");
                    enviarResultado(intentos, tiempo);
                }, 100);
                return;
            }

            if (filaActual < 5) {
                filaActual++;
                activarFila(filaActual);
            } else {
                setTimeout(() => {
                    tiempo = calcularTiempo();
                    alert("Has perdido. La operación era: " + operacionCorrecta);
                    enviarResultado(7, tiempo);
                }, 100);
            }
        }

        function calcularTiempo() {
            return Math.floor((Date.now() - tiempoInicio) / 1000); // tiempo en segundos
        }

        function enviarResultado(numIntentos, tiempo) {
            document.getElementById("inputIntentos").value = numIntentos;
            document.getElementById("inputTiempo").value = tiempo;
            document.getElementById("formResultado").submit();
        }

        window.onload = function () {
            activarFila(filaActual);
        };
    </script>
    <title>Seleccionar Dificultad</title>
    <%
        String tema = (String) session.getAttribute("color");
        if (tema == null) {
            tema = "claro";
        }
    %>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Tema<%= tema.substring(0,1).toUpperCase() + tema.substring(1) %>.css">
</head>
<body>
    <div class="container">
    <h2>Introduce la operación matemática</h2>

    <form onsubmit="event.preventDefault(); comprobarIntento();">
        <% for (int fila = 0; fila < 6; fila++) { %>
            <div class="fila">
                <% for (int col = 0; col < dificultad; col++) { %>
                    <input type="text"
                           id="input-<%= fila %>-<%= col %>"
                           maxlength="1"
                           class="casilla"
                           data-fila="<%= fila %>"
                           data-col="<%= col %>"
                           autocomplete="off"
                           disabled
                           onkeyup="avanzarFocus(event, this.dataset.fila, this.dataset.col)">
                <% } %>
            </div>
        <% } %>
        <div style="text-align: center; margin-top: 10px;">
            <input type="submit" value="Comprobar">
        </div>
    </form>

    <div style="text-align: center; margin-top: 20px;">
        <button onclick="history.back()">Atrás</button>
    </div>

    <form id="formResultado" method="post" action="/mathle/partida" style="display:none;">
        <input type="hidden" name="intentos" id="inputIntentos">
        <input type="hidden" name="tiempo" id="inputTiempo">
    </form>
    <div>
</body>
</html>
