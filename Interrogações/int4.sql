.mode columns
.headers ON
.nullvalue NULL

SELECT Artista.nome as Artista, Funcionario.nome as Funcionario, Nacionalidade.nome as Nacionalidade
FROM Artista JOIN (SELECT Agente.id as AgenteID
                  FROM Artista JOIN Agente
                  WHERE Artista.agente = Agente.id
                  GROUP BY Agente.id
                  HAVING COUNT(Artista.nome) > 1
                  ORDER BY Agente.id)
             JOIN EncarregueArtista
             JOIN Funcionario
             JOIN Nacionalidade
WHERE Artista.agente = AgenteID
      AND Artista.id = EncarregueArtista.artista
      AND Funcionario.id = EncarregueArtista.funcionario
      AND Artista.nacionalidade = Funcionario.nacionalidade
      AND Artista.nacionalidade = Nacionalidade.id
ORDER BY Artista.nome
