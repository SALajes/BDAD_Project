.mode columns
.headers ON
.nullvalue NULL

SELECT Atua.data as Day, Artista.nome as Artist, MAX(Artista.salario) as "Highest Salary", AVG(Artista.salario) as "Average Salary"
FROM ATUA JOIN Artista
WHERE Atua.artista = Artista.id
GROUP BY Atua.data