CREATE DATABASE examen3;
USE examen3;
CREATE TABLE cotxes (
id VARCHAR (7) PRIMARY KEY,
marca VARCHAR (15),
model VARCHAR (20),
venut_al_taller ENUM ('S', 'N')
);
CREATE TABLE pressupostos (
id INT PRIMARY KEY,
nif_client VARCHAR (9) NOT NULL,
id_cotxe VARCHAR (7) NOT NULL,
data_pressupost DATE NOT NULL,
cost_peces_recanvi INT DEFAULT 0,
hores_mecanic INT DEFAULT 0,
acceptat ENUM ('S', 'N') DEFAULT 'N',
FOREIGN KEY (id_cotxe) REFERENCES cotxes(id)
);
CREATE TABLE clients (
nif VARCHAR(9) PRIMARY KEY
);
CREATE TABLE factures (
id_factura INT PRIMARY KEY,
id_pressupost INT,
data_factura DATE,
preu_total INT,
pagada ENUM ('S', 'N'),
FOREIGN KEY (id_pressupost) REFERENCES pressupostos (id)
);
INSERT INTO cotxes (id,marca,model,venut_al_taller) VALUES ('1','SEAT', 'Ibiza', 'S');
INSERT INTO cotxes (id,marca,model,venut_al_taller) VALUES ('2','SEAT', 'Panda', 'N');
INSERT INTO cotxes (id,marca,model,venut_al_taller) VALUES ('3','Renault', 'Clio', 'N');
INSERT INTO pressupostos VALUES (1,'47752335L','1', '2021-05-13',0,0,'N');
INSERT INTO pressupostos VALUES (2,'47752315J','1', '2021-01-13',0,0,'S');
INSERT INTO pressupostos VALUES (3,'47752495X','1', '2020-02-15',50,0,'N');
INSERT INTO clients VALUES ('47752495X');
INSERT INTO clients VALUES ('2');
INSERT INTO clients VALUES ('3');
INSERT INTO factures VALUES (1,1,'2021-01-13',0,'N');
INSERT INTO factures VALUES (2,2,'2021-01-13',5,'N');
INSERT INTO factures VALUES (3,3,'2021-01-13',5,'N');

/*1.- Crea un procediment que donades dues dates ens mostri per pantalla tots els pressupostos
no acceptats entre aquelles dates.
Exemple d'execució: call pressupostosNoAcceptats(20/01/2021, 20/03/2021);*/
	
	if (data1<=data2) then
    select * from pressupostos where acceptat = 'N' and data_pressupost >= data1 and data_pressupost <= data2;
    elseif (data2<=data1) then
    select * from pressupostos where acceptat = 'N' and data_pressupost >= data2 and data_pressupost <= data1;
    end if;
END //
DELIMITER ;
drop procedure buscar;
call pressupostosNoAcceptats('2021-05-14', '2020-02-14');

/*2.-Crea un procediment que donada una data incrementi un 10% el preu total de totes les
factures anteriors a aquesta data.
Exemple d'execució: call impagats (15/02/2021);*/
DELIMITER //
CREATE PROCEDURE impagats(IN data date)
BEGIN
	update factures
    set preu_total = (preu_total*1.10)
    where data_factura < data;
END //
DELIMITER ;
drop procedure impagats;
call impagats ('2021-02-15');
select * from factures;

/*5.- Crea una funció que donat una id de pressupost ens retorni el preu total del pressupost
(inclou el cost de les peces de recanvi i el cost de les hores de mecànic, que es pagaran a
20€/h). A més a més si el cotxe s'ha comprat al taller se li aplicarà un 10% de descompte.
Exemple d'execució: preuTotal(2);*/

DELIMITER //
CREATE FUNCTION preuTotal(pressupost INT)
	RETURNS INT
