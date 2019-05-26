.mode columns
.headers ON
.nullvalue NULL

CREATE VIEW IF NOT EXISTS EncArtistaNomes AS
SELECT  EncarregueArtista.artista as ArtistaID, 
        Artista.nome as ArtistaNome,
        EncarregueArtista.funcionario as FuncionarioID,
        Funcionario.nome as FuncionarioNome
FROM EncarregueArtista JOIN Artista JOIN Funcionario
WHERE EncarregueArtista.artista = Artista.id
    AND EncarregueArtista.funcionario = Funcionario.id;


SELECT E1.FuncionarioNome as 'Funcionario 1', E2.FuncionarioNome as 'Funcionario 2', E1.ArtistaNome as Artista
FROM EncArtistaNomes E1 JOIN EncArtistaNomes E2
WHERE E1.ArtistaID = E2.ArtistaID
    AND E1.FuncionarioID < E2.FuncionarioID
ORDER BY E1.ArtistaNome
