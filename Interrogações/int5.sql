.mode columns
.headers ON
.nullvalue NULL

SELECT TipoBilhete.nome as Tipo, TipoBilhete.data_inicio as Data, TipoBilhete.acampamento as Acampamento, COUNT(DISTINCT Tem.codigo) as Adquiridos, COUNT(DISTINCT Ativados.codigo) as Ativados
FROM Tem JOIN TipoBilhete JOIN Tem as Ativados
WHERE Tem.bilhete = TipoBilhete.id AND Tem.bilhete = Ativados.bilhete AND Ativados.ativado = 1
GROUP BY Tem.bilhete