BEGIN
	DECLARE matricula INT DEFAULT (SELECT id_cotxe FROM pressupostos WHERE id=pressupost);
	IF ((SELECT venut_al_taller FROM cotxes WHERE id=matricula) = 'S') THEN
		RETURN ((SELECT cost_peces_recanvi FROM pressupostos WHERE id=pressupost) + 
				(SELECT hores_mecanic FROM pressupostos WHERE id=pressupost)/10);
	ELSE
		RETURN ((SELECT cost_peces_recanvi FROM pressupostos WHERE id=pressupost) + 
				(SELECT hores_mecanic FROM pressupostos WHERE id=pressupost));
	END IF;
END //
DELIMITER ;
drop function preuTotal;
select preuTotal(3);
select * from pressupostos;

/*-------------------------------------------------------*/

CREATE TABLE Tabla_Departamento (
Num_Depart INT(2) PRIMARY KEY,
Nombre_Depart VARCHAR(15),
Ubicación VARCHAR(15),
Presupuesto DECIMAL(10,2),
Media_Salarios DECIMAL(10,2),
Total_Salarios DECIMAL(10,2));
 
CREATE TABLE Tabla_Empleado(
Num_Empleado INT(4) PRIMARY KEY,
Nombre_Empleado VARCHAR(25),
Categoría VARCHAR(10), -- Gerente, Comercial, …
Jefe INT(4),
Fecha_Contratacion DATE,
Salario DECIMAL(7,2),
Comision DECIMAL(7,2),
Num_Depart INT(2),
FOREIGN KEY (Jefe) REFERENCES Tabla_Empleado(Num_Empleado),
FOREIGN KEY (Num_Depart) REFERENCES Tabla_Departamento(Num_Depart));

/*Crea un procediment que donat un departament calculi el cost total dels salaris d'aquest departament (sumant els salaris dels empleats), 
en cas de què es sobrepassi el pressupost assignat al departament, haurà d'acomiadar als últims empleats contractats.*/

DELIMITER //
CREATE PROCEDURE calculSalari(IN departament INT(2))
BEGIN 
	declare totalSalarios DECIMAL(20,2);
    declare presupost DECIMAL(10,2);
    select sum(Salario) into totalSalarios from Tabla_Empleado where Num_Depart=departament;
    select presupost into presupost from Tabla_Departamento where  Num_Depart=departament;
     
     WHILE totalSalarios > presupost DO
     delete from Tabla_Empleado order by Fecha_Contratacion DESC limit 1;
    select sum(Salario) into totalSalarios from Tabla_Empleado where Num_Depart=departament;
    END WHILE;
    END //
DELIMITER ;

call calculSalari(1);

/*----------------------*/

CREATE TABLE EQUIP (
CodEquip VARCHAR(4) PRIMARY KEY,
Nom VARCHAR(30) NOT NULL,
Localitat VARCHAR(15));

CREATE TABLE PARTIT (
CodPartit VARCHAR(4) PRIMARY KEY,
CodEquipLocal VARCHAR(4),
CodEquipVisitant VARCHAR(4),
Data date,
Jornada  VARCHAR(20),
Gol_Local int,
Gol_Visitant int,
FOREIGN KEY (CodEquipLocal) REFERENCES EQUIP(CodEquip),
FOREIGN KEY (CodEquipVisitant) REFERENCES EQUIP(CodEquip));

/*Crea un procediment MostrarQuiniela que rebi una data i ens mostri els resultats dels partits jugats en aquesta data . 
El resultat ha d'aparèixer de la següent manera:
	CodEquipLocal – CodEquipVisitant: (1, X o 2)
L'1 serà quan l'equip 1 (local) hagi guanyat, la X quan sigui un empat i el 2 quan l'equip 2 (visitant) hagi guanyat.
S'ha de tractar la següent excepció:
No hi ha partits en aquesta jornada.*/

drop procedure MostrarQuiniela;

insert into EQUIP values ("TERR","Terrassa","Terrassa");
insert into EQUIP values ("SABD","Sabadell","Sabadell");
insert into EQUIP values ("CERD","Cerdañola","Cerdañola");
insert into EQUIP values ("VILA","Viladecavalls","Viladecavalls");
insert into PARTIT values ("uno","TERR","SABD",'2023-01-01',"uno",5,2);
insert into PARTIT values ("dos","CERD","VILA",'2023-01-01',"uno",1,2);

