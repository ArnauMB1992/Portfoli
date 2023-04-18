CREATE DATABASE taller;
USE taller;
    create table client
   (codi_client int, 
	DNI	 char(9),
    nom		char(20),
    cognoms char(20),
    direccio	char(20),
    ciutat	char(20),
    telefon	int,
    email	char(20),
    data_naixement 	date,
	PRIMARY KEY (codi_client)
    );
       create table seccio
   (codi	 int,
    nom		char(20),
	PRIMARY KEY (codi)
    );
          create table empleat
   (codi	 int(4),
    nom		char(15),
    cognoms char(30),
    direccio char (20),
    codi_seccio	int,
    data_contracte	date,
	PRIMARY KEY (codi),
    FOREIGN KEY (codi_seccio) REFERENCES seccio (codi) ON UPDATE CASCADE
    );
          CREATE TABLE vehicle
   (codi		  int,
   matricula      char(7),
   marca           CHAR(10) ,
   modelo	       CHAR(10),
   color	  	   CHAR(10),
   año	 		   int(4),
   codi_client int,
   FOREIGN KEY (codi_client) REFERENCES client(codi_client) ON UPDATE CASCADE,
   PRIMARY KEY (codi)
   );
             CREATE TABLE part_feina
   (codi		  int,
   data_inici      date,
   data_final      date ,
   descripcio      CHAR(25),
   codi_seccio 	   int,
   codi_vehicle		int,
   codi_empleat		int,
   FOREIGN KEY (codi_seccio) REFERENCES seccio (codi) ON UPDATE CASCADE,
   FOREIGN KEY (codi_vehicle) REFERENCES vehicle (codi) ON UPDATE CASCADE,
   FOREIGN KEY (codi_empleat) REFERENCES empleat(codi) ON UPDATE CASCADE,
   PRIMARY KEY (codi)
   );
          create table recanvi
   (nserie	 int,
    tipo	char(10),
    fabricant 	char(10),
    part_feina	int,
	FOREIGN KEY (part_feina) REFERENCES part_feina (codi) ON UPDATE CASCADE,
    PRIMARY KEY (nserie)
    );
alter table empleat add nss int unique not null after codi;  
alter table empleat add dni char(9) unique not null after nss;  
alter table vehicle CHANGE modelo model char(10);
alter table vehicle CHANGE año any int(4);
alter table empleat add sou DECIMAL(4,2) default 0;
alter table part_feina rename part_de_feina;
alter table part_de_feina modify codi int(8); 
alter table empleat modify codi int(4); 
alter table vehicle modify matricula char(7) unique; 
alter table recanvi CHANGE tipo tipus char(10);
alter table client drop data_naixement;
select * from seccio;
INSERT INTO client VALUES ('01','45884870L','Arnau','Muñoz','av. pintor mir','Terrassa','639222986','am@gmail.com');
INSERT INTO client VALUES ('02','45884871L','Leyre','Barrero','av. pintor mir','Terrassa','639222987','lb@gmail.com');
INSERT INTO client VALUES ('03','45884872L','Alicia','Perez','calle sierra nevada','Terrassa','639222988','ap@gmail.com');
INSERT INTO client VALUES ('04','45884873L','Pedro','Pacheco','calle font vella','Terrassa','639222989','pp@gmail.com');
INSERT INTO client VALUES ('05','45884874L','Saray','Vidaña','calle navarcles','Terrassa','639222990','sv@gmail.com');
INSERT INTO seccio VALUES ('01','Carroceria');
INSERT INTO seccio VALUES ('02','Mecanica');
INSERT INTO seccio VALUES ('03','Pintura');
INSERT INTO empleat VALUES ('01','1234','45884870L','Arnau','Muñoz','av. pintor mir','01','2012-05-03','10.00');
INSERT INTO empleat VALUES ('02','1235','45884860L','Angel','Gaitan','calle mot perdut','02','2012-05-03','10.00');
INSERT INTO empleat VALUES ('03','1236','45884850L','Anselmo','Gutierrez','av. jaime 1','03','2012-05-03','10.00');
INSERT INTO vehicle VALUES ('01','1234MNB','Ford','Kuga','Blanco','2017','01');
INSERT INTO vehicle VALUES ('02','1236KBL','Seat','Leon','Negro','2021','01');
INSERT INTO vehicle VALUES ('03','1598LOI','Seat','Ibiza','Azul','2015','02');
INSERT INTO vehicle VALUES ('04','1478YUI','Mini','Cooper','Azul','2018','03');
INSERT INTO vehicle VALUES ('05','3654TRE','BMW','325','Azul','2003','04');
INSERT INTO vehicle VALUES ('06','1258GFD','Dacia','Sandero','Azul','2000','05');
INSERT INTO part_de_feina VALUES ('01','2022-05-03','2022-11-11','Cambio parachoques','01','02','01');
INSERT INTO part_de_feina VALUES ('02','2022-03-05','2022-10-07','Culata','02','02','02');
INSERT INTO part_de_feina VALUES ('03','2022-02-01','2022-05-03','Cambio color','03','04','03');
INSERT INTO recanvi VALUES ('01','parachoque','Seat','01');
INSERT INTO recanvi VALUES ('02','Culata','Seat','02');
alter table empleat modify sou DECIMAL(8,2);
update empleat set sou=sou*100;
update seccio set nom=UPPER(nom);
update seccio set codi=5 where codi=1;

