.mode columns

SELECT * FROM Convidado;

INSERT INTO Participante (id,nome,nif,nacionalidade) VALUES (2002,"Test Participant",471026511,40);
INSERT INTO Convidado (participante,tipo,entidade) values(11,3,15);
INSERT INTO Convidado (participante,tipo,entidade) values(131,3,15);
INSERT INTO Convidado (participante,tipo,entidade) values(2002,2,8);

SELECT * FROM Convidado;
