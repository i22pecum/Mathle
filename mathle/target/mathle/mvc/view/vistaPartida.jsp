<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer dificultad = (Integer) session.getAttribute("dificultad");
    String operacion = (String) session.getAttribute("operacion");
    String modoJuego = (String) session.getAttribute("modoJuego");
    String operacionVisible = "";

    if (dificultad == null || operacion == null) {
        throw new RuntimeException("Error: No se ha definido la dificultad u operación en la sesión.");
    }

    if ("ninos".equals(modoJuego)) {
        int mitad = dificultad / 2;
        operacionVisible = operacion.substring(0, mitad);
    }

    String tema = (String) session.getAttribute("color");
    if (tema == null) {
        tema = "claro";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Jugar Partida</title>
    <link rel="stylesheet" href="css/estilos-juego.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/Tema<%= tema.substring(0,1).toUpperCase() + tema.substring(1) %>.css">
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
        const modoJuego = "<%= modoJuego %>";
        const operacionVisible = "<%= operacionVisible %>";
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
            for (let f = 0; f < 6; f++) {
                for (let col = 0; col < dificultad; col++) {
                    const input = document.getElementById(`input-${f}-${col}`);
                    if (!input) continue;
                    // Solo habilita la fila activa
                    if (f === fila) {
                        // En modo niños, la primera mitad está bloqueada
                        if (modoJuego === "ninos" && col < dificultad / 2) {
                            input.value = operacionCorrecta[col];
                            input.disabled = true;
                            input.classList.add("verde");
                        } else {
                            input.disabled = false;
                        }
                    } else {
                        input.disabled = true;
                    }
                }
            }
            // Enfoca el primer input editable de la fila activa
            let startCol = (modoJuego === "ninos" && fila === 0) ? Math.floor(dificultad / 2) : 0;
            const firstEditable = document.getElementById(`input-${fila}-${startCol}`);
            if (firstEditable) firstEditable.focus();
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
                mostrarMensaje("Completa toda la fila.");
                return;
            }

            if (!esOperacionValida(intento)) {
                mostrarMensaje("La operación no es válida.");
                return;
            }

            intentos++;

            const resultado = Array(dificultad).fill("gris");
            const usados = Array(dificultad).fill(false);

            for (let i = 0; i < dificultad; i++) {
                if (intento[i] === operacionCorrecta[i]) {
                    resultado[i] = "verde";
                    usados[i] = true;
                }
            }

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

            for (let col = 0; col < dificultad; col++) {
                const input = document.getElementById(`input-${filaActual}-${col}`);
                input.classList.add(resultado[col]);
                input.disabled = true;
            }

            if (intento === operacionCorrecta) {
                mostrarMensaje("¡Correcto! Has ganado.", "exito");
                setTimeout(() => {
                    tiempo = calcularTiempo();
                    enviarResultado(intentos, tiempo);
                }, 1500);
                return;
            }

            if (filaActual < 5) {
                filaActual++;
                activarFila(filaActual);
            } else {
                mostrarMensaje("Has perdido. La operación era: " + operacionCorrecta);
                setTimeout(() => {
                    tiempo = calcularTiempo();
                    enviarResultado(7, tiempo);
                }, 1500);
            }
        }

        function calcularTiempo() {
            return Math.floor((Date.now() - tiempoInicio) / 1000);
        }

        function enviarResultado(numIntentos, tiempo) {
            document.getElementById("inputIntentos").value = numIntentos;
            document.getElementById("inputTiempo").value = tiempo;
            document.getElementById("formResultado").submit();
        }

        function mostrarMensaje(texto, tipo = "error") {
            const mensaje = document.getElementById("mensaje");
            mensaje.textContent = texto;
            mensaje.className = "mensaje " + (tipo === "exito" ? "exito" : "");
            mensaje.style.display = "block";

            // Reinicia animación (permite mostrar varias veces)
            mensaje.style.animation = "none";
            mensaje.offsetHeight; // forzar repaint
            mensaje.style.animation = "fadeOut 3s forwards";
        }

        window.onload = function () {
            activarFila(filaActual);

            if (modoJuego === "ninos" && operacionVisible) {
                for (let i = 0; i < operacionVisible.length; i++) {
                    const input = document.getElementById(`input-0-${i}`);
                    if (input) {
                        input.value = operacionVisible[i];
                        input.disabled = true;
                        input.classList.add("verde");
                    }
                }
                const siguiente = document.getElementById(`input-0-${operacionVisible.length}`);
                if (siguiente) siguiente.focus();
            }
        };
    </script>
</head>
<body>
<div id="mensaje" style="display:none;" class="mensaje"></div>
<div class="container">
    <h2>Introduce la operación matemática</h2>

    <form onsubmit="event.preventDefault(); comprobarIntento();">
        <% for (int fila = 0; fila < 6; fila++) { %>
            <div class="fila">
                <% for (int col = 0; col < dificultad; col++) {
                    boolean mostrarFijo = "ninos".equals(modoJuego) && col < (dificultad / 2);
                    char caracter = mostrarFijo ? operacion.charAt(col) : ' ';
                %>
                    <input type="text"
                        id="input-<%= fila %>-<%= col %>"
                        maxlength="1"
                        class="casilla"
                        data-fila="<%= fila %>"
                        data-col="<%= col %>"
                        autocomplete="off"
                        value=""
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
</div>
</body>
</html>
