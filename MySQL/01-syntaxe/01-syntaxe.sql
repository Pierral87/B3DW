-- Ceci est un commentaire jusqu'à la fin de la ligne 
# Ceci est un commentaire aussi 

/*       
    Ceci est un commentaire entre les deux indicateurs 
  */

-- ATTENTION on évite les commentaires dans le SQL (sauf gros fichiers, explications de fonctions/procédures stockées etc), on préfèrera mettre les commentaires dans notre langage back 

-- Lien utile, la documentation de SQL :  https://sql.sh/

-- Les requêtes ne sont pas sensibles à la casse (min/MAJ), en revanche, convention d'écriture veut que l'on écrive tous les mots clés en MAJUSCULE 
-- SELECT prenom FROM user;

-- Chaque instruction doit se terminer par un ; 

-- Pour se connecter à la console MySQL : 

            -- Wamp : Ouvrir le menu MySQL et Console MySQL 
            -- Xampp :  Ouvrir le shell (le terminal)  mysql -u root -p
            -- Mamp : /Applications/MAMP/Library/bin/mysql -u root -p     (le password est égal à root pour Mamp)

-- Pour créer une BASE 
CREATE DATABASE ma_bdd;

SHOW DATABASES; -- Pour voir la liste des BDD sur le serveur
SHOW TABLES; -- Pour voir la liste des tables d'une BDD 
SHOW WARNINGS; -- Pour voir les détails des erreurs de type WARNING de la dernière requête exécutée 

USE ma_bdd; -- Pour se positionner sur une BDD afin de pouvoir travailler dessus 
SELECT DATABASE(); -- Pour vérifier quelle est la base sur laquelle on se trouve

DROP DATABASE unebdd; -- Pour supprimer une BDD 
DROP DATABASE ma_bdd; 

DROP TABLE nom_de_table; -- Pour supprimer une table 

TRUNCATE nom_de_table; -- Pour vider (attention cette instruction passe outre une transaction)
DELETE FROM nom_de_table; -- Pour vider aussi (requête classique de type action) 

DESC nom_de_table; -- Pour avoir une DESCription de la structure de la table 

CREATE DATABASE entreprise;
USE entreprise;


https://sharemycode.fr/sql1810


-- Création d'une table employes dans la base entreprise
CREATE TABLE IF NOT EXISTS employes (
  id_employes int(3) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 ;

-- Insertions dans la table employes 
INSERT INTO employes (id_employes, prenom, nom, sexe, service, date_embauche, salaire) VALUES
(350, 'Jean-pierre', 'Laborde', 'm', 'direction', '2010-12-09', 5000),
(388, 'Clement', 'Gallet', 'm', 'commercial', '2010-12-15', 2300),
(415, 'Thomas', 'Winter', 'm', 'commercial', '2011-05-03', 3550),
(417, 'Chloe', 'Dubar', 'f', 'production', '2011-09-05', 1900),
(491, 'Elodie', 'Fellier', 'f', 'secretariat', '2011-11-22', 1600),
(509, 'Fabrice', 'Grand', 'm', 'comptabilite', '2011-12-30', 2900),
(547, 'Melanie', 'Collier', 'f', 'commercial', '2012-01-08', 3100),
(592, 'Laura', 'Blanchet', 'f', 'direction', '2012-05-09', 4500),
(627, 'Guillaume', 'Miller', 'm', 'commercial', '2012-07-02', 1900),
(655, 'Celine', 'Perrin', 'f', 'commercial', '2012-09-10', 2700),
(699, 'Julien', 'Cottet', 'm', 'secretariat', '2013-01-05', 1390),
(701, 'Mathieu', 'Vignal', 'm', 'informatique', '2013-04-03', 2500),
(739, 'Thierry', 'Desprez', 'm', 'secretariat', '2013-07-17', 1500),
(780, 'Amandine', 'Thoyer', 'f', 'communication', '2014-01-23', 2100),
(802, 'Damien', 'Durand', 'm', 'informatique', '2014-07-05', 2250),
(854, 'Daniel', 'Chevel', 'm', 'informatique', '2015-09-28', 3100),
(876, 'Nathalie', 'Martin', 'f', 'juridique', '2016-01-12', 3550),
(900, 'Benoit', 'Lagarde', 'm', 'production', '2016-06-03', 2550),
(933, 'Emilie', 'Sennard', 'f', 'commercial', '2017-01-11', 1800),
(990, 'Stephanie', 'Lafaye', 'f', 'assistant', '2017-03-01', 1775);

--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
------------ REQUETES DE SELECTION (On questionne la BDD) ----------------------------
--------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------


-- Affichage complet des données d'une table (dans l'ordre de création) 
SELECT * FROM employes;

