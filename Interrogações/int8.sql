.mode columns
.headers ON
.nullvalue NULL

WITH RECURSIVE
    nextHour(n)
AS    
    (
        SELECT 0
        UNION ALL
        SELECT n + 1 FROM nextHour
        LIMIT 24
    )
SELECT Hour, Genre, Concerts
FROM(
    SELECT Genero.nome as Genre,
            substr('00' || nextHour.n, -2, 2) || ':00' as Hour,
            COUNT(*) as Concerts
    FROM Atua 
        JOIN Artista 
        JOIN nextHour
        JOIN Genero
    WHERE Atua.artista = Artista.id
        AND Artista.genero = Genero.id 
        AND cast(strftime('%H', Atua.hora_inicio) AS INTEGER) = nextHour.n
    GROUP BY Hour, Genre
)
GROUP BY Hour
HAVING MAX(Concerts)