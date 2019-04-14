DROP TABLE IF EXISTS Acompanha;
DROP TABLE IF EXISTS Agente;
DROP TABLE IF EXISTS Artista;
DROP TABLE IF EXISTS Atua;
DROP TABLE IF EXISTS Banca;
DROP TABLE IF EXISTS Classificacao;
DROP TABLE IF EXISTS Concerto;
DROP TABLE IF EXISTS Convidado;
DROP TABLE IF EXISTS EncarregueArtista;
DROP TABLE IF EXISTS EncarregueConvidado;
DROP TABLE IF EXISTS Entidade;
DROP TABLE IF EXISTS Especialidade;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Genero;
DROP TABLE IF EXISTS Nacionalidade;
DROP TABLE IF EXISTS Normal;
DROP TABLE IF EXISTS Palco;
DROP TABLE IF EXISTS Participante;
DROP TABLE IF EXISTS Patrocinador;
DROP TABLE IF EXISTS Tem;
DROP TABLE IF EXISTS Tipo;
DROP TABLE IF EXISTS TipoBilhete;
DROP TABLE IF EXISTS Trabalha;
DROP TABLE IF EXISTS Zona;

CREATE TABLE Acompanha (
    menor  INTEGER REFERENCES Normal (participante)
                   ON DELETE CASCADE
                   ON UPDATE CASCADE
                   PRIMARY KEY
                   NOT NULL,
    adulto INTEGER REFERENCES Normal (participante) 
                   ON DELETE RESTRICT
                   ON UPDATE CASCADE
                   NOT NULL
);

CREATE TABLE Agente (
    id        INTEGER PRIMARY KEY AUTOINCREMENT
                      NOT NULL,
    nome      TEXT    NOT NULL,
    telemovel INTEGER UNIQUE
                      NOT NULL
                      CHECK (telemovel > 99999999999 AND 
                             telemovel < 1000000000000),
    email     TEXT    UNIQUE
                      NOT NULL
);

CREATE TABLE Artista (
    id            INTEGER PRIMARY KEY
                          NOT NULL,
    nome          TEXT    NOT NULL
                          UNIQUE,
    salario       DOUBLE  CHECK (salario >= 0),
    agente        INTEGER REFERENCES Agente (id) ON DELETE RESTRICT
                                                 ON UPDATE CASCADE
                                                 NOT NULL,
    genero        INTEGER REFERENCES Genero (id) ON DELETE RESTRICT
                                                 ON UPDATE CASCADE
                                                 NOT NULL,
    nacionalidade INTEGER REFERENCES Nacionalidade (id) ON DELETE RESTRICT
                                                        ON UPDATE CASCADE
                                                        NOT NULL
);

CREATE TABLE Atua (
    artista     INTEGER  REFERENCES Artista (ID),
    hora_inicio TEXT     NOT NULL,
    data        DATE     NOT NULL,
    palcoNum    INTEGER  NOT NULL,
    palcoZona   INTEGER  NOT NULL,

    FOREIGN KEY (
        hora_inicio,
        data,
        palcoNum,
        palcoZona
    ) REFERENCES Concerto (hora_inicio,data,palcoNum,palcoZona)
      ON DELETE RESTRICT
      ON UPDATE CASCADE,

    PRIMARY KEY (
        artista,
        hora_inicio,
        data,
        palcoNum,
        palcoZona
    ),

    UNIQUE (
        artista,
        hora_inicio,
        data
    )
);

CREATE TABLE Banca (
    id            INTEGER PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
    nome          TEXT    UNIQUE
                          NOT NULL,
    area          DOUBLE  NOT NULL
                          CHECK (area > 0),
    zona          INTEGER REFERENCES Zona (codigo) 
                          ON DELETE RESTRICT
                          ON UPDATE CASCADE
                          NOT NULL,
    renda         DOUBLE  NOT NULL,
    classificacao INTEGER REFERENCES Classificacao (id) 
                          ON DELETE RESTRICT
                          ON UPDATE CASCADE
                          NOT NULL,
    entidade      INTEGER REFERENCES Entidade (id) 
                          ON DELETE RESTRICT
                          ON UPDATE CASCADE
                          NOT NULL
);

