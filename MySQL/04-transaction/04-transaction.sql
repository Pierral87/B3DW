-- Les transactions sont possibles avec le moteur InnoDB
-- Les transactions nous permettent de créer un environnement de travail afin d'exécuter des requêtes puis de les valider ou non 
-- On s'en sert souvent dans le web lorsqu'une opération est composée de plusieurs requêtes qui sont liés, mais quand on veut s'assurer qu'elles doivent toutes bien s'exécuter pour les valider les ensembles et éviter que l'on en valide une et pas les autres 

-- Avec la console, cela nous permet de tester des requêtes avant de les valider 
-- Dans notre langage back, on pourra souvent gérer les transactions via des classes natives comme PDO en PHP englobé dans un try/catch 

USE entreprise;

START TRANSACTION; -- démarre une transaction 

SELECT * FROM employes; -- On vérifie les données

UPDATE employes SET salaire = + 100; -- Ici je me trompe dans ma requête... Tous les salaires passent à 100 (au lieu d'ajouter 100 à tous les salaires)

SELECT * FROM employes; -- On vérifie les données (effectivement, elles sont mauvaises)

ROLLBACK; -- Me permet d'annuler toutes les modifications depuis le début et la transaction 
COMMIT;   -- COMMIT me permet de valider toutes les modifications depuis le début de ma transaction 

-- Si je ferme la console, ou que le système s'arrête, c'est toujours un ROLLBACK qui est appliqué par défaut
-- ATTENTION un COMMIT comme un ROLLBACK, TERMINE toujours la transaction 


-- TRANSACTION AVANCEE & SAVEPOINT 

START TRANSACTION;

SELECT * FROM employes; -- On vérifie les données

SAVEPOINT point1; -- Je crée un point de sauvegarde nommé "point1"

UPDATE employes SET salaire = 5000;

SELECT * FROM employes; -- On vérifie les données

SAVEPOINT point2;  -- Je crée un point de sauvegarde nommé "point2"

UPDATE employes SET salaire = 2000;
UPDATE employes SET service = "Web" WHERE service = "informatique";

SAVEPOINT point3;  -- Je crée un point de sauvegarde nommé "point3"

DELETE FROM employes WHERE service = "web";

SAVEPOINT point4;  -- Je crée un point de sauvegarde nommé "point4"

ROLLBACK TO point3; -- Retour à l'état du point 3 
SELECT * FROM employes; -- On vérifie les données - Je suis bien revenu au point3

-- ROLLBACK TO point4; -- Retour à l'état du point 4 - /!\ ERREUR ! Le point4 n'existe plus, du fait du ROLLBACK au point3 ! 

-- Avec le ROLLBACK TO : La transaction est toujours en cours ! Il faudra la terminer par un COMMIT ou un ROLLBACK tout court ! 

ROLLBACK; 

-- ATTENTION, à l'intérieur d'une transaction, les requêtes de structure s'applique directement et réellement ! (drop table, truncate, etc),  on est "dans la transaction" uniquement pour les requêtes classiques select, update, insert, delete 
-- Par exemple un DELETE va rester à l'intérieur de la transaction, on pourra le ROLLBACK, alors qu'un TRUNCATE (vider les informations de la table), s'appliquera à la vraie table hors transaction !!!! 