call MostrarQuiniela('2023-01-01');
call MostrarQuiniela('2023-01-01');

DELIMITER //
CREATE PROCEDURE MostrarQuiniela(IN data1 date)
BEGIN 
	select * from partit where Data=data1 ;
	if (select Gol_Local from partit where Data=data1)>(select Gol_Visitant from partit where Data=data1) THEN
    select concat((CodEquipLocal and CodEquipVisitant),': 1') from partit where Data=data1 ;
	elseif (select Gol_Local from partit where Data=data1)<(select Gol_Visitant from partit where Data=data1) THEN
    select concat((CodEquipLocal and CodEquipVisitant),': 2') from partit where Data=data1 ;
    elseif (select Gol_Local from partit where Data=data1)=(select Gol_Visitant from partit where Data=data1) THEN
    select concat((CodEquipLocal and CodEquipVisitant),': X') from partit where Data=data1;
    else
		SELECT 'No hi ha partits en aquesta jornada.' AS error; 
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE MostrarQuiniela(IN data_partit DATE)
BEGIN
    DECLARE num_partits INT;    
    -- Compta el nombre de partits jugats en la data especificada
    SELECT COUNT(*) INTO num_partits FROM PARTIT WHERE Data = data_partit;
    IF num_partits = 0 THEN
        SELECT 'No hi ha partits en aquesta data.';
    ELSE
        -- Mostra els resultats dels partits
        SELECT CONCAT(
            CodEquipLocal, ' - ', CodEquipVisitant, ': ',
            CASE
                WHEN Gol_Local > Gol_Visitant THEN '1'
                WHEN Gol_Local = Gol_Visitant THEN 'X'
                ELSE '2'
            END
        ) AS Resultat
        FROM PARTIT
        WHERE Data = data_partit;
    END IF;
END //
DELIMITER ;

DROP DATABASE IF EXISTS cromos;
CREATE DATABASE cromos;
USE cromos;
CREATE TABLE tema (
nom VARCHAR(15) PRIMARY KEY,
descripcio VARCHAR(250));

CREATE TABLE coleccio (
id_coleccio INT AUTO_INCREMENT PRIMARY KEY,
titol VARCHAR(20) NOT NULL,
nombre_cromos INT NOT NULL CHECK (nombre_cromos BETWEEN 20 AND 250),
cromos_completats INT,
cromos_totals INT,
tema VARCHAR(15) NOT NULL,
any_llançament INT NOT NULL,
data_subscripcio DATE NOT NULL,
finalitzada ENUM('S','N') NOT NULL DEFAULT 'N',
FOREIGN KEY (tema) REFERENCES tema(nom));

CREATE TABLE cromos (
coleccio INT,
numero_cromo INT,
quantitat INT NOT NULL,
PRIMARY KEY (coleccio, numero_cromo),
FOREIGN KEY (coleccio) REFERENCES coleccio(id_coleccio));

