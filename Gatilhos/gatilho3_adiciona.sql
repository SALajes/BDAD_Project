PRAGMA foreign_keys = ON;

Create Trigger DefineConvidado
Before Insert On Convidado
For Each Row
When EXISTS(SELECT * FROM Normal WHERE participante = New.participante)
Begin Select raise(abort, "Participante ja definido como Normal");
End
