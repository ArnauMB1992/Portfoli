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
	