INSERT INTO tema VALUES('Animació','Còmics i dibuixos animats');
INSERT INTO tema VALUES('Esports','Lligues i esdeveniments esportius');
INSERT INTO tema VALUES('Natura','Plantes i animals');
INSERT INTO coleccio VALUES(null, 'Bola de Drac', 230, null, null, 'Animació', 2006, '2021/01/25', 'S');
INSERT INTO coleccio VALUES(null, 'Peppa Pig', 140, null, null,'Animació', 2015, '2018/06/15', 'N');
INSERT INTO coleccio VALUES(null, 'Asterix', 60, null, null, 'Animació', 2015, '2015/10/12', 'N');
INSERT INTO coleccio VALUES(null, 'Lliga2020', 215, null, null, 'Esports', 2020, '2020/01/15', 'N');
INSERT INTO coleccio VALUES(null, 'Lliga2019', 225, null, null, 'Esports', 2019, '2019/01/15', 'S');
INSERT INTO coleccio VALUES(null, 'Lliga2016', 188, null, null, 'Esports', 2016, '2016/01/15', 'N');
INSERT INTO coleccio VALUES(null, 'ACB', 145, null, null, 'Esports', 2021, '2021/02/01', 'N');
INSERT INTO coleccio VALUES(null, 'Dinosaures', 66, null, null, 'Natura', 2021, '2021/01/06', 'S');
INSERT INTO coleccio VALUES(null, 'WildAnimals', 200, null, null, 'Natura', 2018, '2019/05/15', 'N');
INSERT INTO coleccio VALUES(null, 'Peixos', 130, null, null, 'Natura', 2010, '2014/09/22', 'S');
INSERT INTO cromos VALUES(1,34,1);
INSERT INTO cromos VALUES(1,55,1);
INSERT INTO cromos VALUES(1,60,3);
INSERT INTO cromos VALUES(1,222,1);
INSERT INTO cromos VALUES(2,1,6);
INSERT INTO cromos VALUES(2,41,2);
INSERT INTO cromos VALUES(3,2,2);
INSERT INTO cromos VALUES(3,3,3);
INSERT INTO cromos VALUES(3,60,1);
INSERT INTO cromos VALUES(4,15,1);
INSERT INTO cromos VALUES(4,35,2);
INSERT INTO cromos VALUES(5,50,1);
INSERT INTO cromos VALUES(6,35,2);
INSERT INTO cromos VALUES(7,88,3);
INSERT INTO cromos VALUES(8,66,1);

/*1. Crea una funció anomenada cromosQueFalten que donada una col·lecció ens retorni el nombre de cromos
que falten per acabar aquella col·lecció. (No pots fer servir el camp coleccio.cromos_completats ja que no
sempre està actualitzat)
Exemple d'execució: cromosQueFalten('Bola de drac')*/

 /*declare idColeccion int;*/
/* select id_coleccio into idColeccion from coleccio where titol=coleccion;*/
DELIMITER //
CREATE procedure cromosQueFalten(in coleccion VARCHAR(30)) 
BEGIN
	declare cromosTotal int;
    declare cromosQueTengo int;
    declare idColeccion int;
    declare cromosQueFaltan int;
    set cromosQueFaltan =0;
    select cromos_totals into cromosTotal from coleccio where titol=coleccion;
    select id_coleccio into idColeccion from coleccio where titol=coleccion;
    select sum(quantitat) into cromosQueTengo from cromos where coleccio=idColeccion;
    set cromosQueFaltan = (cromosTotal-cromosQueTengo);
    select cromosTotal;
    
    END //
DELIMITER ;
  drop procedure cromosQueFalten;   
select cromosQueFalten("Bola de Drac")AS cromos_faltantes;

DELIMITER $$
CREATE FUNCTION cromosQueFalten(coleccion VARCHAR(20))
RETURNS INT
BEGIN
    DECLARE total_cromos INT;
    DECLARE cromos_existents INT;
    DECLARE cromos_faltants INT;

    -- Obtener el número total de cromos en la colección
    SELECT cromos_totals INTO total_cromos
    FROM coleccio
    WHERE titol = coleccion;

    -- Obtener la suma de la cantidad de cromos existentes en la colección
    SELECT SUM(quantitat) INTO cromos_existents
    FROM cromos
    INNER JOIN coleccio ON cromos.coleccio = coleccio.id_coleccio
    WHERE coleccio.titol = coleccion;

    -- Calcular el número de cromos que faltan
    SET cromos_faltants = total_cromos - cromos_existents;

    RETURN cromos_faltants;
END$$
DELIMITER ;

