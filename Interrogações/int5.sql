.mode columns
.headers ON
.nullvalue NULL

CREATE VIEW BancasMaiorAreaPorClassificacao AS
SELECT Banca.nome as BancaNome, max(Banca.area) as Area, Classificacao.tipo as BancaClassificacao, Zona.codigo as ZonaCod
FROM Banca JOIN Classificacao JOIN Zona
WHERE Banca.classificacao = Classificacao.id AND Banca.zona = Zona.codigo
GROUP BY Banca.classificacao;

SELECT *, 0
FROM BancasMaiorAreaPorClassificacao
WHERE NOT EXISTS (      SELECT * 
                        FROM BancasMaiorAreaPorClassificacao JOIN Palco
                        WHERE BancasMaiorAreaPorClassificacao.ZonaCod = Palco.zona)
UNION
SELECT *, 1
FROM BancasMaiorAreaPorClassificacao
WHERE EXISTS (  SELECT * 
                FROM BancasMaiorAreaPorClassificacao JOIN Palco
                WHERE BancasMaiorAreaPorClassificacao.ZonaCod = Palco.zona)
