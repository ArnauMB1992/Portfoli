CREATE DATABASE practica3;
USE practica3;

CREATE TABLE alumne
(codi INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(20) NOT NULL,
cognom VARCHAR(20) NOT NULL,
data_naixement DATE,
edat INT
);

INSERT INTO alumne VALUES (NULL,'Guillem','Homet','1992/12/20',NULL);
INSERT INTO alumne VALUES (NULL,'Marta','Ros','1993/01/21',NULL);
INSERT INTO alumne VALUES (NULL,'Miquel','Rodríguez','1990/10/11',NULL);

CREATE TABLE professor
(codi INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(20) NOT NULL,
cognom VARCHAR(20) NOT NULL,
data_naixement DATE,
edat INT
);

INSERT INTO professor VALUES (NULL,'Núria','Ribas','1985/10/06',NULL);
INSERT INTO professor VALUES (NULL,'Carles','Pujol','1978/06/14',NULL);

/*Exercici DCL_18:
Crea un procediment anomenat cerca que busqui tots els alumnes que el seu cognom la cadena que indiquem.
Exemple d'execució: CALL cerca('R%');*/
DELIMITER //
CREATE PROCEDURE buscar(IN valor VARCHAR(20))
BEGIN
    SELECT nom FROM alumne WHERE cognom LIKE valor;
END //
DELIMITER ;

call buscar('R%'); 

/*Exercici DCL_19:
Crea un procediment que busqui els professors per nom i cognom. Tingueu en compte que si deixem algun dels dos paràmetres buits cerqui pels altres.
Exemple d'execució: CALL cerca2(NULL,'Ribas');*/
DELIMITER //
CREATE PROCEDURE cerca2(IN nom2 VARCHAR(20),IN cognom2 VARCHAR(20))
BEGIN
	IF(nom2 is null and cognom2 is null) then
		select * from professor;
    else if (nom2 is not null and cognom2 is null) then
		SELECT * FROM professor WHERE nom LIKE nom2;
    else if (nom2 is null and cognom2 is not null) then
		SELECT * FROM professor WHERE cognom LIKE cognom2;
    else 
		select * from professor where nom like nom2 and cognom like cognom2;
end if;
end if;
end if;
END //
DELIMITER ;
drop procedure cerca2;

CALL cerca2(NULL,'Ribas');

/*Exercici DCL_20:
Crea un procediment que incrementi el valor del codi de la taula professor en un valor que nosaltres li indiquem.
Exemple d'execució: CALL actualitza(20);*/
DELIMITER //
CREATE PROCEDURE actualitza(IN valor int)
BEGIN
   UPDATE professor
   SET codi = codi + valor;
END //
DELIMITER ;

CALL actualitza(20);
select * from professor;

/* que lo haga solo en 1 profesor*/
DELIMITER //
CREATE PROCEDURE actualitza2(IN valor int, IN nom2 VARCHAR(20),IN cognom2 VARCHAR(20) )
BEGIN
   UPDATE professor
   SET codi = codi + valor
   where nom like nom2 and cognom like cognom2 ;
END //
DELIMITER ;

CALL actualitza2(10,'Nuria','Ribas');
select * from professor;
/*ahora que sea en un intervalo de profesores*/
DELIMITER //
CREATE PROCEDURE actualitza3(IN valor int, IN valorMin int, IN valorMax int)
BEGIN
	UPDATE professor
	SET codi = codi + valor
	where /*codi > valorMin and codi < valorMax*/ codi between valorMin and valorMax ;
END //
DELIMITER ;
drop procedure actualitza3;
CALL actualitza3(10,11,25);
select * from professor;


/*Exercici DCL_21:
Crea un procediment que donat un nom, un cognom, la data de naixement i si és professor o alumne, l'afegeixi a la taula corresponent. Si no, que no faci res.
Exemple d'execució: CALL inserir('Xavier','Vilà','1975/02/03','professor');*/
DELIMITER //
CREATE PROCEDURE inserir(IN nom2 VARCHAR(20),IN cognom2 VARCHAR(20), in data_naixement2 DATE, in tipus varchar(10))
BEGIN
	if(lower(tipus) = 'alumne') then 
		insert into alumne (nom, cognom, data_naixement) values(nom2, cognom2, data_naixement2); 
	else if (lower(tipus) = 'professor') then
		insert into alumne (nom, cognom, data_naixement) values(nom2, cognom2, data_naixement2); 
	else 
		select "ESCOGE BIEN LA OPCION";
