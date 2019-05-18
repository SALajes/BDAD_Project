.mode columns
.headers ON
.nullvalue NULL

SELECT (Patrocinios + Rendas + Bilhetes - Artistas - Funcionarios) as Profit
FROM (SELECT SUM(Artista.salario) as Artistas
      FROM Atua JOIN Artista
      WHERE Atua.artista = Artista.id),
     (SELECT SUM(Func1.salario) + SUM(Func2.salario) as Funcionarios
      FROM EncarregueArtista JOIN Funcionario as Func1 JOIN EncarregueConvidado JOIN Funcionario as Func2
      WHERE EncarregueArtista.funcionario = Func1.id AND EncarregueConvidado.funcionario = Func2.id),
     (SELECT SUM(Patrocinador.patrocinio) as Patrocinios
      FROM Entidade JOIN Patrocinador
      WHERE Entidade.id = Patrocinador.entidade),
     (SELECT SUM(Banca.renda) as Rendas
      FROM Banca),
     (SELECT SUM(TipoBilhete.custo) as Bilhetes
      FROM Tem JOIN TipoBilhete
      WHERE Tem.bilhete = TipoBilhete.id)