CREATE TABLE Classificacao (
    id   INTEGER PRIMARY KEY AUTOINCREMENT
                 NOT NULL,
    tipo TEXT    UNIQUE
                 NOT NULL
);

CREATE TABLE Concerto (
    hora_inicio TEXT    NOT NULL,
    hora_fim    TEXT    NOT NULL,
    data        DATE    NOT NULL,
    palcoNum    INTEGER NOT NULL,
    palcoZona   INTEGER NOT NULL,
    PRIMARY KEY (
        hora_inicio DESC,
        data DESC,
        palcoNum,
        palcoZona
    ),
    FOREIGN KEY (
        palcoNum,
        palcoZona
    ) REFERENCES Palco (num, zona)
      ON DELETE RESTRICT
      ON UPDATE CASCADE
);

CREATE TABLE Convidado (
    participante INTEGER PRIMARY KEY
                         REFERENCES Participante (id) 
                         ON DELETE RESTRICT
                         ON UPDATE CASCADE
                         NOT NULL,
    tipo         INTEGER REFERENCES Tipo (id) 
                         ON DELETE RESTRICT
                         ON UPDATE CASCADE
                         NOT NULL,
    entidade     INTEGER REFERENCES Entidade (id)
                         ON DELETE SET NULL
                         ON UPDATE CASCADE
);

CREATE TABLE EncarregueArtista (
    artista     INTEGER  REFERENCES Artista (id) 
                         ON DELETE RESTRICT
                         ON UPDATE CASCADE
                         NOT NULL,
    funcionario INTEGER  REFERENCES Funcionario (id) 
                         ON DELETE RESTRICT
                         ON UPDATE CASCADE
                         NOT NULL,
    PRIMARY KEY (
        artista,
        funcionario
    )
);

CREATE TABLE EncarregueConvidado (
    convidado   INTEGER  REFERENCES Convidado (participante) 
                         ON DELETE RESTRICT
                         ON UPDATE CASCADE
                         NOT NULL,
    funcionario INTEGER  REFERENCES Funcionario (id) 
                         ON DELETE RESTRICT
                         ON UPDATE CASCADE
                         NOT NULL,
    PRIMARY KEY (
        convidado,
        funcionario
    )
);

CREATE TABLE Entidade (
    id        INTEGER PRIMARY KEY AUTOINCREMENT
                      NOT NULL,
    nome      TEXT    NOT NULL
                      UNIQUE,
    telemovel INTEGER UNIQUE
                      NOT NULL
                      CHECK (telemovel > 99999999999 AND 
                             telemovel < 1000000000000),
    email     TEXT    UNIQUE
                      NOT NULL
);

CREATE TABLE Especialidade (
    id   INTEGER  PRIMARY KEY AUTOINCREMENT
                  NOT NULL,
    nome TEXT     UNIQUE
                  NOT NULL
);

CREATE TABLE Funcionario (
    id            INTEGER PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
    nome          TEXT    NOT NULL,
    nif           INTEGER UNIQUE
                          NOT NULL
                          CHECK (nif > 99999999 AND 
                                 nif < 1000000000),
    morada        TEXT    NOT NULL,
    salario       DOUBLE  NOT NULL
                          CHECK (salario >= 0),
    especialidade INTEGER REFERENCES Especialidade (id) 
                          ON DELETE RESTRICT
                          ON UPDATE CASCADE
                          NOT NULL,
    nacionalidade INTEGER REFERENCES Nacionalidade (id) 
                          ON DELETE RESTRICT
                          ON UPDATE CASCADE
                          NOT NULL
);

