CREATE TRIGGER DefineRenda
AFTER INSERT ON Banca
Begin 
UPDATE Banca SET renda = New.area * (SELECT custo_m2 FROM Zona WHERE id = New.id) WHERE id = New.id;
End
