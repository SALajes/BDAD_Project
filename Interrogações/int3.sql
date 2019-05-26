.mode columns
.headers ON
.nullvalue NULL

SELECT DISTINCT Participante.nome as Nome, Participante.nif as NIF, Tem.codigo as Bilhete, Entidade.nome as Entidade, Patrocinador.patrocinio as Patrocinio
FROM Participante JOIN Convidado JOIN Entidade JOIN Patrocinador JOIN Banca JOIN Tem
WHERE Participante.id = Convidado.participante 
      AND Convidado.entidade = Entidade.id 
      AND Patrocinador.entidade = Entidade.id 
      AND Patrocinador.patrocinio >= 200000
      AND Banca.entidade = Entidade.id
      AND Tem.participante = Participante.id 
      AND Tem.ativado = 1
GROUP BY Participante.nome
HAVING COUNT(Banca.id) > 1
ORDER BY Entidade.nome