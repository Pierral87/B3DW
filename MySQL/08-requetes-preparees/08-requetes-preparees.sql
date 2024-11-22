------------------ REQUETE PREPAREE ---------------------------------

    -- Cycle : Analyse de requête / Interpretation / Execution

    -- Dans un premier temps, on fournit la requête on système. Elle va être analysée et mémorisée
    -- Second temps, interprétation de la requête préparer en fonction des éléments fournit (plusieurs param à fournir à la requête)
    -- Dernière étape, exécution de la requête 

    
    -- Une requête non préparée : 



-- La requête ci dessous me permet de récupérer les informations de Jean-Pierre, Jean-Pierre étant une valeur supposée reçu d'un formulaire HTML
    SELECT * FROM employes WHERE prenom = "Jean-Pierre";

-- Par contre libre à l'utilisateur de tenter une injection SQL
    -- Une injection = une tentative d'attaque sur ma bdd en ajoutant une requête dans une autre 
        -- l'utilisateur pourrait saisir  "; DROP DATABASE entreprise; --    pour clôturer la requête en cours et lancer une requête de supprimer de base de données 
    SELECT * FROM employes WHERE prenom = ""; DROP DATABASE entreprise; --";


-- La requête préparée me permet de me protéger de ce genre d'attaque car elle va filtrer les params reçus pour empêcher d'interpreter de nouvelles instructions 

-- Ici je prépare une requête étant SELECT * FROM employes WHERE prenom = "qqchoz que je vais fournir dans un second temps"
PREPARE req1 FROM "SELECT * FROM employes WHERE prenom=?"; 
    SET @prenom ='Jean-pierre'; -- Variable supposée récupérée d'un formulaire
    EXECUTE req1 USING @prenom;


PREPARE req2 FROM "INSERT INTO employes (prenom) VALUES (?)"; 
    SET @prenom2 ="'; DROP DATABASE entreprise;" --'; -- Variable supposée récupérée d'un formulaire
 EXECUTE req2 USING @prenom2;



    