end if;
end if;
END //
DELIMITER ;
drop procedure inserir;
 CALL inserir('Xavier','Vilà','1975/02/03','professor');
 select * from alumne;
 CALL inserir('Anselmo','Vilà','1975/02/03','professor');
 
/*Exercici DCL_22:
Crea un procediment que afegeixi la data de naixement als alumnes que no la tenen assignada o la tinguin malament. 
Per això li indicarem el codi de l'alumne i la data de naixement.
Exemple d'execució: CALL data_naixement(21,'1995/03/19');*/
DELIMITER //
CREATE PROCEDURE data_naixement(IN codi2 INT, in data_naixement2 DATE)
BEGIN
	update alumne set data_naixement = data_naixement2 where codi = codi2;
END //
DELIMITER ;      

CALL data_naixement(5,'1995/03/19');

/*Exercici DCL_23:
Crea un procediment que, donada la taula que li diem i el codi de la persona, calculi l'edat d'una persona a partir de la data de naixement.
Exemple d'execució: CALL edat('professor',20);*/
-- TIMESTAMPDIFF()


/*Exercici DCL_24:
Crea un procediment per elimini els registres de la taula alumnes que tenen el codi entre els dos que l'indicarem (inclosos).
Exemple d'execució: CALL elimina(20,22);*/

DELIMITER //
CREATE PROCEDURE elimina(IN codi2 INT, IN codi3 INT)
BEGIN
	if(codi2<codi3) then
		DELETE FROM alumne
		WHERE codi >= codi2 AND codi <= codi3;
    else 
		DELETE FROM alumnes
		WHERE codi >= codi3 AND codi <= codi2;
end if;
END //
DELIMITER ;

drop procedure elimina;
CALL elimina(20,22);

/*Volem crear una base de dades anomenada agenda que gestionarà l'agenda d'una dels treballadors. La taula
diari tindrà la següent estructura:
- El camp codi del tipus INT, que serà autonumèric i la clau.
- El camp data del tipus DATE.
- El camp hora del tipus HORA.
- El camp event del tipus VARCHAR(40).
Crea la base de dades agenda.*/

CREATE DATABASE agenda;
USE agenda;
CREATE TABLE diari (
  codi INT AUTO_INCREMENT PRIMARY KEY,
  data DATE,
  hora TIME,
  event VARCHAR(40)
);

/*Exercici 23:
Crea un procediment anomenat taula faci el següent:
- Si passem el paràmetre 'T', crei l'estructura de la taula diari.
- Si passem el paràmetre 'E', elimini la taula diari si existeix.
Exemple d'execució: CALL taula('T');*/

DELIMITER //
CREATE PROCEDURE taula (IN accio CHAR(1))
BEGIN
  IF (upper(accio) = 'T') THEN
    CREATE TABLE IF NOT EXISTS diari (
      codi INT AUTO_INCREMENT PRIMARY KEY,
      data DATE,
      hora TIME,
      event VARCHAR(40)
    );
  ELSE IF (upper(accio) = 'E') THEN
    DROP TABLE IF EXISTS diari;
  END IF;
  END IF;
END //
DELIMITER ;

CALL taula('t');
select * from diari;

/*Exercici 24:
Crea un procediment anomenat inser que faci insercions a la taula anterior.
Exemple d'execució: CALL inser('2011/05/25','12:00','Reunió de direcció');*/

DELIMITER //
CREATE PROCEDURE inser (IN data2 DATE, IN hora2 TIME, IN event2 VARCHAR(40))
BEGIN
  INSERT INTO diari (data, hora, event) VALUES (data2, hora2, event2);
END //
DELIMITER ;

CALL inser('2011/05/25','12:00','Reunió de direcció');
select * from diari;

