PRAGMA foreign_keys = ON;

Create Trigger VerificaArea
Before Insert On Banca
For Each Row
When (New.Area + (SELECT SUM(Area) FROM Banca WHERE New.zona = zona)) > (SELECT Area FROM Zona Where codigo = New.zona)
Begin Select raise(abort, "Area demasiado grande para a Zona");
End
