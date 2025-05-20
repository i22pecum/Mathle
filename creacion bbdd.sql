CREATE TABLE usuario (
    correo VARCHAR(100) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    puntuacion FLOAT DEFAULT 0,
    tema VARCHAR(20) DEFAULT 'claro'
);

CREATE TABLE mensaje (
    id INT AUTO_INCREMENT PRIMARY KEY,
    autor VARCHAR(100) NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    mensaje TEXT NOT NULL,
    FOREIGN KEY (autor) REFERENCES usuario(correo)
);

CREATE TABLE problema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operacion VARCHAR(15) NOT NULL,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    dificultad ENUM('6', '8', '10', '12'),
    modo_juego ENUM('normal', 'ninos')
);

CREATE TABLE partida (
    idProblema INT NOT NULL,
    correoUsuario VARCHAR(100) NOT NULL,
    duracion INT NOT NULL,
    intentos INT NOT NULL,
    puntuacion FLOAT NOT NULL,
    PRIMARY KEY (idProblema, correoUsuario),
    FOREIGN KEY (correoUsuario) REFERENCES usuario(correo),
    FOREIGN KEY (idProblema) REFERENCES problema(id)
);

