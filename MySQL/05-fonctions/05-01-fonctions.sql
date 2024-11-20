----------------- FONCTIONS PREDEFINIES ----------------------------------

-- Doc SQL : https://sql.sh


USE bibliotheque;

SELECT DATABASE(); -- Pour indiquer la base sur laquelle on se trouve 

SELECT LAST_INSERT_ID(); -- Le dernier id inséré dans la BDD (attention uniquement un id auto incrémenté)

-- CONCAT  pour concaténer des informations
SELECT CONCAT("a", "b", "c"); -- Permet de concaténer des informations 
SELECT CONCAT(id_abonne, " ", prenom) FROM abonne; -- On peut ainsi concaténer dans un seul et même champ plusieurs valeurs de champs différents 
-- CONCAT_WS  : with separator
SELECT CONCAT_WS(" ", id_abonne, prenom) FROM abonne; -- On séparé tous les éléments à concaténer par l'élément fourni en premier param de la fonction 

SELECT SUBSTRING("bonjour", 4); -- Permet de couper une chaine 

SELECT LOCATE("@", "salut@gmail.com"); -- Retourne le string de la position de l'élément 

SELECT LENGTH("salut"); -- La longueur d'une chaine 

SELECT TRIM("                 azerty                   ") AS password; -- Suppression des espaces en début et en fin de chaine de caractères 


SELECT CURDATE(); -- la date
SELECT CURTIME(); -- l'heure
SELECT NOW(); -- la date et l'heure 
SELECT CURRENT_TIMESTAMP; -- la date et l'heure 

SELECT DATE_ADD(CURDATE(), INTERVAL 2 DAY); -- Ajoute une valeur de temps à un type date 
SELECT DATE_ADD(CURDATE(), INTERVAL 2 MONTH);
SELECT DATE_ADD(CURDATE(), INTERVAL 2 YEAR);

SELECT DAYNAME(CURDATE());

-- DATE_FORMAT permet de formater une date au format de son choix, basé sur des tokens de remplacement
-- Ici %d me donne le numéro du jour sous deux digit
-- %m me donne le numéro du mois sous deux digit
-- %Y me donne l'année en 4 digit 
SELECT prenom, DATE_FORMAT(date_sortie, "%d/%m/%Y") AS date_fr 
FROM abonne 
JOIN emprunt USING (id_abonne);


----------------- FONCTIONS UTILISATEURS ----------------------------------
-- Fonctions écrites par le développeur pour un traitement spécifique dont on aurait besoin 


-- Comme je vais avoir besoin de définir des ";" au niveau des instructions de ma fonction, je dois définir un nouveau DELIMITER 

DELIMITER $  -- On change le délimiter, c'est à dire que je ne dois plus faire ; pour terminer une instruction, mais $, ce qui me permet d'inscrire des ; sans problèmes dans la déclaration de ma fonction 

CREATE FUNCTION calcul_tva(nb INT) RETURNS TEXT -- On reçoit un argument INT et on précise que la fonction renverra du texte
COMMENT "Fonction permettant le calcul de la TVA"
CONTAINS SQL -- Indique simplement que cette fonction contient du SQL sans opération d'écriture ni lecture   READS SQL DATA 
    BEGIN 
        RETURN CONCAT("Le prix TTC est de ", (nb*1.2));
    END $

SELECT calcul_tva(100);
+--------------------------+
| calcul_tva(100)          |
+--------------------------+
| Le prix TTC est de 120.0 |
+--------------------------+


   -- EXERCICE 1 : Le même calcul de TVA avec le choix du taux
   -- EXERCICE 2 : Faire une fonction qui me retourne le nombre d'employés pour un service envoyé en param de la fonction 

   -- DECLARE mavar INT;   -- Je peux déclarer une variable locale à l'intérieur d'une fonction ou procédure avec DECLARE
   -- SELECT xxxxxxxx INTO mavar FROM xxxxxx WHERE xxxxxxxxx  -- Avec l'instruction SELECT xxxxx INTO mavar  je peux intégrer dans ma variable "mavar" le résultat d'une requête


   -- Les FLAGS que l'on peut indiquer en début d'une fonction 
    -- NO SQL : Indique qu'une fonction ne contient pas d'instructions SQL 
    -- CONTAINS SQL : Indique que la fonction contient des instructions SQL qui n'effectuent ni lecture ni modification 
    -- READS SQL DATA : Indique que la fonction contient des instructions SELECT
    -- MODIFIES SQL DATA : Indique que la fonction contient des instructions INSERT, UPDATE ou DELETE 


