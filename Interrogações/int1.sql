.mode columns
.headers ON
.nullvalue NULL

SELECT Concertos.Dia as Dia
FROM
    (SELECT DISTINCT Concerto.data as Dia, Concerto.palco_num as PalcoNum, Concerto.palco_zona as PalcoZona
    FROM Concerto) as Concertos
GROUP BY Concertos.Dia
HAVING (count(*) = (SELECT count(*)
                    FROM Palco))