CREATE TABLE Genero (
    id   INTEGER PRIMARY KEY AUTOINCREMENT
                 NOT NULL,
    nome TEXT    UNIQUE
                 NOT NULL
);

CREATE TABLE Nacionalidade (
    id INTEGER PRIMARY KEY AUTOINCREMENT
               NOT NULL,
    nome TEXT  UNIQUE
               NOT NULL
);

CREATE TABLE Normal (
    participante INTEGER REFERENCES Participante (id) 
                         ON DELETE CASCADE
                         ON UPDATE CASCADE
                         PRIMARY KEY
                         NOT NULL,
    menor_idade  INTEGER DEFAULT (0)
                         NOT NULL
                         CHECK (menor_idade == 0 OR 
                                menor_idade == 1)
);

CREATE TABLE Palco (
    num        INTEGER NOT NULL,
    capacidade INTEGER NOT NULL
                       CHECK (capacidade > 0),
    zona       INTEGER REFERENCES Zona (codigo) 
                       ON DELETE RESTRICT
                       ON UPDATE CASCADE
                       NOT NULL,
    PRIMARY KEY (
        num,
        zona
    )
);

CREATE TABLE Participante (
    id            INTEGER PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
    nome          TEXT    NOT NULL,
    nif           INTEGER UNIQUE
                          NOT NULL
                          CHECK (nif > 99999999 AND 
                                 nif < 1000000000),
    nacionalidade INTEGER REFERENCES Nacionalidade (id) 
                          ON DELETE RESTRICT
                          ON UPDATE CASCADE
                          NOT NULL
);

CREATE TABLE Patrocinador (
    id         INTEGER PRIMARY KEY AUTOINCREMENT
                       NOT NULL,
    patrocinio DOUBLE  NOT NULL
                       CHECK (patrocinio > 100),
    entidade   INTEGER REFERENCES Entidade (id) 
                       ON DELETE CASCADE
                       ON UPDATE CASCADE
                       NOT NULL
);

CREATE TABLE Tem (
    codigo       INTEGER NOT NULL
                         UNIQUE,
    ativado      INTEGER DEFAULT (0)
                         NOT NULL
                         CHECK (ativado == 0 OR 
                                ativado == 1),
    participante INTEGER REFERENCES Participante (id) 
                         ON DELETE CASCADE
                         ON UPDATE CASCADE
                         NOT NULL
                         PRIMARY KEY,
    bilhete      INTEGER REFERENCES TipoBilhete (id) 
                         ON DELETE CASCADE
                         ON UPDATE CASCADE
                         NOT NULL
);

CREATE TABLE Tipo (
    id   INTEGER PRIMARY KEY AUTOINCREMENT
                 NOT NULL,
    nome TEXT    UNIQUE
                 NOT NULL
);

CREATE TABLE TipoBilhete (
    id          INTEGER  PRIMARY KEY AUTOINCREMENT
                         NOT NULL,
    nome        TEXT     NOT NULL,
    data_inicio DATE     NOT NULL,
    data_fim    DATE     NOT NULL,
    acampamento INTEGER  DEFAULT (0)
                         NOT NULL
                         CHECK (acampamento == 0 OR 
                                acampamento == 1),
    custo       DOUBLE   NOT NULL
);

CREATE TABLE Trabalha (
    funcionario INTEGER REFERENCES Funcionario (id) 
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
                        NOT NULL,
    zona        INTEGER REFERENCES Zona (codigo) 
                        ON DELETE RESTRICT
                        ON UPDATE CASCADE
                        NOT NULL,
    PRIMARY KEY (
        funcionario,
        zona
    )
);

CREATE TABLE Zona (
    codigo   INTEGER PRIMARY KEY AUTOINCREMENT
                     NOT NULL,
    custo_m2 DOUBLE  NOT NULL,
    area     DOUBLE  NOT NULL
                     CHECK (area > 0) 
);
