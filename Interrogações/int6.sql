.mode columns
.headers ON
.nullvalue NULL

SELECT Data, (M + N) as Adquiridos, (Z + W) as Activados
FROM (SELECT TipoBilhete.nome as Tipo, TipoBilhete.data_inicio as Data, TipoBilhete.acampamento as Acampamento, COUNT(DISTINCT Tem.codigo) as M, COUNT(DISTINCT Ativados.codigo) as Z
     FROM Tem JOIN TipoBilhete JOIN Tem as Ativados
     WHERE Tem.bilhete = TipoBilhete.id AND Tem.bilhete = Ativados.bilhete AND Ativados.ativado = 1 AND TipoBilhete.nome = "Diario"
     GROUP BY TipoBilhete.data_inicio), 
     (SELECT COUNT(DISTINCT Tem.codigo) as N, COUNT(DISTINCT Ativados.codigo) as W
     FROM Tem JOIN TipoBilhete JOIN Tem as Ativados
     WHERE Tem.bilhete = TipoBilhete.id AND Tem.bilhete = Ativados.bilhete AND Ativados.ativado = 1 AND TipoBilhete.nome != "Diario")
GROUP BY Tipo
HAVING MAX(Adquiridos)