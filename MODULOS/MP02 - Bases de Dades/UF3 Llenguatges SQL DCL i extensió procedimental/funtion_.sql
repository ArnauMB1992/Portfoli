create database funcions;
use funcions;
set global log_bin_trust_function_creators=1;
/*Utilitzem la base de dades funcions.
	Exercici DCL_47:
Crea una funció anomenada apte que retorni el valor 'apte' si escrivim una nota que és superior a 5 i 'no apte' en cas contrari.
Exemple d'execució: apte(6)*/
DELIMITER //
CREATE FUNCTION apte(nota INT) RETURNS VARCHAR(10)
BEGIN
    IF nota >= 5 THEN
        RETURN 'apte';
    ELSE
        RETURN 'no apte';
    END IF;
END//
DELIMITER ;
select apte(5); 

/*Exercici DCL_48:
Crea una funció anomenada torn que segons l'hora que li introduïm ens digui torn de 'matí' (si és una hora entre les 8 i les 15) o 
torn de 'tarda' (si és una hora entre les 15 i les 22). En cas que no sigui cap d'aquest que escrigui un guió '-'.
Exemple d'execució: torn(18)*/
DELIMITER //
CREATE FUNCTION torn(hora INT) RETURNS VARCHAR(10)
BEGIN
    IF hora >= 8 AND hora <= 15 THEN
        RETURN 'matí';
    ELSEIF hora >= 15 AND hora <= 22 THEN
        RETURN 'tarda';
    ELSE
        RETURN '-';
    END IF;
END //
DELIMITER ; 
drop function torn;
/*show function;*/
select torn(18);

/*Exercici DCL_49:
Crea una funció anomenada alumne de manera que retorni el nom i el cognom concatenats en el mateix camp. 
Exemple d'execució: alumne('Pere','Plaza')*/
DELIMITER //
CREATE FUNCTION alumne(nom VARCHAR(50), cognom VARCHAR(50)) RETURNS VARCHAR(100)
BEGIN
    DECLARE nom_cognom VARCHAR(100);
    SET nom_cognom = CONCAT(nom, ' ', cognom);
    RETURN nom_cognom;
END//
DELIMITER ;
select alumne('Pere','Plaza');

/*Exercici DCL_50:
Crea una funció anomenada matricula de manera que retorni el valor de la matrícula en euros si nosaltres li donem en dòlars. 
Exemple d'execució: matricula(100.23)*/
DELIMITER //
CREATE FUNCTION matricula(dolars FLOAT) RETURNS FLOAT
BEGIN
    DECLARE euros FLOAT;
    SET euros = dolars * 0.91;
    RETURN euros;
END//
DELIMITER ;
select matricula(100.21);

/*Exercici DCL_51:
Crea una funció anomenada absolut de manera que sumi dos valors en valor absolut. 
Exemple d'execució: absolut(100,-150)*/
DELIMITER //
CREATE FUNCTION absolut(x FLOAT, y FLOAT) RETURNS FLOAT
BEGIN
    DECLARE suma FLOAT;
    SET suma = ABS(x) + ABS(y);
    RETURN suma;
END//
DELIMITER ;
select absolut(100,-150);

/*Exercici DCL_52:
Crea una funció anomenada iva de manera que calculi el preu amb IVA de la matrícula si nosaltres li donem sense IVA. 
Exemple d'execució: iva(100.23)*/
DELIMITER //
CREATE FUNCTION iva(preu_sense_iva FLOAT) RETURNS FLOAT
BEGIN
    DECLARE preu_amb_iva FLOAT;
    SET preu_amb_iva = preu_sense_iva * 1.21;
    RETURN preu_amb_iva;
END//
DELIMITER ;
select iva(100.00);

/*Exercici DCL_53:
Crea una funció anomenada edat de manera que calculi l'edat d'un individu. La data de naixement la donarem en 3 paràmetres: dia, mes i any. 
Exemple d'execució: edat(19,3,1982)*/
DELIMITER //
CREATE FUNCTION edat(dia_naixement INT, mes_naixement INT, any_naixement INT) RETURNS INT
BEGIN
    DECLARE data_actual DATE;
    DECLARE edat INT;
    SET data_actual = CURDATE();
    SET edat = YEAR(data_actual) - any_naixement;
    IF (MONTH(data_actual) < mes_naixement OR (MONTH(data_actual) = mes_naixement AND DAY(data_actual) < dia_naixement)) THEN
        SET edat = edat - 1;
    END IF;
    RETURN edat;
END//
DELIMITER ;
select edat(07,10,1992);

/*EX_F1. (2’5 punts) Implementeu una funció sobre la base de dades Tauler que rebi els identificadors de dues figures situades al
tauler. Caldrà consultar la situació de cadascuna de les figures (coordenades horitzontals i verticals) i generar una sortida que
indiqui les passes a seguir per a què la primera figura es desplaci fins on està la segona.*/

