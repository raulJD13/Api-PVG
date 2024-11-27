CREATE DATABASE TerraSplash;
USE TerraSplash;

CREATE TABLE Usuario (
    id_usuario BIGINT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    contraseña VARCHAR(255) NOT NULL,
    localizacion VARCHAR(255),
    foto_perfil VARCHAR(255),
    foto_fondo_perfil VARCHAR(255)
);

CREATE TABLE Deporte (
    id_deporte BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo ENUM('agua', 'tierra') NOT NULL,
    imagen VARCHAR(255)
);

CREATE TABLE Actividad (
    id_actividad BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    valoracion FLOAT CHECK(valoracion >= 0 AND valoracion <= 5), -- Escala de 0 a 5
    precio DECIMAL(10, 2) CHECK(precio >= 0), -- Precio en formato decimal
    descripcion TEXT,
    latitud DECIMAL(10, 8),
    longitud DECIMAL(11, 8),
    dificultad ENUM('facil', 'intermedia', 'dificil'),
    imagen VARCHAR(255),
    disponibilidad BOOLEAN DEFAULT TRUE, 
    destacada BOOLEAN DEFAULT FALSE, -- Para actividades destacadas
    id_deporte BIGINT NOT NULL,
    FOREIGN KEY (id_deporte) REFERENCES Deporte(id_deporte) ON DELETE CASCADE
);

CREATE TABLE Comentario (
    id_comentario BIGINT AUTO_INCREMENT PRIMARY KEY,
    texto TEXT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario BIGINT NOT NULL,
    id_actividad BIGINT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_actividad) REFERENCES Actividad(id_actividad) ON DELETE CASCADE
);

CREATE TABLE UsuarioActividad (
    id_usuario_actividad BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    actividad_id BIGINT NOT NULL,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Opcional: registra la fecha de inscripción
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (actividad_id) REFERENCES Actividad(id_actividad) ON DELETE CASCADE,
    UNIQUE (usuario_id, actividad_id) -- Evita duplicados en la relación
);