-- Affichage complet des données de la table (dans l'ordre de colonne que je souhaite)
SELECT id_employes, nom, prenom, sexe, service, salaire, date_embauche FROM employes;

-- Selection de simplement quelques champs de la table 
SELECT nom, prenom FROM employes;

-- Affichez la liste des services différents de la table employes
SELECT service FROM employes;
-- Pour éviter les doublons, on utilise DISTINCT
SELECT DISTINCT service FROM employes;
+---------------+
| service       |
+---------------+
| direction     |
| commercial    |
| production    |
| secretariat   |
| comptabilite  |
| informatique  |
| communication |
| juridique     |
| assistant     |
+---------------+

-- CONDITION WHERE 
-- Affichage des employés du service informatique 
SELECT * FROM employes WHERE service = "informatique";
SELECT * FROM employes WHERE service = 'informatique';
+-------------+---------+--------+------+--------------+---------------+---------+
| id_employes | prenom  | nom    | sexe | service      | date_embauche | salaire |
+-------------+---------+--------+------+--------------+---------------+---------+
|         701 | Mathieu | Vignal | m    | informatique | 2013-04-03    |    2500 |
|         802 | Damien  | Durand | m    | informatique | 2014-07-05    |    2250 |
|         854 | Daniel  | Chevel | m    | informatique | 2015-09-28    |    3100 |
+-------------+---------+--------+------+--------------+---------------+---------+

-- BETWEEN 
-- Affichage des employes ayant été embauché entre 2015 et aujourd'hui  
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND "2024-10-18";
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND NOW();  -- fonction NOW() retourne la date et l'heure de maintenant
SELECT * FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND CURDATE(); -- fonction CURDATE() retourne la date d'aujourd'hui 
+-------------+-----------+----------+------+--------------+---------------+---------+
| id_employes | prenom    | nom      | sexe | service      | date_embauche | salaire |
+-------------+-----------+----------+------+--------------+---------------+---------+
|         854 | Daniel    | Chevel   | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie  | Martin   | f    | juridique    | 2016-01-12    |    3550 |
|         900 | Benoit    | Lagarde  | m    | production   | 2016-06-03    |    2550 |
|         933 | Emilie    | Sennard  | f    | commercial   | 2017-01-11    |    1800 |
|         990 | Stephanie | Lafaye   | f    | assistant    | 2017-03-01    |    1775 |
|         991 | Pierra    | Lacaze   | m    | Assistant    | 2024-10-01    |    2000 |
|         992 | aze       | azerty   |      | assistant    | 2024-10-01    |    2000 |
|         993 | azertty   | azertyuu |      | Assistant    | 2024-10-01    |    3000 |
+-------------+-----------+----------+------+--------------+---------------+---------+


-- LIKE la valeur approchante 
-- Like nous permet de rechercher une information sans l'écrire complètement 
-- Affichage des prenoms commençant par la lettre "s" 
SELECT prenom FROM employes WHERE prenom LIKE "s%";
-- % signifie : peu importe ce qui se trouve à cet endroit 

-- Affichage des prénoms finissant par les lettres "ie"
SELECT prenom FROM employes WHERE prenom LIKE "%ie";
+-----------+
| prenom    |
+-----------+
| Elodie    |
| Melanie   |
| Nathalie  |
| Emilie    |
| Stephanie |
+-----------+

-- Affichage des prénoms contenant les lettres "ie"
SELECT prenom FROM employes WHERE prenom LIKE "%ie%";
+-------------+
| prenom      |
+-------------+
| Jean-pierre |
| Elodie      |
| Melanie     |
| Julien      |
| Mathieu     |
| Thierry     |
| Damien      |
| Daniel      |
| Nathalie    |
| Emilie      |
| Stephanie   |
| Pierra      |
+-------------+

-- BDD immobilière 

-- id      -- type     -- code_postal
-- 10      -- apart    -- 74000
-- 12      -- maison   -- 74100
-- 15      -- maison   -- 69000

-- Ici un LIKE "74%" nous sort tous les biens immobiliers présents dans le département 74, sans avoir forcément la nécessité d'avoir un champ "département" dans la table 

-- EXCLUSION 
-- Tous les employés sauf ceux d'un service particulier, par exemple, sauf le service commercial 
SELECT * FROM employes WHERE service != "commercial"; -- !=  différent de 
+-------------+-------------+----------+------+---------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service       | date_embauche | salaire |
+-------------+-------------+----------+------+---------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction     | 2010-12-09    |    5000 |
|         417 | Chloe       | Dubar    | f    | production    | 2011-09-05    |    1900 |
|         491 | Elodie      | Fellier  | f    | secretariat   | 2011-11-22    |    1600 |
|         509 | Fabrice     | Grand    | m    | comptabilite  | 2011-12-30    |    2900 |
|         592 | Laura       | Blanchet | f    | direction     | 2012-05-09    |    4500 |
|         699 | Julien      | Cottet   | m    | secretariat   | 2013-01-05    |    1390 |
|         701 | Mathieu     | Vignal   | m    | informatique  | 2013-04-03    |    2500 |
|         739 | Thierry     | Desprez  | m    | secretariat   | 2013-07-17    |    1500 |
|         780 | Amandine    | Thoyer   | f    | communication | 2014-01-23    |    2100 |
|         802 | Damien      | Durand   | m    | informatique  | 2014-07-05    |    2250 |
|         854 | Daniel      | Chevel   | m    | informatique  | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique     | 2016-01-12    |    3550 |
|         900 | Benoit      | Lagarde  | m    | production    | 2016-06-03    |    2550 |
|         990 | Stephanie   | Lafaye   | f    | assistant     | 2017-03-01    |    1775 |
|         991 | Pierra      | Lacaze   | m    | Assistant     | 2024-10-01    |    2000 |
|         992 | aze         | azerty   |      | assistant     | 2024-10-01    |    2000 |
|         993 | azertty     | azertyuu |      | Assistant     | 2024-10-01    |    3000 |
+-------------+-------------+----------+------+---------------+---------------+---------+

-- Les opérateurs de comparaison : 
-- =    est égal à 
-- !=   est différent de 
-- >    strictement supérieur 
-- >=   supérieur ou égal 
-- <    strictement inférieur 
-- <=   inférieur ou égal 

-- Les employés ayant un salaire supérieur 3000
SELECT * FROM employes WHERE salaire > 3000;
SELECT * FROM employes WHERE salaire > "3000"; -- Ici les guillemets sont acceptés, MySQL réussi à faire le tri dans les valeurs qu'il reçoit tant qu'elles peuvent être retranscrite dans les types qu'il attend 
+-------------+-------------+----------+------+--------------+---------------+---------+
| id_employes | prenom      | nom      | sexe | service      | date_embauche | salaire |
+-------------+-------------+----------+------+--------------+---------------+---------+
|         350 | Jean-pierre | Laborde  | m    | direction    | 2010-12-09    |    5000 |
|         415 | Thomas      | Winter   | m    | commercial   | 2011-05-03    |    3550 |
|         547 | Melanie     | Collier  | f    | commercial   | 2012-01-08    |    3100 |
|         592 | Laura       | Blanchet | f    | direction    | 2012-05-09    |    4500 |
|         854 | Daniel      | Chevel   | m    | informatique | 2015-09-28    |    3100 |
|         876 | Nathalie    | Martin   | f    | juridique    | 2016-01-12    |    3550 |


-- ORDER BY pour ordonner les résultats 
-- Affichage des employés dans l'ordre alphabétique 
SELECT * FROM employes ORDER BY nom;
SELECT * FROM employes ORDER BY nom ASC; -- ASC pour ascendant (cas par défaut si non précisé dans la requête), si string c'est alphabétique, si numerique c'est croissant 
-- Ordre inversé : 
SELECT * FROM employes ORDER BY nom DESC; -- DESC pour descendant 

-- Il est possible d'ordonner par plusieurs champs. Si le premier champ ressort des valeurs similaires, on peut se baser sur un second champ, et même encore d'autres 
-- Ordonner par le service 
SELECT * FROM employes ORDER BY service ASC;
-- Ordonner par le service puis par le nom
SELECT * FROM employes ORDER BY service ASC, nom ASC;

-- LIMIT pour limiter le nombre de résultat (pour une pagination par exemple)
-- Affichage des employés 3 par 3 
SELECT * FROM employes LIMIT 0, 3;  -- LIMIT offset, nb de ligne    offset = position de départ 
+-------------+-------------+---------+------+------------+---------------+---------+
| id_employes | prenom      | nom     | sexe | service    | date_embauche | salaire |
+-------------+-------------+---------+------+------------+---------------+---------+
|         350 | Jean-pierre | Laborde | m    | direction  | 2010-12-09    |    5000 |
|         388 | Clement     | Gallet  | m    | commercial | 2010-12-15    |    2300 |
|         415 | Thomas      | Winter  | m    | commercial | 2011-05-03    |    3550 |
+-------------+-------------+---------+------+------------+---------------+---------+
SELECT * FROM employes LIMIT 3, 3; 
+-------------+---------+---------+------+--------------+---------------+---------+
| id_employes | prenom  | nom     | sexe | service      | date_embauche | salaire |
+-------------+---------+---------+------+--------------+---------------+---------+
|         417 | Chloe   | Dubar   | f    | production   | 2011-09-05    |    1900 |
|         491 | Elodie  | Fellier | f    | secretariat  | 2011-11-22    |    1600 |
|         509 | Fabrice | Grand   | m    | comptabilite | 2011-12-30    |    2900 |
+-------------+---------+---------+------+--------------+---------------+---------+
SELECT * FROM employes LIMIT 6, 3; 
+-------------+-----------+----------+------+------------+---------------+---------+
| id_employes | prenom    | nom      | sexe | service    | date_embauche | salaire |
+-------------+-----------+----------+------+------------+---------------+---------+
|         547 | Melanie   | Collier  | f    | commercial | 2012-01-08    |    3100 |
|         592 | Laura     | Blanchet | f    | direction  | 2012-05-09    |    4500 |
|         627 | Guillaume | Miller   | m    | commercial | 2012-07-02    |    1900 |
+-------------+-----------+----------+------+------------+---------------+---------+

SELECT * FROM employes LIMIT 3; -- si l'offset n'est pas précisé, on commence à l'enregistrement 0, donc au début des résultats de notre requete


-- Affichage des employes avec leur salaire annuel 
SELECT nom, prenom, service, salaire * 12 FROM employes;
SELECT nom, prenom, service, salaire * 12 AS salaire_annuel FROM employes; -- La même requête mais avec un alias sur la colonne du calcul
SELECT nom, prenom, service, salaire * 12 AS "Salaire Annuel" FROM employes; -- On peut aussi entre guillemets mais à éviter pour cause de complexité de récupération dans notre langage back 

-- Fonctions d'agrégation 

-- SUM() pour avoir la somme 
-- La masse salariale annuelle de l'entreprise 
SELECT SUM(salaire * 12) AS masse_salariale FROM employes;
+-----------------+
| masse_salariale |
+-----------------+
|          707580 |
+-----------------+

-- AVG() la moyenne 
-- Affichage du salaire moyen de l'entreprise 
SELECT AVG(salaire) AS salaire_moyen_mensuel FROM employes;



-- ROUND() pour arrondir 
-- ROUND(valeur) => arrondi à l'entier 
-- ROUND(valeur, 1) => arrondi avec une décimale, on peut choisir le nombre de décimales souhaitées
SELECT ROUND(AVG(salaire)) AS salaire_moyen_mensuel_arrondi FROM employes;
SELECT ROUND(AVG(salaire), 1) AS salaire_moyen_mensuel_arrondi FROM employes;
SELECT ROUND(AVG(salaire), 3) AS salaire_moyen_mensuel_arrondi FROM employes;

-- COUNT() permet de compter le nombre de lignes/résultats d'une requête 
-- Le nombre d'employés dans l'entreprise : 
SELECT COUNT(*) AS nombre_employes FROM employes; -- COUNT() va faire +1 pour chaque ligne correspondant à la requête et nous renvoie le total 
+-----------------+
| nombre_employes |
+-----------------+
|              23 |
+-----------------+

SELECT COUNT(service) AS nombre_employes FROM employes; -- ATTENTION COUNT() ne compte pas une ligne si la valeur du champ spécifié est NULL pour cette ligne là 

-- Deux contextes pour l'utilisation de COUNT 
    -- Soit on utilise COUNT(*) pour s'assurer de compter l'intégralité des lignes de notre tables/d'une requête 
    -- Soit on utilise COUNT(un_champ) pour compter tous les enregistrements pour lesquels ce champ est bien rempli 

SELECT COUNT(*) AS nombre_employes FROM employes WHERE service = "commercial"; 
+-----------------+
| nombre_employes |
+-----------------+
|               6 |
+-----------------+

-- MIN() & MAX()
-- Salaire minimum 
SELECT MIN(salaire) FROM employes;
+--------------+
| MIN(salaire) |
+--------------+
|         1390 |
+--------------+

-- Salaire maximum 
SELECT MAX(salaire) FROM employes;
+--------------+
| MAX(salaire) |
+--------------+
|         5000 |
+--------------+

-- EXERCICE : Affichez le salaire minimum ainsi que le prenom de l'employé ayant ce salaire...... (Julient Cottet)
SELECT prenom, nom, MIN(salaire) FROM employes; -- Pas d'erreur, mais le résultat est FAUX 

-- ATTENTION les fonctions d'agrégation comme MIN ne peuvent renvoyer qu'un seul résultat ! (une seule ligne) 
-- Ici cela récupère le salaire minimum ainsi que les informations de la première ligne trouvée par la requête (pas de condition ici donc ça nous sort JP Laborde, le premier enregistrement)

-- 2 solutions 

-- Requête imbriquée
SELECT prenom, nom, salaire FROM employes WHERE salaire = (SELECT MIN(salaire) FROM employes);
+--------+--------+---------+
| prenom | nom    | salaire |
+--------+--------+---------+
| Julien | Cottet |    1390 |
+--------+--------+---------+

SELECT prenom, nom, salaire FROM employes ORDER BY salaire ASC LIMIT 1;
+--------+--------+---------+
| prenom | nom    | salaire |
+--------+--------+---------+
| Julien | Cottet |    1390 |
+--------+--------+---------+

-- IN & NOT IN pour tester plusieurs valeurs 
-- Affichage des employes des services commercial et comptabilite 
SELECT * FROM employes WHERE service = "commercial" OR service = "comptabilite";
SELECT * FROM employes WHERE service IN ("commercial", "comptabilite");
+-------------+-----------+---------+------+--------------+---------------+---------+
| id_employes | prenom    | nom     | sexe | service      | date_embauche | salaire |
+-------------+-----------+---------+------+--------------+---------------+---------+
|         388 | Clement   | Gallet  | m    | commercial   | 2010-12-15    |    2300 |
|         415 | Thomas    | Winter  | m    | commercial   | 2011-05-03    |    3550 |
|         509 | Fabrice   | Grand   | m    | comptabilite | 2011-12-30    |    2900 |
|         547 | Melanie   | Collier | f    | commercial   | 2012-01-08    |    3100 |
|         627 | Guillaume | Miller  | m    | commercial   | 2012-07-02    |    1900 |
|         655 | Celine    | Perrin  | f    | commercial   | 2012-09-10    |    2700 |
|         933 | Emilie    | Sennard | f    | commercial   | 2017-01-11    |    1800 |
+-------------+-----------+---------+------+--------------+---------------+---------+
-- L'inverse NOT IN 
SELECT * FROM employes WHERE service NOT IN ("commercial", "comptabilite");

-- Plusieurs conditions : AND 
-- On veut les employes du service commercial ayant un salaire inférieur ou égal à 2000 
SELECT * FROM employes WHERE service = "commercial" AND salaire <= 2000;

-- On peut sauter des lignes en MySQL, pas de problèmes 
SELECT * 
FROM employes 
WHERE service = "commercial" 
AND salaire <= 2000;

-- L'un ou l'autre d'un ensemble de conditions : OR 
-- EXERCICE : Les employes du service production ayant un salaire égal à 1900 ou 2300......
SELECT * FROM employes WHERE service = "production" AND salaire = 1900 OR salaire = 2300; -- Résultat incorrect, la conditon après le OR est dissocié de l'association des deux rattachées par le AND 

-- Plusieurs solutions 
SELECT * FROM employes WHERE service = "production" AND salaire = 1900 OR service = "production" AND salaire = 2300;
SELECT * FROM employes WHERE service = "production" AND (salaire = 1900 OR salaire = 2300);
SELECT * FROM employes WHERE service = "production" AND salaire IN (1900,2300);

-- GROUP BY pour regrouper selon ou ou des champs 
-- Nombre d'employés par service 
SELECT COUNT(*), service FROM employes; -- Résultat incorrect, le COUNT n'est pas rattaché au service qui sort sur ce résultat (COUNT c'est une fonction d'agrégation il sort un seul résultat, et à côté, le système nous sort la valeur du service pour la première ligne trouvée)

-- Avec GROUP BY il est possible de "démanteler" l'entièreté du résultat pour le regrouper en bloc de même valeur d'un champ (par exemple le service) et permettre d'appliquer une fonction d'agrégation sur chacun de ces groupes. 
SELECT COUNT(*) AS nombre_employes, service FROM employes GROUP BY service;

-- Il est possible de mettre une condition sur un GROUP BY + agregations avec HAVING (ayant)
-- Nombre d'employés par service, pour les services ayant strictement plus de 2 employés 
SELECT COUNT(*), service FROM employes GROUP BY service HAVING COUNT(*) > 2;

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------- REQUETES D'INSERTION (Action : enregistrement) -----------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- Insertion 
-- On peut laisser sur NULL la valeur de la primary key car elle va s'auto incrémenter
-- En fait, on peut même ne pas la citer du tout 
INSERT INTO employes (id_employes, prenom, nom, salaire, sexe, service, date_embauche) VALUES (NULL, "Pierral", "Lacaze", 12000, "m", "informatique", CURDATE());
INSERT INTO employes (prenom, nom, salaire, sexe, service, date_embauche) VALUES ("Pierral", "Lacaze", 12000, "m", "informatique", CURDATE());
INSERT INTO employes VALUES (NULL, "Pierral", "Lacaze", "m", "informatique",  CURDATE(), 12000); -- On peut ne pas citer les champs dans lesquelles on insère par contre, il faut absolument citer les valeurs dans l'ordre de la structure de la table (pratique déconseillée)

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------- REQUETES DE MODIFICATION (Action : modification) ---------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- On modifie le salaire d'un employe 
UPDATE employes SET salaire = 2100 WHERE id_employes = 996;
-- Plusieurs modifications sont possibles à la fois 
UPDATE employes SET salaire = 2200, service = "web" WHERE id_employes = 995;

-- REPLACE 
-- Dans le cas d'une valeur non trouvée, le REPLACE se comporte comme un INSERT INTO 
REPLACE INTO employes VALUES (997, "Polo", "Lolo", "m", "Web", CURDATE(), 50000);

REPLACE INTO employes VALUES (997, "Polo", "Lolo", "m", "Web", CURDATE(), 500);
-- Par contre, si l'enregistrement existe, il va modifier l'enregistrement... MAIS ATTENTION, ce n'est pas un simple UPDATE qui est exécuté à la place, c'est une suppression et une réinsertion !!! Dans le cas de relation avec contraintes dans notre BDD (SET NULL, CASCADE etc), les conséquences peuvent être dramatiques ! 
-- L'utilisation de Replace sur une relation en CASCADE induirait la suppression de tous les éléments rattachés à cette classe (par foreign key)
-- DONC --- On utilise JAMAIS REPLACE --- 


------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------- REQUETES DE SUPPRESSION (Action : suppression) -----------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

DELETE FROM employes; -- Cette requête ne possède pas de conditions donc elle supprimera l'entièreté des données de la table

-- Si on veut supprimer des enregistrements spécifiques, il suffit de les pointer avec des conditions WHERE 
DELETE FROM employes WHERE id_employes > 990; -- Ici je supprime tous les employés ayant un id supérieur à 990
DELETE FROM employes WHERE service = "informatique" AND id_employes != 701; -- Suppression de tous les informaticiens sauf celui qui a l'id 701 




------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
------------------------- EXERCICES : ----------------------------------------------------
------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------

-- 1 -- Afficher la profession de l'employé 547.
SELECT service FROM employes WHERE id_employes = 547;
-- 2 -- Afficher la date d'embauche d'Amandine.	
SELECT date_embauche FROM employes WHERE prenom = "Amandine";
-- 3 -- Afficher le nom de famille de Guillaume	
SELECT nom from employes WHERE prenom = "Guillaume";
-- 4 -- Afficher le nombre de personne ayant un n° id_employes commençant par le chiffre 5.	
SELECT COUNT(*) AS nombre_employes FROM employes WHERE id_employes LIKE "5%";
-- 5 -- Afficher le nombre de commerciaux.
SELECT COUNT(*) AS nom_commerciaux FROM employes WHERE service = "commercial";
-- 6 -- Afficher le salaire moyen des informaticiens (+arrondie).	
SELECT ROUND(AVG(salaire), 2) AS salaire_moyen_informaticien FROM employes WHERE service = "informatique";
-- 7 -- Afficher les 5 premiers employés après avoir classé leur nom de famille par ordre alphabétique. 
SELECT nom, prenom FROM employes ORDER BY nom ASC LIMIT 5;
-- 8 -- Afficher le coût des commerciaux sur 1 année.	
SELECT SUM(salaire * 12) AS salaire_annuel_comerciaux FROM employes WHERE service = "commercial";
-- 9 -- Afficher le salaire moyen par service. (service + salaire moyen)
SELECT service, ROUND(AVG(salaire)) AS salaire_moyen FROM employes GROUP BY service;
-- 10 -- Afficher le nombre de recrutement sur l'année 2010 (+alias).	
SELECT COUNT(*) AS nombre_recrutement_2010 FROM employes WHERE date_embauche LIKE "2010%";
SELECT COUNT(*) AS nombre_recrutement_2010 FROM employes WHERE YEAR(date_embauche) = 2010;
-- 11 -- Afficher le salaire moyen appliqué lors des recrutements sur la période allant de 2015 a 2017
SELECT ROUND(AVG(salaire)) FROM employes WHERE date_embauche >= "2015-01-01" AND date_embauche <= "2017-12-31";
SELECT ROUND(AVG(salaire)) FROM employes WHERE date_embauche BETWEEN "2015-01-01" AND "2017-12-31";
-- 12 -- Afficher le nombre de service différent 
SELECT COUNT(DISTINCT service) AS nombre_service_different FROM employes;
-- 13 -- Afficher tous les employés (sauf ceux du service production et secrétariat)
SELECT * FROM employes WHERE service NOT IN ("production", "secretariat");
-- 14 -- Afficher conjointement le nombre d'homme et de femme dans l'entreprise
SELECT COUNT(*) AS homme, (SELECT COUNT(*) FROM employes WHERE sexe = "f") AS femme FROM employes WHERE sexe = "m";
SELECT sexe, COUNT(*) AS nombre FROM employes GROUP BY sexe;
-- 15 -- Afficher les commerciaux ayant été recrutés avant 2012 de sexe masculin et gagnant un salaire supérieur a 2500 €
SELECT * FROM employes WHERE service = "commercial" AND date_embauche < "2012-01-01" AND sexe = "m" AND salaire > 2500;
-- 16 -- Qui a été embauché en dernier 
SELECT * FROM employes ORDER BY date_embauche DESC LIMIT 1;
-- 17 -- Afficher les informations sur l'employé du service commercial gagnant le salaire le plus élevé
SELECT * FROM employes WHERE service = "commercial" ORDER BY salaire DESC LIMIT 1;
-- 18 -- Afficher le prénom du comptable gagnant le meilleur salaire
SELECT prenom FROM employes WHERE service = "comptabilite" ORDER BY salaire DESC LIMIT 1;
-- 19 -- Afficher le prénom de l'informaticien ayant été recruté en premier 
SELECT prenom FROM employes WHERE service = "informatique" ORDER BY date_embauche ASC LIMIT 1;
-- 20 -- Augmenter chaque employé de 100 €
UPDATE employes SET salaire = salaire + 100;
-- 21 -- Supprimer les employés du service secrétariat
DELETE FROM employes WHERE service = "secretariat";