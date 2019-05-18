.mode columns
.headers ON
.nullvalue NULL

SELECT Genero.nome as Genero, Nacionalidade.nome as Nacionalidade, COUNT(Nacionalidade.id) as Occurences
FROM GENERO JOIN Artista JOIN Nacionalidade
WHERE Genero.id = Artista.genero AND Nacionalidade.id = Artista.nacionalidade
GROUP BY Genero.nome