/*3. Crea un procediment que donat una col·lecció i un número de cromo el guardi a la nostra base de dades. Si
no el tenia es guardarà en una variable de sortida anomenada resultat 'Felicitats!! Has aconseguit el cromo
numeroCromo de la col·lecció nomColeccio'. Si ja el teníem a la variable resultat s'hi guardarà 'Ja tens
quantitatCromos del cromo numeroCromo de la col·lecció nomColeccio'. Si no pot existir aquest numero
de cromo al paràmetre resultat s'hi guardarà 'El cromo numeroCromo no pot pertànyer a la coleccio
nomColeccio'.
Exemple d'execució: CALL guardarCromo('Bola de drac', 45, @resultat)*/

DELIMITER //
CREATE PROCEDURE guardarCromo (IN coleccion varchar(20), in numeroCromo int)
BEGIN
	declare numColeccion int;
    declare siLoTengo int;
	declare cromosTotal int;
    set siLoTengo = 0;
    select id_coleccio into numColeccion from coleccio where titol=coleccion;
    select  numero_cromo into siLoTengo from cromos where coleccio=numColeccion;
     select cromos_totals into cromosTotal from coleccio where titol=coleccion;
    if ( siLoTengo<0 and siLoTengo>cromosTotal and numeroCromo != siLoTengo) then
    insert INTO cromos VALUES(numColeccion,numeroCromo);
    select 'Felicitats!! Has aconseguit el cromo' +numeroCromo+ 'de la col·lecció'+coleccion;
    elseif (numeroCromo = siLoTengo) then
    select 'Ja tens quantitatCromos del cromo' +numeroCromo+ 'de la col·lecció' +coleccion ;
    elseif (siLoTengo>=0 and siLoTengo<cromosTotal) then
    select 'El cromo '+numeroCromo+' no pot pertànyer a la coleccio' +coleccion;
    END IF;
END //
DELIMITER ;
CALL guardarCromo('Bola de Drac', 45, @resultat);
drop procedure guardarCromo;
DELIMITER $$
CREATE PROCEDURE guardarCromo(IN nomColeccio VARCHAR(20),IN numeroCromo INT,OUT resultat VARCHAR(250))
BEGIN
    DECLARE cromos_existentes INT;
    DECLARE cromos_faltantes INT;

    -- Verificar si el número de cromo pertenece a la colección
    SELECT COUNT(*) INTO cromos_existentes
    FROM cromos
    INNER JOIN coleccio ON cromos.coleccio = coleccio.id_coleccio
    WHERE coleccio.titol = nomColeccio AND cromos.numero_cromo = numeroCromo;

    -- Obtener el número de cromos faltantes para completar la colección
    SET cromos_faltantes = cromosQueFalten(nomColeccio);

    IF cromos_existentes = 0 THEN
        -- Insertar el nuevo cromo en la base de datos
        INSERT INTO cromos (coleccio, numero_cromo, quantitat) VALUES (
            (SELECT id_coleccio FROM coleccio WHERE titol = nomColeccio),
            numeroCromo,
            1
        );

        SET resultat = CONCAT('Felicitats!! Has aconseguit el cromo ', numeroCromo,
            ' de la col·lecció ', nomColeccio);
    ELSE
        SET resultat = CONCAT('Ja tens ', cromos_existentes, ' del cromo ', numeroCromo,
            ' de la col·lecció ', nomColeccio);
    END IF;

    IF cromos_faltantes = -1 THEN
        SET resultat = CONCAT('El cromo ', numeroCromo, ' no pot pertànyer a la col·lecció ', nomColeccio);
    END IF;
