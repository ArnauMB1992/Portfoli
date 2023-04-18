/*1. Mostra el nom popular de les plantes que solament tenim un exemplar.*/
SELECT distinct p.nom_popular
   FROM exemplar_planta ep, planta p
   WHERE ep.nom_planta=p.nom_cientific and (select max(num_exemplar) from exemplar_planta)=1 ;
   
/*2. Mostra el nom popular de les plantes les quals no tenim exemplars.*/
SELECT distinct p.nom_popular
   FROM exemplar_planta ep, planta p
   WHERE ep.nom_planta=p.nom_cientific and ep.num_exemplar=0;   

/*3. Mostra les vegades que hem d’abonar les plantes en cada estació.*/
SELECT nom_estacio, COUNT(quantitat_adob) AS num_abonaments
FROM dosi_adob
GROUP BY nom_estacio;

/*4. Mostra quines plantes no reben adob a la primavera.*/
select nom_planta, nom_estacio from dosi_adob
WHERE nom_estacio != 'Primavera';

/*5. Mostra quants mètodes de reproducció té cada planta.*/
SELECT nom_cientific, COUNT(*) AS num_metodes
FROM planta
INNER JOIN reproduccio
ON planta.nom_cientific = reproduccio.nom_planta
GROUP BY nom_cientific;

/*6. Mostra quants mètodes de reproducció té cada planta amb un grau d'èxit alt.*/
SELECT nom_cientific, COUNT(*) AS num_metodes
FROM planta
INNER JOIN reproduccio
ON planta.nom_cientific = reproduccio.nom_planta
WHERE reproduccio.grau_exit = 'Alt'
GROUP BY nom_cientific;

/*7. Mostra quines plantes no es reprodueixen per 'Esqueix'*/
SELECT nom_cientific
FROM planta
WHERE nom_cientific NOT IN (
  SELECT nom_planta
  FROM reproduccio
  WHERE metode_reproduccio = 'Esqueix');

/*8. Mostra quines plantes d'interior floreixen a la 'Primavera'*/
SELECT nom_cientific
FROM planta
WHERE floracio = 'Primavera';

/*9. Mostra quants adobs té cada fima comercial.*/
SELECT nom_firma, COUNT(*) as num_adobs
FROM adob
GROUP BY nom_firma;