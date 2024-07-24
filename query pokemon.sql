--INSERTAR NUEVO ENTRENADOR
INSERT INTO entrenador (id, nombre, ciudad, edad) 
VALUES 
(1, 'Ash Ketchum', 'Pueblo Paleta', 15),
(2, 'Brock', 'Ciudad Plateada', 16),
(3, 'Misty', 'Ciudad Celeste', 15);

--INSERTAR NUEVO POKEMON
INSERT INTO pokemon (codigo, nombre, tipo, habilidad, ataque, defensa, salud) 
VALUES	(1, 'Pikachu', 'Eléctrico','Impactrueno' ,100 ,100, 200),
	(2, 'Bulbasaur', 'Planta', 'Latigazo', 150, 100, 150),
	(3, 'Charmander', 'Fuego', 'Lanzallamas', 120, 120, 200),
	(4, 'Squirtle', 'Agua', 'Pistola Agua', 100, 150,200);

--INSERTAR ENTRENADOR_POKEMON
INSERT INTO entrenador_pokemon (id, codigo) 
VALUES (1, 1), (2, 2), (3, 3);

--INSERTAR DATOS DE NUEVA BATALLA
INSERT INTO batalla (idbatalla, fecha, jugador1, jugador2, pokemon1, pokemon2, ganador) 
VALUES 
(1, CURRENT_DATE, 1, 2, 1, 2, 1),
(2, CURRENT_DATE, 1, 2, 2, 3, 2),
(3, CURRENT_DATE, 2, 3, 3, 4, 3),
(4, CURRENT_DATE, 1, 3, 1, 4, 1);

--CONSULTAR ENTRENADOR Y SU RESPECTIVO POKEMON
SELECT e.nombre AS entrenador, e.ciudad, e.edad, p.nombre AS pokemon, p.tipo, p.habilidad
FROM entrenador e
JOIN Entrenador_pokemon ep ON e.id = ep.id
JOIN pokemon p ON ep.codigo = p.codigo;

--CONSULTAR DETALLES DE BATALLAS CON SU ENTRENADOR Y SU POKEMON
SELECT b.idBatalla, b.Fecha, 
       e1.Nombre AS Jugador1, p1.Nombre AS Pokemon1,
       e2.Nombre AS Jugador2, p2.Nombre AS Pokemon2,
       e3.Nombre AS Ganador
FROM Batalla b
JOIN Entrenador e1 ON b.Jugador1 = e1.id
JOIN Pokemon p1 ON b.Pokemon1 = p1.codigo
JOIN Entrenador e2 ON b.Jugador2 = e2.id
JOIN Pokemon p2 ON b.Pokemon2 = p2.codigo
JOIN Entrenador e3 ON b.Ganador = e3.id;

--CONSULTAR TODOS LOS POKEMON Y SUS ENTRENADORES
SELECT p.Nombre AS Pokemon, p.Tipo, p.Habilidad, 
       e.Nombre AS Entrenador
FROM public.Pokemon p
LEFT JOIN Entrenador_Pokemon ep ON p.codigo = ep.codigo
LEFT JOIN Entrenador e ON ep.id = e.id;

--CONSULTAR ENTRENADORES Y LOS POKEMON QUE NO TIENEN
SELECT e.Nombre AS Entrenador, p.Nombre AS Pokemon
FROM Entrenador e
CROSS JOIN Pokemon p
WHERE NOT EXISTS (
    SELECT 1 
    FROM Entrenador_Pokemon ep
    WHERE ep.id = e.id AND ep.codigo = p.codigo
);

--CONSULTAR ENTRENADORES CON LA CANTIDAD DE POKEMON QUE TIENEN
SELECT e.Nombre AS Entrenador, COUNT(ep.codigo) AS CantidadPokemon
FROM Entrenador e
LEFT JOIN Entrenador_Pokemon ep ON e.id = ep.id
GROUP BY e.Nombre;

--ACTUALIZAR DATOS DE LAS TABLAS BATALLA Y EP
-- Actualiza la tabla Entrenador_Pokemon para que el ganador reciba el Pokémon del perdedor
WITH Batalla AS (
    SELECT 
        b.Ganador AS Ganador,
        b.Pokemon2 AS PokemonPerdedor,
        b.Pokemon1 AS PokemonGanador
    FROM Batalla b
    WHERE b.Ganador = b.Jugador2  -- Asegúrate de que el jugador2 es el ganador
    UNION ALL
    SELECT 
        b.Ganador AS Ganador,
        b.Pokemon1 AS PokemonPerdedor,
        b.Pokemon2 AS PokemonGanador
    FROM Batalla b
    WHERE b.Ganador = b.Jugador1  -- Asegúrate de que el jugador1 es el ganador
)
-- Inserta el Pokémon del perdedor en el entrenador ganador
INSERT INTO Entrenador_Pokemon (id, codigo)
SELECT 
    b.Ganador AS id,
    b.PokemonPerdedor AS codigo
FROM Batalla b
LEFT JOIN Entrenador_Pokemon ep
    ON ep.id = b.Ganador AND ep.codigo = b.PokemonPerdedor
WHERE ep.codigo IS NULL;

--ELIMINAR DATOS DE LAS TABLAS
BEGIN;

-- Elimina los registros de la tabla `Entrenador_Pokemon` relacionados con el Pokémon
DELETE FROM Entrenador_Pokemon
WHERE codigo = 1;

-- Elimina los registros de la tabla `Batalla` donde el Pokémon es uno de los Pokémon de la batalla
DELETE FROM Batalla
WHERE Pokemon1 = 1 OR Pokemon2 = 1;

-- Elimina el Pokémon de la tabla `Pokemon`
DELETE FROM Pokemon
WHERE codigo = 1;

COMMIT;


SELECT * FROM Pokemon
SELECT * FROM Batalla
