.mode columns
.headers ON
.nullvalue NULL

SELECT Banca.nome as Banca, Banca.area as Area, Banca.zona as Zona, Classificacao.tipo as Tipo, Entidade.nome as Entidade
FROM Classificacao JOIN Banca JOIN Entidade
WHERE Classificacao.id = Banca.classificacao AND Entidade.id = Banca.entidade