-- Граждане Флатландии
CREATE TABLE citizen (
    id SERIAL,
    fullname character varying(256) NOT NULL,
    birth_date date NOT NULL,
	CONSTRAINT citizen_pk PRIMARY KEY (id)
);

-- Прививки
CREATE TABLE vaccination (
    id SERIAL,
    name character varying(256) NOT NULL,
	CONSTRAINT vaccination_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX vaccination_idx ON vaccination USING btree (name);

-- Иммунитеты
CREATE TABLE immunity (
    id SERIAL PRIMARY KEY
);

-- Болезни
CREATE TABLE disease (
    id SERIAL,
    name character varying NOT NULL,
    immunity_id integer,
	CONSTRAINT disease_pk PRIMARY KEY (id),
	CONSTRAINT immunity_id FOREIGN KEY (immunity_id) REFERENCES immunity(id) ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE UNIQUE INDEX diseases_idx ON disease USING btree (name);
CREATE INDEX fki_immunity_id ON disease USING btree (immunity_id);
COMMENT ON COLUMN disease.immunity_id IS 'Выбрал связь 1 ко многим, потому что предположил, что не бывает нескольких имунитетов от одной болезни.';

-- Какие граждане чем болеют
CREATE TABLE citizen_has_disease (
    record_id SERIAL,
    citizen_id integer NOT NULL,
    disease_id integer NOT NULL,
    begin_date date NOT NULL,
    end_date date NOT NULL,
    cause_death boolean DEFAULT false NOT NULL,
    CONSTRAINT begin_date CHECK ((begin_date < now())),
    CONSTRAINT end_date CHECK (((end_date >= begin_date) AND (end_date <= now()))),
	CONSTRAINT citizen_has_disease_pk PRIMARY KEY (record_id, citizen_id, disease_id),
	CONSTRAINT record_id UNIQUE (record_id),
	CONSTRAINT citizen_id FOREIGN KEY (citizen_id) REFERENCES citizen(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT disease_id FOREIGN KEY (disease_id) REFERENCES disease(id)
);
CREATE INDEX fki_citizen_id ON citizen_has_disease USING btree (citizen_id);
CREATE INDEX fki_disease_id ON citizen_has_disease USING btree (disease_id);

-- Какие граждане чем вакцинированы
CREATE TABLE citizen_vaccinated (
    record_id SERIAL,
    citizen_id integer NOT NULL,
    vaccination_id integer NOT NULL,
	CONSTRAINT citizen_vaccinated_pkey PRIMARY KEY (record_id, citizen_id, vaccination_id),
	CONSTRAINT citizen_vaccinated_record_id_key UNIQUE (record_id),
	CONSTRAINT citizen_vaccinated_citizen_id_fkey FOREIGN KEY (citizen_id) REFERENCES citizen(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT citizen_vaccinated_vacination_id_fkey FOREIGN KEY (vaccination_id) REFERENCES vaccination(id) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX fki_ ON citizen_vaccinated USING btree (vaccination_id);

-- Какие случаи заболеваний привели к появлению иммунитета
CREATE TABLE disease_gives_immunity (
    record_id integer NOT NULL,
    immunity_id integer NOT NULL,
	CONSTRAINT disease_gives_immunity_pk PRIMARY KEY (record_id, immunity_id),
	CONSTRAINT immunity_id2 FOREIGN KEY (immunity_id) REFERENCES immunity(id),
	CONSTRAINT record_id FOREIGN KEY (record_id) REFERENCES citizen_has_disease(record_id)
);
CREATE INDEX fki_immunity_id2 ON disease_gives_immunity USING btree (immunity_id);

-- От чего делается прививка должна работать
CREATE TABLE vaccination_from (
    vaccination_id integer NOT NULL,
    disease_id integer NOT NULL,
	CONSTRAINT vaccination_from_pk PRIMARY KEY (vaccination_id, disease_id),
	CONSTRAINT disease_id2 FOREIGN KEY (disease_id) REFERENCES disease(id),
	CONSTRAINT vaccination_id FOREIGN KEY (vaccination_id) REFERENCES vaccination(id)
);
CREATE INDEX fki_disease_id2 ON vaccination_from USING btree (disease_id);

-- Какие случаи вакцинации привели к появлению иммунитета
CREATE TABLE vaccination_gives_immunity (
    immunity_id integer NOT NULL,
    record_id integer NOT NULL,
	CONSTRAINT vaccination_gives_immunity_pkey PRIMARY KEY (record_id, immunity_id),
	CONSTRAINT immunity_id3 FOREIGN KEY (immunity_id) REFERENCES immunity(id),
	CONSTRAINT vaccination_gives_immunity_record_id_fkey FOREIGN KEY (record_id) REFERENCES citizen_vaccinated(record_id)
);
CREATE INDEX fki_immunity_id3 ON vaccination_gives_immunity USING btree (immunity_id);
