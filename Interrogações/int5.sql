.mode columns
.headers ON
.nullvalue NULL

CREATE VIEW IF NOT EXISTS BancasMaiorAreaPorClassificacao AS
SELECT Banca.nome as Banca, max(Banca.area) as Area, Classificacao.tipo as Tipo, Zona.codigo as Zona
FROM Banca JOIN Classificacao JOIN Zona
WHERE Banca.classificacao = Classificacao.id AND Banca.zona = Zona.codigo
GROUP BY Banca.classificacao;

CREATE VIEW IF NOT EXISTS BancasComPalcos AS
SELECT Banca, Area, Tipo, BancasMaiorAreaPorClassificacao.Zona
FROM BancasMaiorAreaPorClassificacao JOIN Palco
WHERE BancasMaiorAreaPorClassificacao.Zona = Palco.zona;


SELECT Banca, Area, Tipo, Zona, 'nao existem' as Palcos
FROM BancasMaiorAreaPorClassificacao
EXCEPT
SELECT *, 'nao existem' as Palcos
FROM BancasComPalcos
UNION
SELECT BancasMaiorAreaPorClassificacao.Banca as Banca, 
       BancasMaiorAreaPorClassificacao.Area as Area, 
       BancasMaiorAreaPorClassificacao.Tipo as Tipo, 
       BancasMaiorAreaPorClassificacao.Zona as Zona, 
       'existem' as Palcos
FROM BancasMaiorAreaPorClassificacao
    JOIN BancasComPalcos
WHERE BancasMaiorAreaPorClassificacao.Banca = BancasComPalcos.Banca
