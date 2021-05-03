CREATE OR REPLACE FUNCTION percetage(total INT) RETURNS INTEGER AS $$
DECLARE
n INTEGER;
pe NUMERIC;
BEGIN
SELECT COUNT(*) INTO n FROM youcoders where campus='Youssoufia' and classe = 'FEBE';

pe = (total * n)/100;
return pe;
END
$$ LANGUAGE plpgsql;

select percetage(200)

CREATE OR REPLACE FUNCTION stSameRef(student VARCHAR) RETURNS INTEGER AS $$
DECLARE
sClasse VARCHAR;
n INTEGER;

BEGIN
SELECT classe INTO sClasse FROM youcoders where full_name=student;

SELECT COUNT(*) INTO n FROM youcoders where classe=sClasse;




return n;
CREATE OR REPLACE PROCEDURE changeStatus()
LANGUAGE SQL
AS $$
UPDATE youcoders
SET is_accepted  = true
WHERE campus  = 'Youssoufia'
$$;

CALL changeStatus()

select * from youcoders

END
$$ LANGUAGE plpgsql;


select stSameRef('Zakaria zakaria')

CREATE OR REPLACE PROCEDURE updateClasse()
LANGUAGE SQL
AS $$
UPDATE youcoders
SET classe  = 'DATA BI'
WHERE nbr_competence=14 AND matricule LIKE '%2%'
$$;

CALL updateClasse()

select * from youcoders



CREATE OR REPLACE FUNCTION emp_stamp() RETURNS trigger AS $emp_stamp$
    BEGIN
       UPDATE youcoders SET is_accepted = false;
       RETURN NEW;
    END;
$emp_stamp$ LANGUAGE plpgsql;


CREATE TRIGGER emp_stamp AFTER INSERT  ON youcoders
    FOR EACH ROW EXECUTE FUNCTION emp_stamp();
	
	
	///
	
 //  part 2 update table
CREATE TABLE referentiel (
    id INTEGER PRIMARY KEY, 
	name VARCHAR(15) NOT NULL
);

--Creation de la table classe

CREATE TABLE classe (
    id INTEGER PRIMARY KEY, 
	name VARCHAR(15) NOT NULL
);

--Creation de la table campus

CREATE TABLE campus (
    id INTEGER PRIMARY KEY, 
	name VARCHAR(15) NOT NULL
);

--Insertion de donnée dans la table campus

INSERT INTO campus VALUES (1,'Safi');
INSERT INTO campus VALUES (2,'Youssoufia');

--Insertion de donnée dans la table classe


INSERT INTO classe VALUES (1,'FEBE');
INSERT INTO classe VALUES (2,'JEE');
INSERT INTO classe VALUES (3,'C#');
INSERT INTO classe VALUES (4,'PHP');

--Insertion de donnée dans la table referentiel


INSERT INTO referentiel VALUES (1,'CDA');
INSERT INTO referentiel VALUES (2,'DWWM');
INSERT INTO referentiel VALUES (3,'AI');

--Creation de la nouvelle table mycoders avec les freign key des autres tables

CREATE TABLE mycoders (
    matricule VARCHAR(4) PRIMARY KEY, 
	full_name VARCHAR(15) NOT NULL,
	campus_id INTEGER NOT NULL, 
	classe_id INTEGER NOT NULL, 
	referentiel_id INTEGER NOT NULL, 
	nbr_competence NUMERIC(5) DEFAULT 0, 
	is_accepted boolean,
    CONSTRAINT fk_campus
      FOREIGN KEY(campus_id) 
	  REFERENCES campus(id),
    CONSTRAINT fk_classe
      FOREIGN KEY(classe_id) 
	  REFERENCES classe(id),
    CONSTRAINT fk_referentiel
      FOREIGN KEY(referentiel_id) 
	  REFERENCES referentiel(id)
);

--Insertion de donnée dans la table mycoders

INSERT INTO mycoders VALUES ('P400','KAMAL BHF',2,1,1,14,true);
INSERT INTO mycoders VALUES ('P765','Mohammed ahmed',1,2,2,8,true);
INSERT INTO mycoders VALUES ('P122','Amine amine',1,3,1,14,false);
INSERT INTO mycoders VALUES ('P202','Yassine yassine',2,4,1,14,true);
INSERT INTO mycoders VALUES ('P980','Don Reda',1,2,2,8,false);
INSERT INTO mycoders VALUES ('P543','Salma Salma',2,3,3,10,true);
INSERT INTO mycoders VALUES ('P307','Zakaria zakaria',1,1,1,14,false);
INSERT INTO mycoders VALUES ('P199','Omar omar',1,2,3,10,false);
INSERT INTO mycoders VALUES ('P387','Houssam houssam',1,1,1,14,true);
INSERT INTO mycoders VALUES ('P566','Imane imane',2,1,1,14,true);

--Tester les references avec la jointure

select * from mycoders INNER JOIN classe ON mycoders.classe_id = classe.id
select * from mycoders INNER JOIN campus ON mycoders.campus_id = campus.id
select * from mycoders INNER JOIN referentiel ON mycoders.referentiel_id = referentiel.id

//// trigger choice
CREATE TABLE employees(
   id INT GENERATED ALWAYS AS IDENTITY,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE employee_audits (
   id INT GENERATED ALWAYS AS IDENTITY,
   employee_id INT NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   changed_on TIMESTAMP(6) NOT NULL
);

CREATE OR REPLACE FUNCTION log_last_name_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
	IF NEW.last_name <> OLD.last_name THEN
		 INSERT INTO employee_audits(employee_id,last_name,changed_on)
		 VALUES(OLD.id,OLD.last_name,now());
	END IF;

	RETURN NEW;
END;
$$
INSERT INTO employees (first_name, last_name)
VALUES ('John', 'Doe');

INSERT INTO employees (first_name, last_name)
VALUES ('Lily', 'Bush');
SELECT * FROM employees;