END$$
DELIMITER ;
/*
Aquí tienes varios ejemplos de funciones y procedimientos en MySQL que cubren una variedad de tipos de datos:

Función que suma dos números enteros y devuelve el resultado:
sql
Copy code
CREATE FUNCTION sumar_enteros(a INT, b INT)
RETURNS INT
BEGIN
  DECLARE resultado INT;
  SET resultado = a + b;
  RETURN resultado;
END;
Procedimiento que inserta un nuevo registro en una tabla:
sql
Copy code
CREATE PROCEDURE insertar_registro(nombre VARCHAR(50), edad INT, correo VARCHAR(100))
BEGIN
  INSERT INTO usuarios (nombre, edad, correo) VALUES (nombre, edad, correo);
END;
Función que calcula el promedio de un conjunto de números decimales y devuelve el resultado:
sql
Copy code
CREATE FUNCTION calcular_promedio(numeros DECIMAL(10,2))
RETURNS DECIMAL(10,2)
BEGIN
  DECLARE total DECIMAL(10,2);
  DECLARE cantidad INT;
  SET total = 0;
  SET cantidad = 0;
  
  WHILE numeros IS NOT NULL DO
    SET total = total + numeros;
    SET cantidad = cantidad + 1;
    SET numeros = @numeros;
  END WHILE;
  
  IF cantidad > 0 THEN
    SET total = total / cantidad;
  END IF;
  
  RETURN total;
END;
Procedimiento que actualiza el nombre de un usuario en base a su ID:
sql
Copy code
CREATE PROCEDURE actualizar_nombre(id INT, nuevo_nombre VARCHAR(50))
BEGIN
  UPDATE usuarios SET nombre = nuevo_nombre WHERE usuario_id = id;
END;
Función que concatena dos cadenas de texto y devuelve el resultado:
sql
Copy code
CREATE FUNCTION concatenar_texto(a VARCHAR(50), b VARCHAR(50))
RETURNS VARCHAR(100)
BEGIN
  DECLARE resultado VARCHAR(100);
  SET resultado = CONCAT(a, b);
  RETURN resultado;
END;
¡Por supuesto! Aquí tienes otros cinco ejemplos adicionales de funciones y procedimientos en MySQL:

Función que verifica si un número entero es par o impar y devuelve un valor booleano (0 para par, 1 para impar):
sql
Copy code
CREATE FUNCTION es_par(numero INT)
RETURNS BOOLEAN
BEGIN
  DECLARE resultado BOOLEAN;
  IF numero % 2 = 0 THEN
    SET resultado = 0;
  ELSE
    SET resultado = 1;
  END IF;
  RETURN resultado;
END;
Procedimiento que elimina todos los registros de una tabla:
sql
Copy code
CREATE PROCEDURE eliminar_registros()
BEGIN
  DELETE FROM usuarios;
END;
Función que convierte una fecha en formato YYYY-MM-DD a formato DD/MM/YYYY:
sql
Copy code
CREATE FUNCTION convertir_fecha(fecha DATE)
RETURNS VARCHAR(10)
BEGIN
  DECLARE resultado VARCHAR(10);
  SET resultado = DATE_FORMAT(fecha, '%d/%m/%Y');
  RETURN resultado;
END;
Procedimiento que incrementa en 1 el valor de un contador y lo muestra por pantalla:
sql
Copy code
CREATE PROCEDURE incrementar_contador()
BEGIN
  DECLARE contador INT;
  SET contador = 0;
  SET contador = contador + 1;
  SELECT contador;
END;
Función que devuelve el número de caracteres de una cadena de texto:
sql
Copy code
CREATE FUNCTION contar_caracteres(cadena VARCHAR(100))
RETURNS INT
BEGIN
  DECLARE resultado INT;
  SET resultado = LENGTH(cadena);
  RETURN resultado;
END;*/

CREATE DATABASE stock;

use stock;

CREATE TABLE productes(
CodProducte VARCHAR(10) NOT NULL,
Nom VARCHAR(20) NOT NULL,
PreuUnitari DECIMAL(6),
Stock INT(5),
PRIMARY KEY (CodProducte) );

CREATE TABLE vendes(
CodVenda VARCHAR(10) NOT NULL,
CodProducte VARCHAR(10) NOT NULL,
DataVenda DATE,
UnitatsVenudes INT(3),
PRIMARY KEY (CodVenda),
FOREIGN KEY (CodProducte) REFERENCES productes(CodProducte) );

