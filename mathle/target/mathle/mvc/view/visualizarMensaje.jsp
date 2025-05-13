<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mensajes Blog</title>
</head>
<body>

    <div>
        <span>☰</span>
        <strong>MENSAJES BLOG</strong>
        <span style="float: right;">mathle</span>
    </div>

    <br>

    <div>
        <form method="post">
            <input type="submit" value="+" title="Agregar mensaje">
        </form>

        <div>
            <p><strong>Autor:</strong> Usuario1<br>
            <strong>Mensaje:</strong> Hola a todos. <span>2025-05-13</span></p>

            <p><strong>Autor:</strong> Usuario2<br>
            <strong>Mensaje:</strong> Bienvenidos al blog. <span>2025-05-12</span></p>

            <p><strong>Autor:</strong> Usuario3<br>
            <strong>Mensaje:</strong> ¡Qué buen día! <span>2025-05-11</span></p>
        </div>
    </div>

    <br>

    <form action="logout.jsp" method="get">
        <input type="submit" value="Salir">
    </form>

</body>
</html>
