CREATE DATABASE exemple_disparador;
use exemple_disparador;
CREATE TABLE prova (codi INT);
CREATE TABLE suma (suma INT);
CREATE TABLE suma_text (suma VARCHAR(200));

/*Exercici 52:
Crea un disparador que quan fem una inserció a la taula prova deixi només l'últim registre introduït a
la taula suma.*/
DELIMITER //
CREATE TRIGGER ex52 AFTER INSERT ON prova
FOR EACH ROW
BEGIN
  DELETE FROM suma;
  INSERT INTO suma values(NEW.codi);
END //
DELIMITER ;

/*Exercici 53:
Crea els disparadors que compti els registres de la taula prova, tant si inserim com si esborrem.*/
DELIMITER //
CREATE TRIGGER ex53 AFTER INSERT ON prova
FOR EACH ROW
BEGIN
  DELETE FROM suma;
  INSERT INTO suma values((SELECT count(*) FROM prova));
END //

CREATE TRIGGER ex53_b AFTER INSERT ON prova
FOR EACH ROW
BEGIN
  if((select count(*) from suma)=0) 
  then insert suma values((SELECT count(*) FROM prova));
  else update suma set suma = (SELECT count(*) FROM prova);
end if;
END  //


CREATE TRIGGER ex53_c AFTER delete ON prova
FOR EACH ROW
BEGIN
  if((select count(*) from prova)=0) 
  then delete from suma ;
  else update suma set suma = (SELECT count(*) FROM prova);
end if;
END  //
DELIMITER ;

/*Exercici 54:
Crea un disparador que cada vegada que inserim un registre a la taula prova, introdueixi el valor a la
taula suma_text amb el signe + davant. Així si ha la taula prova tenim els valors 1, 2 i 3, a la taula
suma hi haurà un camp que serà 1+2+3.*/
DELIMITER //
CREATE TRIGGER ex54 before INSERT ON prova
FOR EACH ROW
BEGIN
  if((select count(*)from prova) = 0)then
  insert into suma_text values(new.codi);
  else 
	UPDATE suma_text SET suma = CONCAT(sum, '+', NEW.codi);
end if;
END //
DELIMITER ;

/*Exercici 55:
Creem una taula anomenada prova_log que té tres camps (hora i data, usuari, acció).
Crea un disparador que faci un registre de tots els canvis que fem a la taula prova, tant sigui inserir,
esborrar o modificar.
Així si fem un camp canvi escriuria:
2012/05/16 16:04:23 root@localhost Inserció 3
2012/05/16 16:08:12 root@localhost Eliminació 3
2012/05/16 16:09:15 carles@localhost Canvi 4>3*/
DELIMITER //
CREATE TRIGGER ex55_insert AFTER INSERT ON prova FOR EACH ROW
BEGIN
  INSERT INTO prova_log (hora_y_fecha, usuario, accion)
  VALUES (NOW(), USER(), CONCAT('Inserción ', NEW.codi));
END //

CREATE TRIGGER ex55_delete AFTER DELETE ON prova FOR EACH ROW
BEGIN
  INSERT INTO prova_log (hora_y_fecha, usuario, accion)
  VALUES (NOW(), USER(), CONCAT('Eliminación ', OLD.codi));
END //

CREATE TRIGGER ex55_update AFTER UPDATE ON prova FOR EACH ROW
BEGIN
  INSERT INTO prova_log (hora_y_fecha, usuario, accion)
  VALUES (NOW(), USER(), CONCAT('Canvi ', OLD.codi, '>', NEW.codi));
END //
DELIMITER ;

/*Exercici 56:
Suposem que els valors introduïts a la taula prova només poden ser valors de 1 a 10. Crea una taula
anomenada suma_valors amb dos camps (codi i vegades) que comptarà les vegades que surt el codi
a la taula prova. Crea el disparador que faci el recompte per valors del 1 al 10.*/
CREATE TABLE suma_valors (codigo INT, veces INT);
DELIMITER //
CREATE TRIGGER ex56 AFTER INSERT ON prova
FOR EACH ROW	
BEGIN
    IF((select count(*)from suma_valors where codi=NEW.codi)=0) then 
    insert into suma_valors values (NEW.codi, (select count(*) from prova where codi = NEW.codi));
    else 
    update suma_valors set vegades=(select count(*) from prova where codi=new.codi) where codi=new.codi;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER ex56_b AFTER delete ON prova
FOR EACH ROW	
BEGIN
    IF((select count(*)from prova where codi=NEW.codi)=0) then 
    delete from suma_valors where codi = old.codi;
    else 
    update suma_valors set vegades=(select count(*) from prova where codi=old.codi) where codi=old.codi;
    END IF;
END //
DELIMITER ;

/*Exercici 57:
Crea un disparador que només mantingui a la taula suma els 10 últims registres de la taula prova.*/
DELIMITER //
CREATE TRIGGER ex57 AFTER insert ON prova
FOR EACH ROW	
BEGIN
	insert into suma values(new.codi);
    IF((select count(*)from suma)>10) then 
    delete from suma limit 1;
    END IF;
END //
DELIMITER ;

/*Exercici 58:
Crea una taula prova_puntuacio amb dos camps (un camp lletra que serà A, B, C, D o E, un valor
numèric anomenat puntuacio que serà un enter de 1 a 10).
Crea un disparador posi en una taula anomenada prova_puntuacio_seg l'últim valor de cada lletra
introduït i la seva puntuació (pensa que a la taula prova_puntuació_seg sempre hi haurà 5 registres
que seran l'últim registre de cada lletra introduït).*/
CREATE TABLE prova_puntuacio (letra CHAR(1), puntuacion INT);
CREATE TABLE prova_puntuacio_seg (letra CHAR(1), puntuacion INT);
DELIMITER //
CREATE TRIGGER Ex58 AFTER INSERT ON prova_puntuacio
FOR EACH ROW
BEGIN
	if ((select count(*) from prova_puntuacio_seg where letra = new.letra)=0) then
		INSERT INTO prova_puntuacio_seg VALUES (NEW.letra, NEW.puntuacion);
    else if (NEW.puntuacion<>(select ultima_puntuacio from prova_puntuacio_seg where letra = new.letra))then 
			 update prova_puntuacio_seg set ultima_puntuacio = new.puntuacio where  letra = new.letra;
		end if;
	end if;
END //
DELIMITER ;

/*Exercici 59:
Crea un disparador de manera que a prova_puntuacio_seg compti les puntuacions total per cada
lletra (hi haurà 5 registres amb la puntuació total de cadascuna)*/

DELIMITER //
CREATE TRIGGER ex59 AFTER INSERT ON prova_puntuacio FOR EACH ROW
BEGIN
	if ((select count(*) from prova_puntuacio_seg where letra = new.letra)=0) then
		INSERT INTO prova_puntuacio_seg VALUES (NEW.letra,(select count(*) from prova_puntuacio where letra = new.letra) );
    else
		update prova_puntuacio_seg set ultima_puntuacio = (select count(*) from prova_puntuacio where letra = new.letra) 
        where letra = new.letra;
    END IF;
END //
DELIMITER ;
