---------------------- PROCEDURE STOCKEE ---------------------------

-- Une procédure est similaire à une fonction 
-- En MySQL la différence réside dans le fait que une fonction retourne une simple valeur via un return alors que la procédure me retourne un jeu de résultat d'une requête 

-- La procédure, une fois définie, est stockée dans ma BDD de manière durable et réutilisable à tout moment

-- Les avantages d'une procédure stockée 
    -- Moins de risque de se tromper : plus facile de lancer une procédure nommée par exemple selectAll(), plutôt que de à chaque fois réécrire une requête à la main SELECT champ1, champ2, champ3 FROM table; 
    -- Meilleure compréhension : Il est plus facile de comprendre le nom d'une procédure (en rapport avec son action) plutôt que de lire une requête entière
    -- Facilité d'utilisation : Si d'autres personnes manipulent la BDD, même sans connaissances avancées en SQL, ils pourront comprendre facilement l'exécution de procédure 
    -- Evolutivité : Si la requête était amené à changer, elle ne sera modifiée qu'à un seul endroit, dans notre BDD et non pas à tous les endroits du code de notre app, ce qui serait beaucoup de travail et beaucoup de chances de se tromper 
    -- Sécurité : On laisse le travail à une seule personne : "La personne qui gère la BDD"
    -- Optimisation : La procédure se lance plus rapidement qu'une requête à la main car l'analyse et interprétation de la requête sont déjà effectuées

USE entreprise; 
DELIMITER $ -- On remplace notre délimiter ; par $ pour déclarer sans problème notre procédure 

-- Création d'une procédure stockée qui affiche la date du jour en français 
CREATE PROCEDURE date_fr()
BEGIN 
    SELECT DATE_FORMAT(CURDATE(), "%d/%m/%Y") AS "today";
END $

CALL date_fr()$

-- Paramètres IN et OUT  

CREATE PROCEDURE addition_result(IN valeur1 INT, IN valeur2 INT, OUT total INT)
BEGIN 
    SELECT valeur1+valeur2 INTO total; 
END $ 
CALL addition_result(10, 5, @result)$
SELECT @result$

-- Options applicables sur les params que l'on fournit 
    -- IN : Entrant 
            -- Paramètres par défaut, la valeur est passée à la procédure, peut être modifiée à l'intérieur (dans le scope local), mais n'est pas modifiée à l'extérieur (scope global)
    -- OUT : Sortant
            -- Aucune valeur n'est passée via ce param, il sera là pour recevoir une valeur et la transmettre en sortie
            -- Peut être modifié à l'intérieur et sera donc modifié à l'extérieur également 
    -- IN OUT : Les deux 
            -- Une valeur est fournie à la procédure, peut être modifiée et sera également retournée dans le global 

CREATE PROCEDURE addition(IN valeur1 INT, IN valeur2 INT)
BEGIN 
    SELECT valeur1+valeur2; 
END $ 
CALL addition(20, 5)$

-- - Exercice 1/ Faire une procédure stockée qui affiche toutes les informations de tous les employes
CREATE PROCEDURE affiche_tous_les_employes()
BEGIN 
    SELECT * FROM employes; 
END $ 
CALL affiche_tous_les_employes();
-- - Exercice 2/ Faire une procédure qui prends en param le prenom d'un employe et qui affiche le service de l'employé
CREATE PROCEDURE get_info_employe(IN prenom TEXT)
BEGIN
    SELECT * FROM employes WHERE employes.prenom = prenom;
END $ 
CALL get_info_employe("Jean-Pierre")$
-- - Exercice 3/ Faire une procédure qui va d'abord augmenter le salaire de l'employé de 10% suivi d'une augmentation de 700
CREATE PROCEDURE raise_income(IN prenom TEXT)
BEGIN 
    UPDATE employes SET salaire = salaire * 1.1 + 700 WHERE employes.prenom = prenom;
END $ 
CALL raise_income("Emilie");
-- - Exercice 4/ Faire une procédure qui prends en param le prénom et indique de quel groupe il fait parti parmis les groupes suivant 
                        -- Plus de 3000e = Groupe 1 
                        -- Entre 2000 et 3000 = Groupe 2 
                        -- Entre 0 et 2000 = Groupe 3 
CREATE PROCEDURE get_group(IN firstname VARCHAR(255), OUT employegroup VARCHAR(255))
BEGIN 
    DECLARE salary INT; 
    SELECT salaire INTO salary FROM employes WHERE prenom = firstname; 
    IF salary > 3000 THEN SET employegroup = "Groupe 1";
    ELSEIF salary BETWEEN 2000 AND 3000 THEN SET employegroup = "Groupe 2";
    ELSE SET employegroup = "Groupe 3";
    END IF;
END 

CALL get_group("Celine", @employegroup)$
SELECT @employegroup$
CALL get_group("Jean-Pierre", @employegroup)$

