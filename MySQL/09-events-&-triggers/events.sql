------------------------------------- EVENEMENTS ------------------------------------
-- Les évènements permettent de programmer des actions dépendantes d'autres 
-- On base souvent les évènements sur des durées de temps,  par exemple, une insertion chaque minute, une copie chaque jour 

-- Première chose, vérifier si la variable globale event_scheduler est sur ON ou 1 
SHOW GLOBAL VARIABLES LIKE "event_scheduler"; -- si cette variable est sur ON, c'est bon les évènements sont activés

SET GLOBAL event_scheduler = 1; -- Si non, on lance cette instruction pour les activer 

SHOW EVENTS; -- Permet d'afficher les events en cours 

-- Création d'un évent qui ajoute un employé dans la table employes à chaque minute  
CREATE EVENT insert_un_employe 
ON SCHEDULE EVERY 1 MINUTE  -- On spécifie là un intervale de temps qui va se répéter, on parle d'un event "recuring"
DO INSERT INTO employes (prenom) VALUES ("Boby");
-- Grâce à cet évènement, je vais avoir l'insertion d'un employé nommé Boby à chaque minute, on l'a bien vérifié dans PHPMyAdmin, on a par la suite supprimé cet évènement pour ne pas surcharger notre table 

-- Création d'un évent qui ajoute un employé unique dans 1 minute 
CREATE EVENT insert_one_minute 
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE -- Ici on spécifie un évènement à exactement une date + 1 minute 
DO INSERT INTO employes (prenom) VALUES ("Bruce");

-- Création d'un évent qui ajoute un employé unique à une date et heure précise
CREATE EVENT insert_one_minute 
ON SCHEDULE AT "2024-11-22 10:37:50" -- Ici on spécifie un évènement à exactement une date + 1 minute 
DO INSERT INTO employes (prenom) VALUES ("Brice");


-- Je peux faire un event récurent en spécifiant de commencer à une certaine date 
CREATE EVENT insert_one_minute 
ON SCHEDULE EVERY 1 MINUTE STARTS "2024-11-22 10:40:20" -- Ici on définie le start de l'évent à une date exacte
DO INSERT INTO employes (prenom) VALUES ("Brice");

-- Egalement on peut donner une date de fin à un evenement 
CREATE EVENT insert_end
ON SCHEDULE EVERY 5 SECOND 
ENDS CURRENT_TIMESTAMP + INTERVAL 1 MINUTE  -- Ici on définie une date de fin de notre évènement 
DO INSERT INTO employes (prenom) VALUES ("Willy");

-- Chaque évènement terminé se supprime de notre BDD 
-- Sinon ils sont actifs et on peut les voir dans notre PhpMyAdmin 

--------------------------------------------------------------------------
-- On va mettre en place un évènement type "back up" de table
-- Le but étant de copier l'intégralité d'une table pour l'insérer dans une autre 
-- On a créé une nouvelle base dans notre bdd et une table journal ainsi qu'une table journal_copie avec les mêmes champs 

-- Ici création de l'event de back up 

-- Dans cet event, on supprime la totalité du contenu de la table journal_copie pour le rendre de nouveau vide et réinsérer chaque minute un back up de la table journal d'origine
-- Ce qui va nous permettre qu'à chaque fois qu'il y a une modification de la table d'origine, on aura toujours la MAJ du back up chaque minute 
DELIMITER $ 
CREATE EVENT journal_backup 
    ON SCHEDULE EVERY 1 MINUTE 
    DO 
        BEGIN 
        DELETE FROM journal_copie; 
        INSERT INTO journal_copie SELECT * FROM journal;
        END 
    $

-- On peut aussi faire en sorte d'avoir des tables qui se crée dynamiquement en fonction de la date/heure du back up
-- Comme ça on peut garder trace de différents back up à des dates différentes 

DELIMITER $
CREATE procedure save_employes()
BEGIN 
    SET @sql = CONCAT('CREATE TABLE copie_employes_', NOW()+0, " SELECT * FROM employes");
    PREPARE req FROM @sql; 
    EXECUTE req; 
END $

CALL save_employes()$;

CREATE EVENT backup_employes
ON SCHEDULE EVERY 1 MINUTE 
DO 
    CALL save_employes();
$ 

DELIMITER ; 


USE bibliotheque;
-- Exercice 1 
        -- Créer un event qui inscrit dans une nouvelle table "emprunts_en_retard" les abonnés qui ont des emprunts dont la date_rendu est NULL et dont la date_sortie dépasse 30 jours 


DELIMITER $
CREATE EVENT verif_emprunt_en_retard
ON SCHEDULE EVERY 1 DAY 
DO 
    BEGIN 
        INSERT IGNORE INTO emprunt_en_retard (id_emprunt, id_abonne, id_livre, date_sortie) -- INSERT IGNORE permet d'ignorer l'insertion de la meme primary key sur une table 
            SELECT id_emprunt, id_abonne, id_livre, date_sortie 
                FROM emprunt 
                WHERE date_rendu IS NULL AND DATEDIFF(CURDATE(), date_sortie) > 30; -- Ici avec DATEDIFF, on comprends le diférentiel en nombre de jour entre deux dates
                -- WHERE date_rendu IS NULL AND date_sortie < CURDATE() - INTERVAL 30 DAY; -- Ou ici en comparant une date à une autre date moins 30 jours 
    END $

-- Exercice 2 
        -- Archivage des emprunts terminés : Créer une table historique_emprunts pour stocker les emprunts dont la date_rendu est renseignée 
            -- Après avoir fait cet event, refaite le en supprimant l'emprunt terminé de la table emprunt classique, on considèrera que notre table emprunt actuelle est une table d'emprunt "en cours"  
CREATE EVENT archive_emprunt 
ON SCHEDULE EVERY 1 MINUTE 
DO 
    BEGIN 
        INSERT INTO historique_emprunts (SELECT * FROM emprunt WHERE date_rendu IS NOT NULL); -- Ici j'insère tous les emprunts ayant la condition date_rendu IS NOT NULL (donc les livres déjà retournés en biblio)
        DELETE FROM emprunt WHERE date_rendu IS NOT NULL; -- Ici je supprime les emprunts terminés de la table emprunt (que l'on considère maintenant étant emprunt_en_cours)
    END$


