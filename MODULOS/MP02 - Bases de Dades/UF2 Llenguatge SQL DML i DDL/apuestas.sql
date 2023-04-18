create database apuestas;
use apuestas;

CREATE TABLE carrera (
  CodCarrera CHAR(4) ,
  Fecha DATETIME ,
  Nombre VARCHAR(20) ,
  ImportePremio NUMERIC(6) ,
  ApuestaLimite NUMERIC(7,2) ,
  PRIMARY KEY (CodCarrera)
);

CREATE TABLE Participaciones (
  CodCaballo CHAR(4) ,
  CodCarrera CHAR(4) ,
  Dorsal NUMERIC(2),
  Jockey VARCHAR(10) ,
  PosicionFinal NUMERIC(2),
  PRIMARY KEY (CodCaballo, CodCarrera)
);

CREATE TABLE Apuestas (
  DNICliente VARCHAR(10),
  CodCaballo CHAR(4),
  CodCarrera CHAR(4) ,
  Importe NUMERIC(6) ,
  Tantoporuno NUMERIC(6,2),
  PRIMARY KEY (DNICliente, CodCaballo, CodCarrera)
  );
  
/*Realiza un trigger que impida hacer una apuesta si el caballo no participa en la carrera correspondiente, 
además debe controlar que el importe apostado no supere el límite fijado para dicha carrera.*/

	DELIMITER //
CREATE TRIGGER apuesta_1 BEFORE INSERT ON client FOR EACH ROW
BEGIN
	if((new.Importe>(select ApuestaLimite from carrerra where CodCarrera = new.CodCarrera)) or 
	   (new.CodCaballo not in (select CodCaballo from Participaciones where CodCarrera=new.CodCarrera))) then
			CALL RAISE_APPLICATION_ERROR("ERROR");
	end if;
END//
	DELIMITER ;

/*Realizar un trigger para que actualice automáticamente el importe premio de una carrera dependiendo la suma total de los importes apostados.*/

	DELIMITER //
CREATE TRIGGER premi AFTER INSERT ON client FOR EACH ROW
BEGIN
	update carreras set ImportePremio=ImportePremio+new.importe 
		where CodCarrera=new.CodCarrera;
end;//
	DELIMITER ;

/*Realiza un disparador que impida dar de alta un Jockey en una participación de carrera si este ya participa en esa misma carrera o en otra que difiera menos de 2 horas.*/
	
    	DELIMITER //
CREATE TRIGGER Jockey BEFORE INSERT ON participacions FOR EACH ROW
BEGIN
    if (new.Jockey in(select Jockey from participacions where CodCarrera=new.CodCarrera))
	then
			CALL RAISE_APPLICATION_ERROR("ERROR");
    else if (new.Jockey in(select p.Jockey from participacions p, carrera c where (p.CodCarrera=c.CodCarrera)
			 and DATE(new.FechaHora)=date(FechaHora) and (time(FechaHora)>=addtime(Time(new.FechaHora), '02:00:00')) 
             and (time(FechaHora)<=addtime(Time(new.FechaHora), '02:00:00')))); 
    	then
			CALL RAISE_APPLICATION_ERROR("ERROR");
	end if;
END//
	DELIMITER ;
    
    

DELIMITER //
CREATE TRIGGER nuevoAlumno AFTER INSERT ON alumnes FOR EACH ROW
BEGIN 
	insert into login (codi, nom)
    values (new.codi, lower(concat(left(nom,2),left(cognom,2),new.codi)));
  END//
	DELIMITER ;  

    