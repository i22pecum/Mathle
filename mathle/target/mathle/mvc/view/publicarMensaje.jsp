<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Publicar Mensaje</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }

        .contenedor-principal {
            border: 1px solid black;
            width: 300px;
            margin: 50px auto;
            padding: 10px;
        }

        .titulo {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .contenedor-mensaje {
            border: 1px solid black;
            padding: 15px;
            border-radius: 10px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        textarea {
            width: 90%;
            height: 100px;
            margin-bottom: 15px;
            border-radius: 10px;
            padding: 5px;
            resize: none;
        }

        .botones {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .botones input {
            padding: 5px 15px;
            border-radius: 5px;
            border: 1px solid #555;
            cursor: pointer;
        }

        .pie {
            margin-top: 10px;
            font-size: 12px;
        }
    </style>
</head>
<body>

<div class="contenedor-principal">
    <div class="titulo">PUBLICAR MENSAJE</div>

    <div class="contenedor-mensaje">
        <form action="procesarMensaje.jsp" method="post">
            <label for="mensaje">Introduce el mensaje:</label>
            <textarea id="mensaje" name="mensaje" required></textarea>

            <div class="botones">
                <input type="reset" value="Cancelar">
                <input type="submit" value="Enviar">
            </div>
        </form>
    </div>

    <div class="pie">Publicar mensajes blog</div>
</div>

</body>
</html>