/* Creació de 10 consultes SQL (enunciat i Query):
No podran ser consultes a sols una taula.
Caldrà que tinguin sentit amb la temàtica de la vostra BBDD.
Mínim: 2 subconsulta, 2 agrupada, 1 union. */

/*1.Enumerar els clients per ciutat:*/
SELECT ciutat, COUNT(*) as num_clients
FROM client
GROUP BY ciutat;

/*2.Mostrar el nom, cognoms i salari dels empleats ordenats per salari:*/
SELECT nom, cognoms, sou
FROM empleat
ORDER BY sou DESC;

/*3.Mostrar el nom i cognoms dels empleats que són responsables de les tasques d'un vehicle específic: */
SELECT empleat.nom, empleat.cognoms
FROM empleat
JOIN part_de_feina ON empleat.codi = part_de_feina.codi_empleat
WHERE part_de_feina.codi_vehicle = 1;


/* 4.Mostrar els clients que tenen almenys un vehicle associat: */
SELECT client.nom, client.cognoms
FROM client
JOIN vehicle ON client.codi_client = vehicle.codi_client
GROUP BY client.nom, client.cognoms;

/* 5.Mostrar el nom de la secció i el nombre d'empleats que hi treballen: */
SELECT seccio.nom, COUNT(empleat.codi) as num_empleats
FROM seccio
JOIN empleat ON seccio.codi = empleat.codi_seccio
GROUP BY seccio.nom;

/* 6.Mostrar les dades dels vehicles que han estat reparats per una secció específica: */
SELECT vehicle.matricula, vehicle.marca, vehicle.model, vehicle.color, vehicle.any
FROM vehicle
JOIN part_de_feina ON vehicle.codi = part_de_feina.codi_vehicle
WHERE part_de_feina.codi_seccio =1;

/* 7.Mostrar les dades dels clients que tenen vehicles amb matrícula similar a una matrícula específica: */
SELECT client.nom, client.cognoms, client.telefon
FROM client
JOIN vehicle ON client.codi_client = vehicle.codi_client
WHERE vehicle.matricula LIKE 'X%';

/* 8.Mostrar els recanvis utilitzats en les tasques realitzades per un empleat específic: */
SELECT recanvi.tipus
FROM recanvi
JOIN part_de_feina ON recanvi.part_feina = part_de_feina.codi
WHERE part_de_feina.codi_empleat = 1;

/* 9.Mostrar les dades dels empleats que treballen en seccions diferents a una secció específica: */
SELECT empleat.nom, empleat.cognoms, empleat.telefon
FROM empleat
WHERE empleat.codi_seccio = 1;

/* 10.Mostrar el nom i cognoms dels empleats junts amb el nom i cognoms dels clients associats a les seves tasques: */
SELECT empleat.nom, empleat.cognoms, client.nom, client.cognoms
FROM empleat
JOIN part_de_feina ON empleat.codi = part_de_feina.codi_empleat
JOIN vehicle ON part_de_feina.codi_vehicle = vehicle.codi
JOIN client ON vehicle.codi_client = client.codi_client;

/* 11.Mostrar el nom i cognoms dels empleats que han realitzat tasques per un vehicle específic: */
SELECT empleat.nom, empleat.cognoms
FROM empleat
WHERE empleat.codi IN (SELECT part_de_feina.codi_empleat
				FROM part_de_feina
                WHERE part_de_feina.codi_vehicle = 1);
                       
/* 12.Mostrar el nom i cognoms dels clients que tenen vehicles reparats per una secció específica: */
SELECT client.nom, client.cognoms
FROM client
WHERE client.codi_client IN (SELECT vehicle.codi_client
		FROM vehicle
		JOIN part_de_feina ON vehicle.codi = part_de_feina.codi_vehicle);

/* 13.Mostrar la quantitat de tasques realitzades per cada secció: */
SELECT seccio.nom, COUNT(part_feina.codi) as num_tasques
FROM seccio
JOIN part_feina ON seccio.codi = part_feina.codi_seccio
GROUP BY seccio.nom;

/* 14.Mostrar la quantitat de vehicles per cada marca: */
SELECT marca, COUNT(codi) as num_vehicles
FROM vehicle
GROUP BY marca;

/* 15.Mostrar el nom i cognoms dels empleats i els clients junts: */
SELECT nom, cognoms
FROM empleat
UNION
SELECT nom, cognoms
FROM client;

