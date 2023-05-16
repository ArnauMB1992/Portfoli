CREATE TABLE Alumne(
CodiAlum INT PRIMARY KEY,
Nom VARCHAR(30)
);
CREATE TABLE Assignatura(
CodiAssig VARCHAR(3) PRIMARY KEY,
Nom VARCHAR(20)
);
CREATE TABLE Examen(
CodiExam INT PRIMARY KEY,
CodiAssig VARCHAR(3),
CodiAlum INT,
Nota INT,
FOREIGN KEY (CodiAlum) REFERENCES Alumne (CodiAlum) ON UPDATE CASCADE,
FOREIGN KEY (CodiAssig) REFERENCES Assignatura (CodiAssig) ON UPDATE CASCADE
);
CREATE TABLE Expedient(
CodiAssig VARCHAR(3),
CodiAlum INT,
Convocatories INT,
PRIMARY KEY (CodiAssig, CodiAlum),
FOREIGN KEY (CodiAlum) REFERENCES Alumne (CodiAlum) ON UPDATE CASCADE,
FOREIGN KEY (CodiAssig) REFERENCES Assignatura (CodiAssig) ON UPDATE CASCADE
);
/*LES TAULES HAN D’ESTAR RELACIONADES (Foreign key)
1. (3’5 punts) Creeu un disparador per controlar que un alumne, abans de presentar-se a un
Examen, no tingui aquesta assignatura ja aprovada, i a més a més, que no hagi exhaurit les
convocatòries per assignatura (màxim 4).*/
DELIMITER //
CREATE TRIGGER controlNotaConvocatorias before insert ON examen
FOR EACH ROW	
BEGIN
	if (new.CodiAlum in(select CodiAlum from Examen where Nota < 5) and 
    (select CodiAlum from Expedient where Convocatories < 4 ) ) then
	insert into Examen (CodiExam, CodiAssig, CodiAlum) values (new.CodiExam, new.CodiAssig, new.CodiAlum);
end if;
END//
	DELIMITER ;

/*2. (5’5 punts) Creeu els disparadors (insert i delete) perquè un cop un alumne aprovi una
assignatura, s’actualitzi a la taula Expedient.*/

DELIMITER //
CREATE TRIGGER actuExpedientInsert after insert ON examen
FOR EACH ROW	
BEGIN
	if (new.CodiAlum in(select CodiAlum from Examen where Nota > 5))then
		insert into Expedient values (new.CodiAssig, new.CodiAlum , new.Convocatories);
end if;
END//
	DELIMITER ;

DELIMITER //
CREATE TRIGGER actuExpedientDelete after delete ON examen
FOR EACH ROW	
BEGIN
	if (delete new.CodiExam, new.CodiAssig, new.CodiAlum from examen) then
		delete old.CodiAssig, old.CodiAlum , old.Convocatories from Expedient where old.CodiAlum=new.CodiAlum ;
end if;
END//
	DELIMITER ;

/*3. (1 punt) Per cadascun dels disparadors creats als exercicis 1 i 2, indica quines instruccions
has executat per comprovar que funcionen correctament.*/

-- 1 
insert into Examen  (CodiExam, CodiAssig, CodiAlum) values (1,ABC,1);

-- 2.a con insert, se activaria el disaparador actuExpedientInsert
insert into Examen values (1,ABC,1,10);

-- 2.b con insert, se activaria el disaparador actuExpedientDelete
delete Examen values (1,ABC,1,10);