/*Implementa un procediment que actualitzi la columna Stock de la taula Productes a partir de la taula
Vendes.
Aquest mètode li passarem les dades d’una venda i haurà de:
● Comprovar si hi ha suficient stock per fer la venda:
● Si és que SÍ: registrarà la venda, actualitzarà l’stock i ens avisarà que s’ha pogut fer la venda.
● Si és que NO: no actualitzarà les taules i ens ho indicarà en un missatge.
Exemple d’execució:
● CALL actualitza_stock(10, 1, ‘2022-05-26’, 22);*/

DELIMITER //
CREATE PROCEDURE actualitza_stock(IN codigoVenta VARCHAR(10),in codigoProducto VARCHAR(10), in fecha date, in unidades int(3))
BEGIN
	declare stockActual int(5);
 	select Stock into stockActual from productes where CodProducte=codigoProducto;
	if (stockActual>=unidades) then
    insert INTO vendes VALUES(codigoVenta,codigoProducto,fecha,unidades);
    update productes set stock = stock-unidades where CodProducte=codigoProducto;
    select "SI s’ha pogut fer la venda";
    elseif (stockActual<unidades) then
    select "NO s’ha pogut fer la venda, no hay stock";
      END IF;
END //
DELIMITER ;
		
CALL actualitza_stock(10, 1, ‘2022-05-26’, 22);

/*Volem tenir control del temps que un treballador està a l'empresa.
Tenim la taula on registra les entrades i sortides definida de la següent manera:*/
CREATE TABLE registre
(id_targeta VARCHAR(10),
data TIMESTAMP,
ent_sort ENUM('E','S')
);
/*El funcionament és el següent:
•Quan un treballador arriba a l'empresa hi ha un lector de targetes que identifica a l'usuari i registra l'hora i
un camp que identificarà que és l'entrada.
•Quan un treballador plega torna a llegir la targeta, l'hora de sortida i un identificador de sortida.
• Cada treballador queda registrat per l'identificador de la targeta.
Funcions:
(5 punts) Crea una funció per controlar els temps que està a l'empresa cada treballador. Li passarem
l’identificador i una data, i ens haurà de dir les hores que ha fet aquell dia, tenint en compte que el
treballador pot entrar i sortir diverses vegades un mateix dia.*/

DELIMITER //
CREATE FUNCTION funcio_horasTotales(idTrabajador VARCHAR(10), fecha TIMESTAMP)
RETURNS int
BEGIN
	declare vecesEntradaYSalida int;
    declare horaEntrada int;
    declare horaSalida int;
    declare horasAcumula int;
    declare horasTotales int;
    select count(ent_sort) into vecesEntradaYSalida from registre where idTrabajador=id_targeta and fecha=data;
	while (vecesEntradaYSalida>0) do
		select HOUR(fecha) into horaEntrada from registre where idTrabajador=id_targeta and fecha=data and ent_sort='E';
		select HOUR(fecha) into horaSalida from registre where idTrabajador=id_targeta and fecha=data and ent_sort= 'S';
        set horasAcumula = timestamp(hour,horaEntrada,horaSalida);
        set horaTotales = horasTotales+horasAcumula;
		set vecesEntradaYSalida = vecesEntradaYSalida-2;
         END WHILE;
	return horasTotales;
  END //
DELIMITER ;

select funcio_horasTotales(1,'2023-05-10');

/*(2 punts) Crea una funció per controlar les anomalies de cada treballador. Li passarem l’identificador i
una data, i ens haurà d’informar:
● Quan un treballador arriba a treballar més tard de les 9 del matí (el missatge que mostrarà
serà 'Entrada el dia 15/5/17 a les 9:18').*/

DELIMITER //
CREATE FUNCTION funcio_anomalies(idTrabajador VARCHAR(10), fecha TIMESTAMP)
RETURNS varchar(50)
BEGIN
	declare anomalia varchar(20);
		if ((HOUR(fecha)) > 9) then
			set anomalia = concat('Entrada el dia ',fecha,'a les ',(HOUR(fecha)));
			return anomalia;
		END IF;
END//
DELIMITER ;

select funcio_anomalies(1,'2023-05-10');

