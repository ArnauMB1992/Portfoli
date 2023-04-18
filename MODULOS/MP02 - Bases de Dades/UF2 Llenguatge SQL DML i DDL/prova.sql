CREATE DATABASE prova;
USE prova;
drop database prova;
CREATE TABLE TREBALL
   (nom		CHAR(20),
   carrec	CHAR(50),
   edad		TINYINT ,
   PRIMARY KEY (nom)
   );
CREATE TABLE CIUTAT
   (nom             CHAR(25)       NOT NULL,
    comarca         CHAR(25)       NOT NULL,
    provincia       CHAR(25)       NOT NULL,
    habitants		int,
   PRIMARY KEY (nom)
   );
CREATE TABLE CLIENT
   (idclient           INTEGER        NOT NULL,
   nom             CHAR(20)       NOT NULL ,
   cognoms         CHAR(40),     
   data_naixement  DATE,
   tipus 			CHAR(20)		 DEFAULT 'Habitual',
   PRIMARY KEY (idclient)
   );
CREATE TABLE DEPARTAMENT
   (numero           TINYINT(2),
   nom             CHAR(9) NOT NULL UNIQUE,
   localizacion         CHAR(10),
   PRIMARY KEY (numero)
   );
   CREATE TABLE DEPARTAMENT2
   (numero_departament           TINYINT(2),
   numero           TINYINT(2),
   nom             CHAR(9) NOT NULL UNIQUE,
   localizacion         CHAR(10),
   PRIMARY KEY (numero_departament)
   );
   CREATE TABLE PRODUCTE
   (codi           INTEGER,
   nom             CHAR ,
   descripcio      CHAR,
   categoria  	   CHAR,
   preu 		   DECIMAL,
   PRIMARY KEY (codi)
   );
   CREATE TABLE FABRICANT
   (codi           INTEGER,
   nom             CHAR(20) ,
   direccion_web      CHAR(20),
   telefon  	   INTEGER,
   PRIMARY KEY (codi)
   );
   drop table PRODUCTE;
      CREATE TABLE PRODUCTE
   (codi           INTEGER,
   nom             CHAR(20) ,
   descripcio      CHAR(20),
   categoria  	   CHAR(20),
   preu 		   DECIMAL,
   codi_fabricant int,
   FOREIGN KEY (codi_fabricant) REFERENCES FABRICANT(codi),
   PRIMARY KEY (codi)
   );
	create table assignatua
    (codi           CHAR(3) NOT NULL UNIQUE  ,
   nom             CHAR(20) ,
   cicle      CHAR(20),
   curs  	   CHAR(20),
   PRIMARY KEY (codi)
   );
  use prova;
  create table PROFESOR
    (codi		INTEGER,
   nom             CHAR(20) ,
   cognom      CHAR(20),
   naixement	DATE,
   direccio  	   CHAR(20),
   telefon  	   INTEGER,
   asignatura	CHAR(3) ,
   FOREIGN KEY (asignatura) REFERENCES assignatua(codi),
   PRIMARY KEY (codi)
   );
    create table ALUMNE
    (codi		INTEGER,
   nom             CHAR(20) ,
   cognom      CHAR(20),
   naixement	DATE,
   direccio  	   CHAR(20),
   telefon  	   INTEGER,
   asignatura	CHAR(3) ,
   matricula 	date,
   FOREIGN KEY (asignatura) REFERENCES assignatua(codi),
   PRIMARY KEY (codi)
   );
  
  