------------------------------ Gestion des accès utilisateurs en MySQL ------------------------------------

-- En dehors des accès que l'on peut ouvrir/fermer dans notre front/back, on peut aussi appliquer des notions de sécurité dans notre BDD 
-- Notamment en gérant des comptes utilisateurs avec des accès bien spécifiques pour leurs roles 
-- Depuis le début on utilise root, c'est le superadmin de notre bdd avec tous les droits
    -- SURTOUT NE JAMAIS UTILISER ROOT SUR UN VRAI PROJET !!!!
        -- On fera toujours en sorte de créer des comptes utilisateurs avec uniquement les droits dont ils ont besoin 

-- Chaque utilisateur dans notre système doit avoir des droits (privilèges) pour exécuter n'importe quel type de requête 

-- Pour créer un utilisateur : 

-- CREATE USER 'nomduuser'@'host' IDENTIFIED BY 'monpassword'
-- Création de l'utilisateur pierra avec son password
    CREATE USER 'pierra'@'localhost'  IDENTIFIED BY 'azerty';


-- On donne (avec root) les droits à pierra sur entreprise table employes SELECT, INSERT, DELETE et UPDATE uniquement sur le champ service
-- Si je voulais donner les droits sur toutes les tables j'écrirais entreprise.*    ou bien sur toutes les bases toutes les tables j'écrirais *.* 
-- Si je veux donner tous les accès j'écrirais GRANT ALL 
    GRANT SELECT, INSERT, DELETE, UPDATE(service) 
        ON entreprise.employes 
        TO 'pierra'@'localhost';


       

      -- Pour supprimer un utilisateur : DROP USER 'pierra'@'localhost';  

-- FLUSH PRIVILEGES; permet de mettre à jour et valider les droits (sinon ils ne sont pas encore mis en place)
    FLUSH PRIVILEGES;

-- Limitations des ressources 
    -- MAX_QUERIES_PER_HOUR : Le nombre de requetes qu'il peut exécuter par heure 
    -- MAX_UPDATES_PER_HOUR : Le nombre de modif qu'il peut executer par heure
    -- MAX_CONNECTIONS_PER_HOUR : Le nombre de fois qu'il peut se connecter à notre serveur 

-- Attention si on fait cette manip avec la console, c'est au moment de créer le user qu'on lui donne le max ressources qu'il peut utiliser 
    --   CREATE USER 'lolo'@'localhost'  IDENTIFIED BY 'azerty'
    --      WITH MAX_QUERIES_PER_HOUR 5;



    CREATE USER 'bobo'@'localhost'  IDENTIFIED BY 'azerty';
        GRANT ALL
        ON entreprise.employes 
        TO 'bobo'@'localhost';
    FLUSH PRIVILEGES;


-- EXERCICE : 

USE entreprise; 

-- Créer les comptes utilisateur suivants : 
        -- secretaire : avec le password de votre choix, on lui attribue le privilège de lecture sur les champs suivants id_employes, nom, prenom, sexe, service sur la table employes 
        CREATE USER 'secretaire2'@'localhost'  IDENTIFIED BY 'azerty';
        GRANT SELECT(id_employes, nom, prenom, sexe, service) 
        ON entreprise.employes 
        TO 'secretaire2'@'localhost';
        -- directeur : avec le password de votre choix, on lui attribue les privilèges suivants : selection, modification, insertion, suppression sur la bdd entreprise en plus des droits d'attribution de droits à d'autres utilisateurs 
         CREATE USER 'directeur2'@'localhost'  IDENTIFIED BY 'azerty';
        GRANT SELECT, UPDATE, INSERT, DELETE, GRANT OPTION
        ON entreprise.employes 
        TO 'directeur2'@'localhost';
        -- informaticien : mot de passe au choix, donnez lui tous les droits mais une limitation de ressources à 10 requêtes maximum par heure et un nombre de connexion de 6 maximum par heure 
        CREATE USER 'informaticien2'@'localhost'  IDENTIFIED BY 'azerty'
        WITH MAX_QUERIES_PER_HOUR 10 
        MAX_CONNECTIONS_PER_HOUR 6;
        GRANT ALL
        ON entreprise.employes 
        TO 'informaticien2'@'localhost';

        FLUSH PRIVILEGES;

    -- Déconnectez vous du compte root, et connectez vous en tant que secrétaire et répondre aux requêtes suivantes : 
            -- 1 -- Afficher la profession de l'employé 417
            SELECT service FROM employes WHERE id_employes = 417;
            -- 2 -- Afficher le nombre de commerciaux 
            SELECT COUNT(*) AS nombre_commerciaux FROM employes WHERE service = "commercial";
            -- 3 -- Afficher le nombre de services différents 
            SELECT COUNT(DISTINCT service) FROM employes;
            -- 4 -- Augmenter le salaire de chaque employés de 100 euros 
            UPDATE employes SET salaire = salaire + 100;

    -- Déconnectez vous du compte secrétaire et connectez vous en tant que directeur et répondre aux requêtes suivantes : 
            -- 1 -- Afficher la date d'embauche de Amandine 
            SELECT date_embauche FROM employes WHERE prenom = "Amandine";
            -- 2 -- Afficher le salaire moyen par service 
            SELECT AVG(salaire) AS salaire_moyen, service FROM employes GROUP BY service;
            -- 3 -- Afficher les informations de l'employé du service commercial gagnant le salaire le plus élevé 
            SELECT * FROM employes WHERE service = "commercial" ORDER BY salaire DESC LIMIT 1;

    -- Déconnectez vous de directeur, connectez vous comme informaticien
            -- 1 -- Lancez plusieurs requêtes pour tester le maximum de requêtes autorisées
            -- 2 -- Reconnectez vous plusieurs fois pour tester le nombre de connexion autorisées 