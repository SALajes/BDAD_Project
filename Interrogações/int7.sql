.mode columns
.headers ON
.nullvalue NULL

SELECT ArtistasComApenasUmaAtuacao.Dia, ArtistasComApenasUmaAtuacao.Artista, ArtistasComApenasUmaAtuacao.Salario
FROM 
    (SELECT Atua.Data as Dia, Artista.nome as Artista, Palco.num as num, Palco.zona as zona, Artista.salario as Salario, Palco.capacidade as Capacidade
    From Atua JOIN Artista JOIN Palco
    WHERE Atua.artista = Artista.id
        AND Atua.palco_num = Palco.num
        AND Atua.palco_zona = Palco.Zona
    GROUP BY Atua.Data, Atua.artista
    HAVING (count(*) = 1)) as ArtistasComApenasUmaAtuacao
NATURAL JOIN
    (SELECT Atua.data as Dia, avg(Artista.salario) as MediaSalario
    FROM Atua JOIN Artista
    WHERE Atua.artista = Artista.id
    GROUP BY Atua.data) as MediaSalarioDia
NATURAL JOIN
    (SELECT Concerto.data as Dia, avg(Palco.capacidade) as MediaCapacidadeDia
    FROM Concerto JOIN Palco
    WHERE Concerto.palco_num = Palco.num
        AND Concerto.palco_zona = Palco.zona
    GROUP BY Concerto.data) AS PalcoCapacidadeMediaDia
WHERE ArtistasComApenasUmaAtuacao.Salario > MediaSalarioDia.MediaSalario
    AND ArtistasComApenasUmaAtuacao.capacidade > PalcoCapacidadeMediaDia.MediaCapacidadeDia
