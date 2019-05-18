.mode columns
.headers ON
.nullvalue NULL

SELECT Funcionario.nome as Funcionario, Artista.nome as Artista, Agente.nome as Agente, Agente.telemovel as Telemovel, Agente.email as Email
FROM EncarregueArtista JOIN Artista JOIN Funcionario JOIN Agente
WHERE EncarregueArtista.artista = Artista.id AND EncarregueArtista.funcionario = Funcionario.id AND Artista.agente = Agente.id
ORDER BY Funcionario.nome