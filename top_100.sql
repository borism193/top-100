--Crear base de datos llamada películas

CREATE DATABASE pelicula;

/c pelicula

-- Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,
-- determinando la relación entre ambas tablas.

CREATE TABLE peliculas (
id INT NOT NULL PRIMARY KEY,
pelicula VARCHAR (100),
año_estreno INT,
director VARCHAR (100)
);

CREATE TABLE reparto (
id_pelicula INT NOT NULL,
actores VARCHAR(100) NOT NULL,
FOREIGN KEY(id_pelicula) REFERENCES peliculas(id)
);

--Cargar ambos archivos a su tabla correspondiente

COPY reparto  
FROM '/home/boris/Documentos/sql/100_peliculas/reparto.csv' --cambiar ruta
DELIMITER ','
CSV HEADER;

COPY peliculas
FROM '/home/boris/Documentos/sql/100_peliculas/peliculas.csv' --cambiar ruta
DELIMITER ','
CSV HEADER;

-- Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,
-- año de estreno, director y todo el reparto.

SELECT (pelicula, año_estreno, director, actores) 
FROM peliculas            
INNER JOIN reparto           
ON id = id_pelicula
WHERE pelicula  = 'Titanic'
;

--Listar los titulos de las películas donde actúe Harrison Ford
SELECT actores, pelicula 
FROM peliculas
INNER JOIN reparto 
ON id = id_pelicula 
WHERE actores = 'Harrison Ford'
;

--Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el
--top 100


SELECT director, COUNT(*) AS top_10 
FROM peliculas 
GROUP BY director 
ORDER BY top_10 DESC LIMIT 10
;

-- Indicar cuantos actores distintos hay

SELECT COUNT(DISTINCT actores) FROM reparto;

--Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por
--título de manera ascendente

SELECT pelicula, año_estreno 
FROM peliculas 
WHERE año_estreno
BETWEEN '1990' AND '1999'
ORDER BY pelicula
;

--Listar el reparto de las películas lanzadas el año 2001

SELECT pelicula, año_estreno, actores
FROM peliculas
INNER JOIN reparto
ON id = id_pelicula 
WHERE año_estreno='2001'
;

--Listar los actores de la película más nueva

SELECT pelicula, año_estreno, actores
FROM peliculas
INNER JOIN reparto
ON id = id_pelicula 
WHERE año_estreno = MAX(año_estreno)
;