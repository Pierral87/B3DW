--------------- TABLES TEMPORAIRES ---------------------------

USE entreprise;
CREATE TEMPORARY TABLE commerciaux AS SELECT * FROM employes WHERE service = "commercial";

SHOW TABLES;
-- Cette table n'est pas visible dans SHOW TABLES, pourtant elle existe bien
SELECT * FROM commerciaux;
-- La requête ci dessus me retourne bien les commerciaux uniquement, c'est une nouvelle table (mais temporaire) qui contient uniquement les employés du service commercial

----- Une table temporaire est une table qui existe uniquement pendant la durée d'une session ou d'une transaction.
-- Elle est créée pour stocker temporairement des résultats intermédiaires lors d'un traitement complexe, si jamais on avait besoin de ensuite réinterpréter ce jeu de résultat.
-- Une fois la session terminée, la table est automatiquement supprimée ! 

-- ATTENTION, les données d'une table temporaires ne sont plus liées aux données réelles, c'est à dire si j'applique une modification aux données de ma table temporaire, cela n'impactera pas les données de ma table réelle 

