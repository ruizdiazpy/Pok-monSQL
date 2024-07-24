
CREATE TABLE public.Pokemon (
                codigo INTEGER NOT NULL,
                Nombre VARCHAR NOT NULL,
                Tipo VARCHAR NOT NULL,
                Habilidad VARCHAR(20),
                Ataque INTEGER,
                Defensa INTEGER,
                Salud INTEGER,
                CONSTRAINT pokemon_pk PRIMARY KEY (codigo)
);


CREATE SEQUENCE public.entrenador_identrenador_seq;

CREATE TABLE public.Entrenador (
                id INTEGER NOT NULL DEFAULT nextval('public.entrenador_identrenador_seq'),
                Nombre VARCHAR NOT NULL,
                Ciudad VARCHAR(20),
                Edad INTEGER,
                CONSTRAINT entrenador_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.entrenador_identrenador_seq OWNED BY public.Entrenador.id;

CREATE SEQUENCE public.batalla_idbatalla_seq;

CREATE TABLE public.Batalla (
                idBatalla INTEGER NOT NULL DEFAULT nextval('public.batalla_idbatalla_seq'),
                Fecha DATE,
                Jugador1 INTEGER NOT NULL,
                Jugador2 INTEGER NOT NULL,
                Pokemon1 INTEGER NOT NULL,
                Pokemon2 INTEGER NOT NULL,
                Ganador INTEGER NOT NULL,
                CONSTRAINT batalla_pk PRIMARY KEY (idBatalla)
);


ALTER SEQUENCE public.batalla_idbatalla_seq OWNED BY public.Batalla.idBatalla;

CREATE TABLE public.Entrenador_Pokemon (
                id INTEGER NOT NULL,
                codigo INTEGER NOT NULL
);


ALTER TABLE public.Entrenador_Pokemon ADD CONSTRAINT pokemon_entrenador_pokemon_fk
FOREIGN KEY (codigo)
REFERENCES public.Pokemon (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Batalla ADD CONSTRAINT pokemon_batalla_fk
FOREIGN KEY (Pokemon1)
REFERENCES public.Pokemon (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Batalla ADD CONSTRAINT pokemon_batalla_fk1
FOREIGN KEY (Pokemon2)
REFERENCES public.Pokemon (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Entrenador_Pokemon ADD CONSTRAINT entrenador_entrenador_pokemon_fk
FOREIGN KEY (id)
REFERENCES public.Entrenador (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Batalla ADD CONSTRAINT entrenador_batalla_fk
FOREIGN KEY (Jugador1)
REFERENCES public.Entrenador (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Batalla ADD CONSTRAINT entrenador_batalla_fk1
FOREIGN KEY (Jugador2)
REFERENCES public.Entrenador (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Batalla ADD CONSTRAINT entrenador_batalla_fk2
FOREIGN KEY (Ganador)
REFERENCES public.Entrenador (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
