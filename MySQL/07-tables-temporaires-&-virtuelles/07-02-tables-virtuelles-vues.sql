------------------------ TABLES VIRTUELLES - VUES -----------------------------------
USE entreprise;
CREATE VIEW employes_homme AS SELECT prenom, nom, sexe, service FROM employes WHERE sexe="m";

-- 
SHOW TABLES;
-- le SHOW TABLES me montre bien la présence de ma vue employes_homme comme si c'était une vraie table !
-- Je peux ensuite l'interroger comme une table classique 
SELECT * FROM employes_homme;
+-------------+---------+------+--------------+
| prenom      | nom     | sexe | service      |
+-------------+---------+------+--------------+
| Jean-pierre | Laborde | m    | direction    |
| Clement     | Gallet  | m    | commercial   |
| Thomas      | Winter  | m    | commercial   |
| Fabrice     | Grand   | m    | comptabilite |
| Guillaume   | Miller  | m    | commercial   |
| Mathieu     | Vignal  | m    | informatique |
| Damien      | Durand  | m    | informatique |
| Daniel      | Chevel  | m    | informatique |
| Benoite     | Lagarde | m    | production   |
+-------------+---------+------+--------------+


---
USE bibliotheque;

-- Ici je crée une vue contenant la jointure de mes trois tables me permettant d'afficher directement le prenom associé à un livre et une date de sortie
-- Cela m'évite de faire à chaque fois la jointure pour appeler ce jeu de résultat là 
CREATE VIEW vue_emprunt AS 
    SELECT a.prenom, l.titre, e.date_sortie 
    FROM abonne a, livre l, emprunt e 
    WHERE a.id_abonne = e.id_abonne 
    AND l.id_livre = e.id_livre ORDER BY prenom;


SELECT * FROM vue_emprunt;
SELECT * FROM vue_emprunt WHERE prenom = "Benoit";

-- ATTENTION -- Une vue est rattachée aux données réelles !!! Une modification/suppression sur une vue, va affecter directement les vraies données ! 


-- Résumé : 
-- Une vue est une table virtuelle qui contient tout comme une table temporaire, le résultat d'une requête SQL. Par contre ! On la définie une fois et elle sera persistante sur notre système ! Je peux la réutiliser comme une vraie table.
-- La vue ne stocke pas de données physiquement (taille 0 visible dans le php my admin), mais elle présente un résultat calculé à chaque fois qu'elle est intérrogée 

-- Intérêts : 
        -- Simplifie les requêtes complexe en offrant une nouvelle table contenant déjà le résultat de cette requête et que l'on peut réinterroger 
        -- Elle sécurise les données en limitant l'accès à certains champs sensibles (comme les password, les salaires ou autre)
        -- Réutilisabilité de données, car une fois créée la vue persiste 

-- Inconvénients : 
        -- Moins performants, car elle recalcule le résultat à chaque appel (du fait que les données ne soient pas dupliquées)