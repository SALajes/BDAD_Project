.mode columns
.headers ON
.nullvalue NULL

SELECT DISTINCT Participante1.nome as Menor, Participante1.codigo as Bilhete_Menor, Participante2.nome as Adulto, Participante2.codigo as Bilhete_Maior
FROM Acompanha JOIN (Normal NATURAL JOIN Participante NATURAL JOIN Tem) as Participante1 
               JOIN (Normal NATURAL JOIN Participante NATURAL JOIN Tem) as Participante2
WHERE Acompanha.menor = Participante1.id 
      AND Acompanha.adulto = Participante2.id 
      AND Participante1.id = Participante1.participante
      AND Participante2.id = Participante2.participante