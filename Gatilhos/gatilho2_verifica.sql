CREATE TRIGGER UpdateZona
INSTEAD OF UPDATE ON Banca
INSERT INTO Banca values (New.id, New.nome, New.area, New.zona, New.Area * New.zona.custo_m2 , New.classificacao, New.entidade)