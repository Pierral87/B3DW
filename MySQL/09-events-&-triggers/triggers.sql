-------------------------- TRIGGERS / DECLENCHEURS -------------------------------------------
-- Un Trigger, c'est un peu comme une fonction ou une procédure mais je ne peux pas l'exécuter directement...
-- Par contre je peux préciser l'action qui va déclencher ces instructions 

-- On déclenche généralement les triggers après des requêtes spécifiques, ce qui nous permet de déclencher une action 

USE entreprise; 

-- On crée une table employes_informations qui va contenir un id, un champ nombre représentant le nombre d'employés, un champ derniere_date_embauche qui représentera la date d'embauche du dernier employé 

CREATE TRIGGER maj_info_employes AFTER INSERT ON employes 
FOR EACH ROW 
    BEGIN 
        UPDATE employes_informations SET nombre = nombre +1, derniere_date_embauche = NEW.date_embauche;
    END $ 

-- Ce trigger permet au système de comprendre qu'après une insertion sur la table employes, on doit lancer un UPDATE sur employes_informations, c'est une action qui se déclenchera automatiquement ! Elle va incrémenter nombre et modifier la dernire_date_embauche 
-- le NEW. devant date_embauche correspond à la nouvelle valeur "entrante" c'est à dire la valeur qui correspond à l'action qui déclenche le trigger (celle de l'insertion du nouvel employé)
-- le OLD symboliserait quant à lui, la valeur sortante de dernire_date_embauche  (celle de Stephanie Lafaye avant d'être celle de ma nouvelle insertion)

-- Exercice 1 :  Créer une table "employes_sauvegarde", cette table est identique à employes avec les mêmes champs exactement mais vide !  
        -- Faites en sorte d'inscrire des données dans "employes_sauvegarde" pour toute nouvelle insertion dans la table employes (en plus de la maj dans la table employes_informations) 
CREATE TABLE IF NOT EXISTS employes_sauvegarde (
  id_employes int(4) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  id_secteur int(2) NOT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB;

CREATE TRIGGER save_employes AFTER INSERT ON employes 
FOR EACH ROW 
BEGIN 
    INSERT INTO employes_sauvegarde VALUES (NEW.id_employes, NEW.prenom, NEW.nom, NEW.sexe, NEW.service, NEW.date_embauche, NEW.salaire);
     UPDATE employes_informations SET nombre = nombre +1, derniere_date_embauche = NEW.date_embauche;
END$



-- Exercice 2 : Création d'une table employes_supprime : Pareil, même table que employes, avec des champs vide 
        -- Faites en sorte d'enregistrer tous les employés supprimés (ce sera la table poubelle) 
CREATE TABLE IF NOT EXISTS employes_supprime (
  id_employes int(4) NOT NULL AUTO_INCREMENT,
  prenom varchar(20) DEFAULT NULL,
  nom varchar(20) DEFAULT NULL,
  sexe enum('m','f') NOT NULL,
  service varchar(30) DEFAULT NULL,
  date_embauche date DEFAULT NULL,
  salaire float DEFAULT NULL,
  PRIMARY KEY (id_employes)
) ENGINE=InnoDB $ 

CREATE TRIGGER after_delete_employes AFTER DELETE ON employes 
FOR EACH ROW 
BEGIN 
     INSERT INTO employes_supprime VALUES (OLD.id_employes, OLD.prenom, OLD.nom, OLD.sexe, OLD.service, OLD.date_embauche, OLD.salaire); -- Dans le cas d'un DELETE il n'y a pas de données NEW, seulement des données OLD qui sont celles supprimées, que l'on peut donc réinsérer dans employes_supprime
      UPDATE employes_informations SET nombre = nombre -1;
END$

-- Exercice 3 : Création de la table "employes_salaire" 
      CREATE TABLE IF NOT EXISTS employes_salaire (
  id_employes_salaire int(11) NOT NULL AUTO_INCREMENT,
  id_employes int(11) NOT NULL,
  champ varchar(15) NOT NULL DEFAULT 'salaire',
  ancien int(11) NOT NULL,
  nouveau int(11) NOT NULL,
  difference int(11) NOT NULL,
  date_modification datetime NOT NULL,
  PRIMARY KEY (id_employes_salaire)
) ENGINE=InnoDB ;
    -- Dès que le salaire d'un employé est modifié, nous voulons conserver l'historique des changements de salaire dans cette table (l'ancien, le nouveau, la difference, la date de modif)
CREATE TRIGGER save_update_salary AFTER UPDATE ON employes 
FOR EACH ROW 
BEGIN 
    IF (OLD.salaire <> NEW.salaire) THEN INSERT INTO employes_salaire VALUES (NULL, NEW.id_employes, "salaire", OLD.salaire, NEW.salaire, NEW.salaire - OLD.salaire, NOW());
    END IF; 
END $

-- Exercice 4 : Création d'une table employes_action 
CREATE TABLE IF NOT EXISTS employes_action (
  id_action int(11) NOT NULL AUTO_INCREMENT,
  id_employes int(11) NOT NULL,
  requete enum('update','delete','insert') NOT NULL,
  date_action datetime NOT NULL,
  PRIMARY KEY (id_action)
) ENGINE=InnoDB$ ;
    -- Le but de cet exercice est de repertorier les actions passées sur la table employes (insert, update ou delete)

CREATE PROCEDURE log_action(id_employes INT, requete ENUM("insert","update","delete"))
BEGIN 
    INSERT INTO employes_action (id_employes, requete, date_action) VALUES (id_employes, requete, NOW());
END$

CREATE TRIGGER log_employes_insert AFTER INSERT ON employes 
FOR EACH ROW 
BEGIN 
    CALL log_action(NEW.id_employes, "insert");
END$ 

CREATE TRIGGER log_employes_update AFTER UPDATE ON employes 
FOR EACH ROW 
BEGIN 
    CALL log_action(NEW.id_employes, "update");
END$ 

CREATE TRIGGER log_employes_delete AFTER DELETE ON employes 
FOR EACH ROW 
BEGIN 
    CALL log_action(OLD.id_employes, "delete");
END$ 