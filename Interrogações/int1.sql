.mode columns
.headers ON
.nullvalue NULL

SELECT data as Dia, hora_inicio as Hora, Artista.nome as Artista, palco_zona as Zona, palco_num as Palco
FROM Atua JOIN Artista
WHERE Atua.artista = Artista.id
ORDER BY Dia