/*Exercici 25:
Crea un procediment anomenat elim que elimini tots els registres entre dues dates. Si deixem la primera data en
blanc esborrarà tots els registres anteriors a la segona data, i si deixem la segona data en blanc esborrarà tots
els registres posteriors a la primera data. Sempre les dates que indiquem estan incloses.
Exemple d'execució: CALL elim(NULL,'2011/04/25');*/

DELIMITER //
CREATE PROCEDURE elim (IN data1 DATE, IN data2 DATE)
BEGIN
  IF data1 IS NULL THEN
    DELETE FROM diari WHERE data <= data2;
  ELSEIF data2 IS NULL THEN
    DELETE FROM diari WHERE data >= data1;
  ELSEIF data1<data2 then
    DELETE FROM diari WHERE data BETWEEN data1 AND data2;
  else 
	DELETE FROM diari WHERE data BETWEEN data2 AND data1;
  END IF;
END //
DELIMITER ;
drop procedure elim;
CALL elim(NULL,'2011/04/25');
select * from diari;

/*Exercici 26:
Crea un procediment anomenat posposar que, donada una data, endarrereixi l'esdeveniment un mes.
Exemple d'execució: CALL postposar('2011/04/25');*/

DELIMITER //
CREATE PROCEDURE posposar (IN data2 DATE)
BEGIN
  UPDATE diari SET data = DATE_ADD(data, INTERVAL 1 MONTH) WHERE data = data2;
END //
DELIMITER ;

CALL postposar('2011/04/25');

/*Exercici 27:
Crea un procediment anomenat dietari que donada una data ens digui i una opció ens apareguin tots els
esdeveniment de:
- si l'opció és A els esdeveniments del mateix dia de la data.
- si l'opció és B els esdeveniments de la setmana a que pertany la data.
- si l'opció és C els esdeveniments del mes a que pertany la data.
Exemple d'execució: CALL dietari('2011/05/25','A');*/

DELIMITER //
CREATE PROCEDURE dietari (IN data2 DATE, IN opcio CHAR(1))
BEGIN
  IF upper(opcio) = 'A' THEN
    SELECT hora, event FROM diari WHERE data = data2;
  ELSEIF upper(opcio) = 'B' THEN
    SELECT hora, event FROM diari WHERE YEARWEEK(data) = YEARWEEK(data2) and YEAR(data) = YEAR(data2);
  ELSEIF upper(opcio) = 'C' THEN
    SELECT hora, event FROM diari WHERE YEAR(data) = YEAR(data2) AND MONTH(data) = MONTH(data2);
  ELSE
    SELECT 'Opció no vàlida A/B/C' AS error;
  END IF;
END //
DELIMITER ;
CALL dietari('2011/05/25','A');

/*Exercici 28:
Crea un procediment anomenat inser_rep que faci insercions a la taula diari, de manera que inserirà un
esdeveniment repetit cada cert temps. Els paràmetres que li donarem seran els següents:
− Data d'inici de les insercions
− Data final de les insercions
− Hora de l'esdeveniment
− Esdeveniment
− Freqüència: D (diària), S (setmanal) i M (mensual)
Exemple d'execució:
Si volem inserir un esdeveniment que es repetirà mensualment farem:
CALL inser_rep('2011/05/25','2012/05/25','12:00','Reunió de direcció','M');*/

DELIMITER //
CREATE PROCEDURE inser_rep (IN data_inici DATE, IN data_final DATE, IN hora TIME, IN event VARCHAR(40), IN freq CHAR(1))
BEGIN
  WHILE data_inici <= data_final DO
    INSERT INTO diari (data, hora, event) VALUES (data_inici, hora, event);
    IF upper(freq) = 'D' THEN
      SET data_inici = ADDDATE(data_inici, INTERVAL 1 DAY);
    ELSEIF upper(freq) = 'S' THEN
      SET data_inici = ADDDATE(data_inici, INTERVAL 1 WEEK);
    ELSEIF upper(freq) = 'M' THEN
      SET data_inici = ADDDATE(data_inici, INTERVAL 1 MONTH);
    END IF;
  END WHILE;
END //
DELIMITER ;
CALL inser_rep('2011/05/25','2012/05/25','12:00','Reunió de direcció','M');