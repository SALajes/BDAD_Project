.mode columns
.headers ON
.nullvalue NULL

SELECT Concertos.Dia, count(*) as NumPalcos
FROM
    (SELECT DISTINCT Concerto.data as Dia, Concerto.palco_num as PalcoNum, Concerto.palco_zona as PalcoZona
    FROM Concerto) as Concertos
GROUP BY Concertos.Dia
HAVING (NumPalcos > (SELECT count(*)
                    FROM Palco))
