<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutorial - ¿Cómo jugar a Mathle?</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #333;
        }

        .tutorial-container {
            max-width: 800px;
            background-color: #ffffff;
            padding: 20px;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        h2 {
            margin-top: 20px;
            color: #0073e6;
        }

        p {
            font-size: 18px;
            line-height: 1.6;
        }

        ul {
            margin-left: 20px;
        }

        li {
            margin-bottom: 10px;
        }

        .example {
            background-color: #e0f7fa;
            padding: 10px;
            border-left: 4px solid #00acc1;
            margin: 15px 0;
        }

        .start-button {
            display: inline-block;
            padding: 12px 25px;
            background-color: #4caf50;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background 0.3s;
            font-size: 18px;
        }

        .start-button:hover {
            background-color: #45a049;
        }

        .color-example {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .color-box {
            width: 30px;
            height: 30px;
            margin-right: 10px;
            display: inline-block;
            text-align: center;
            line-height: 30px;
            font-weight: bold;
            color: #fff;
        }

        .green { background-color: #4caf50; }
        .yellow { background-color: #ffeb3b; color: #333; }
        .gray { background-color: #9e9e9e; }
    </style>
</head>
<body>

<div class="tutorial-container">
    <h1>¿Cómo jugar a Mathle?</h1>
    <p>Mathle es un juego de lógica matemática en el que debes resolver una ecuación correcta utilizando dígitos y operadores.</p>
    
    <h2>Modos de juego:</h2>
    <ul>
        <li><b>Modo Niño:</b> Debes completar una ecuación parcialmente resuelta. Por ejemplo: <span class="example">__ + 3 = 5</span>.</li>
        <li><b>Modo Normal:</b> Debes resolver el desafío diario para el número de dígitos seleccionado (6, 8, 10 o 12).</li>
        <li><b>Desafíos Anteriores:</b> Puedes jugar los desafíos de los últimos 7 días.</li>
    </ul>

    <h2>Validación de Operaciones:</h2>
    <p>Tu ecuación debe ser válida y estar en el formato <b>operación = resultado</b>. Mathle te indicará:</p>
    <div class="color-example">
        <div class="color-box green">5</div> <p>Correcto y en posición correcta.</p>
    </div>
    <div class="color-example">
        <div class="color-box yellow">+</div> <p>Correcto pero en posición incorrecta.</p>
    </div>
    <div class="color-example">
        <div class="color-box gray">7</div> <p>Incorrecto.</p>
    </div>

    <h2>Sistema de Puntuación:</h2>
    <p>Si estás registrado, tu puntuación se calcula al completar la ecuación:</p>
    <ul>
        <li><b>Número de intentos:</b> Mayor puntuación con menos intentos.</li>
        <li><b>Tiempo:</b> Menor tiempo, mayor puntuación.</li>
        <li><b>Dificultad:</b> Más puntos en ecuaciones de mayor longitud.</li>
    </ul>
    <div class="example">
        <h3>Ejemplo de cálculo:</h3>
        <p>Si resuelves en 3 intentos y 20 segundos en modo 8 dígitos:</p>
        <p><b>Puntos = (4 puntos por intentos) + (3 puntos por tiempo) × 1.2 = 8.4 puntos</b></p>
    </div>

    <h2>Persistencia de la Partida:</h2>
    <p>Si estás registrado, tu partida se mantiene incluso si refrescas la página.</p>

    <h2>¡Empieza a jugar ahora!</h2>
    <a href="juego.jsp" class="start-button">¡Jugar ahora!</a>
</div>

</body>
</html>