CREATE DATABASE Tauler;
use tauler;
# Creeu la taula
CREATE TABLE situacio (
idFigura INT PRIMARY KEY,
xCoord INT,
yCoord INT
) ENGINE=INNODB;

 # Inseriu les dades
 INSERT INTO situacio VALUES (1, 3, 5);
 INSERT INTO situacio VALUES (2, 3, 7);
 INSERT INTO situacio VALUES (3, 5, 4);
 
 drop function funcio_moure;
DELIMITER //
CREATE FUNCTION funcio_moure(figura1 INT, figura2 INT)
RETURNS VARCHAR(100)
BEGIN
    DECLARE pases VARCHAR(100);
    DECLARE x1, y1, x2, y2 INT;
    SELECT xCoord, yCoord INTO x1, y1 FROM situacio WHERE idFigura = figura1;
    SELECT xCoord, yCoord INTO x2, y2 FROM situacio WHERE idFigura = figura2;
    SET pases = 'Pases: ';
    IF x1 < x2 THEN
        SET pases = CONCAT(pases, x2 - x1, ' dreta ');
    ELSEIF x1 > x2 THEN
        SET pases = CONCAT(pases, x1 - x2, ' esquerra ');
    END IF;
    IF y1 < y2 THEN
        SET pases = CONCAT(pases, y2 - y1, ' baixar');
    ELSEIF y1 > y2 THEN
        SET pases = CONCAT(pases, y1 - y2, ' pujar');
    END IF;
    
    RETURN pases;
END//
DELIMITER ;

/*Exemple:/*
SELECT funcio_moure(1,2);
/*Genera -> Pases: 2 baixar/*
SELECT funcio_moure(1,3);
/*Genera -> Pases: 2 dreta 1 pujar*/

SELECT funcio_moure(1,2);
SELECT funcio_moure(1,3);
SELECT funcio_moure(2,3);
SELECT funcio_moure(2,1);
SELECT funcio_moure(3,1);
SELECT funcio_moure(3,2);

/*EX_F2. (2’5 punts) Una empresa codifica les seves oficines amb les tres primeres lletres de la ciutat en majúscules i un nombre de
tres xifres (que pot ser des de 000 a 999). Fixa't que tots els codis tindran una longitud de sis caràcters: tres lletres i tres xifres.
Crea la funció que ho codifica (aquesta funció haurà de controlar abans de generar el codi que no poden haver-hi 2 oficines amb
el mateix codi).
Exemple:
codi('Barcelona'), per exemple ens proposarà un codi 'BAR003'.*/

CREATE TABLE oficinas (
  ciudad VARCHAR(255) NOT NULL,
  codi VARCHAR(6) NOT NULL UNIQUE,
  PRIMARY KEY (codi)
);
select * from oficinas;
 drop function codi;

DELIMITER //
CREATE FUNCTION codi(ciudad VARCHAR(255))
RETURNS VARCHAR(6)
BEGIN
  DECLARE prefix VARCHAR(3);
  DECLARE suffix INT;
  DECLARE codi VARCHAR(6);
  SET prefix = UPPER(LEFT(ciudad, 3));
  -- buscar el màxim sufix utilitzat per a aquest prefix
  SELECT MAX(SUBSTRING(codi, 4)) INTO suffix
  FROM oficinas
  WHERE SUBSTRING(codi, 1, 3) = prefix;
  IF suffix IS NULL THEN
    SET suffix = 0;
  END IF;
  -- generar el codi complet, assegurant que tingui 3 xifres amb zeros a l'esquerra
  SET codi = CONCAT(prefix, LPAD(suffix + 1, 3, '0'));
  -- comprovar si el codi ja existeix a la taula d'oficines
  WHILE EXISTS(SELECT 1 FROM oficinas WHERE codi = codi) DO
    -- si ja existeix, incrementar el sufix i generar un nou codi
    SET suffix = suffix + 1;
    SET codi = CONCAT(prefix, LPAD(suffix + 1, 3, '0'));
  END WHILE;
  -- inserir el nou codi a la taula d'oficines
  INSERT INTO oficinas (ciudad, codi) VALUES (ciudad, codi);
  RETURN codi;
END //
DELIMITER ;

SELECT codi('Barcelona');
SELECT codi('Madrid');

/*EX_F3. (5 punts) Aprofiteu la pròpia BD creada a la pràctica final de les UF1 i 2 i definiu:
 2 funcions.
 2 procediments.
Aquestes funcions /procediments hauran de:
 Tindre utilitat respecte la funcionalitat de la base de dades.
 Utilitzar estructures de control (bifurcacions, bucles, …)
 Utilitzar alguna funció pròpia del MySQL. */