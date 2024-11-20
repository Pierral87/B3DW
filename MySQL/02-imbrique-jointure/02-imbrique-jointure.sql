CREATE DATABASE bibliotheque;
USE bibliotheque;

CREATE TABLE abonne (
  id_abonne INT(3) NOT NULL AUTO_INCREMENT,
  prenom VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_abonne)
) ENGINE=InnoDB ;

INSERT INTO abonne (id_abonne, prenom) VALUES
(1, 'Guillaume'),
(2, 'Benoit'),
(3, 'Chloe'),
(4, 'Laura');


CREATE TABLE livre (
  id_livre INT(3) NOT NULL AUTO_INCREMENT,
  auteur VARCHAR(25) NOT NULL,
  titre VARCHAR(30) NOT NULL,
  PRIMARY KEY (id_livre)
) ENGINE=InnoDB ;

INSERT INTO livre (id_livre, auteur, titre) VALUES
(100, 'GUY DE MAUPASSANT', 'Une vie'),
(101, 'GUY DE MAUPASSANT', 'Bel-Ami '),
(102, 'HONORE DE BALZAC', 'Le pere Goriot'),
(103, 'ALPHONSE DAUDET', 'Le Petit chose'),
(104, 'ALEXANDRE DUMAS', 'La Reine Margot'),
(105, 'ALEXANDRE DUMAS', 'Les Trois Mousquetaires');

CREATE TABLE emprunt (
  id_emprunt INT(3) NOT NULL AUTO_INCREMENT,
  id_livre INT(3) DEFAULT NULL,
  id_abonne INT(3) DEFAULT NULL,
  date_sortie DATE NOT NULL,
  date_rendu DATE DEFAULT NULL,
  PRIMARY KEY  (id_emprunt)
) ENGINE=InnoDB ;

INSERT INTO emprunt (id_emprunt, id_livre, id_abonne, date_sortie, date_rendu) VALUES
(1, 100, 1, '2016-12-07', '2016-12-11'),
(2, 101, 2, '2016-12-07', '2016-12-18'),
(3, 100, 3, '2016-12-11', '2016-12-19'),
(4, 103, 4, '2016-12-12', '2016-12-22'),
(5, 104, 1, '2016-12-15', '2016-12-30'),
(6, 105, 2, '2017-01-02', '2017-01-15'),
(7, 105, 3, '2017-02-15', NULL),
(8, 100, 2, '2017-02-20', NULL);

-- Quels sont les id_livre des livres qui n'ont pas été rendu à la bibliothèque ? 
SELECT id_livre FROM emprunt WHERE date_rendu IS NULL;
+----------+
| id_livre |
+----------+
|      105 |
|      100 |
+----------+
-- ATTENTION la valeur NULL se texte avec IS ou IS NOT 

-- Pour avoir les titres des livres, il faut que je puisse aller les piocher sur une autre table 
-- 2 possibilités : 
    -- Les requêtes imbriquées
    -- Les requêtes en jointure 

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
----------- REQUETES IMBRIQUEES (sur plusieurs tables) ----------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Quels sont les titres des livres qui n'ont pas été rendu à la bibliothèque ? 

-- SELECT titre FROM livre WHERE id_livre = (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);
-- Ici la requête entre parenthèse répond à un besoin de la requête précédente
-- Dans le cas d'une requête imbriquée, le résultat affiché à l'utilisateur sera le premier SELECT (en gros, la première requête envoyée sera celle qui sera affichée à l'utilisateur)
SELECT titre FROM livre WHERE id_livre IN 
        (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL);
-- Dans ce cas précis, le = ne fonctionne pas car la sous requête nous renvoie plus d'un résultat, je suis alors obligé d'utiliser IN qui me permet de traiter un ensemble de résultat 

-- EXERCICE 1: Quels sont les prénoms des abonnés n'ayant pas rendu un livre à la bibliotheque.
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt WHERE date_rendu IS NULL);
-- EXERCICE 2 : Nous aimerions connaitre le(s) n° des livres empruntés par Chloé
SELECT id_livre FROM emprunt WHERE id_abonne = 
    (SELECT id_abonne FROM abonne WHERE prenom = "Chloe");
-- EXERCICE 3: Affichez les prénoms des abonnés ayant emprunté un livre le 07/12/2016.
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt WHERE date_sortie = "2016-12-07");
-- EXERCICE 4: combien de livre Guillaume a emprunté à la bibliotheque ?
SELECT COUNT(*) AS nombre_emprunts FROM emprunt WHERE id_abonne = 
    (SELECT id_abonne FROM abonne WHERE prenom = "Guillaume");
-- EXERCICE 5: Affichez la liste des abonnés ayant déjà emprunté un livre d'Alphonse Daudet
SELECT * FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt WHERE id_livre IN 
        (SELECT id_livre FROM livre WHERE auteur = "Alphonse Daudet"));
-- EXERCICE 6: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque.
SELECT titre FROM livre WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne IN
        (SELECT id_abonne FROM abonne WHERE prenom = "Chloe")); 
-- EXERCICE 7: Nous aimerions connaitre les titres des livres que Chloe n'a pas emprunté à la bibliotheque.
SELECT titre FROM livre WHERE id_livre NOT IN 
    (SELECT id_livre FROM emprunt WHERE id_abonne IN
        (SELECT id_abonne FROM abonne WHERE prenom = "Chloe"));
-- EXERCICE 8: Nous aimerions connaitre les titres des livres que Chloe a emprunté à la bibliotheque ET qui n'ont pas été rendu.
SELECT titre FROM livre WHERE id_livre IN 
    (SELECT id_livre FROM emprunt WHERE date_rendu IS NULL AND id_abonne IN
        (SELECT id_abonne FROM abonne WHERE prenom = "Chloe"));
-- EXERCICE 9 :  Qui a emprunté le plus de livre à la bibliotheque ?
SELECT prenom FROM abonne WHERE id_abonne IN 
    (SELECT id_abonne FROM emprunt GROUP BY id_abonne HAVING COUNT(*) = 
        (SELECT MAX(borrow_count) FROM (SELECT COUNT(*) AS borrow_count FROM emprunt GROUP BY id_abonne) AS count));

SELECT prenom FROM abonne WHERE id_abonne = 
    (SELECT id_abonne FROM emprunt GROUP BY id_abonne ORDER BY COUNT(*) DESC LIMIT 1);

    -- SELECT borrow_count FROM (SELECT COUNT(*) AS borrow_count FROM emprunt GROUP BY id_abonne) AS count



-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
----------- REQUETES en JOINTURE (sur plusieurs tables) ---------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Une jointure est toujours possible, on pourra toujours afficher des champs de diverses tables
-- Une imbriquée est possible uniquement si les champs que l'on récupère proviennent d'une seule table 

-- Avec les requêtes imbriquées, on parcourt les tables une à une
-- Avec les requêtes en jointure, on mélange les champs de sortie, les tables, les conditions sans que cela pose problème 

-- Nous aimerions connaitre les dates de sortie et les dates de rendu pour l'abonne Guillaume 

SELECT prenom, date_sortie, date_rendu -- Ce que je veux afficher, venant de diverses tables, pas un soucis 
FROM emprunt, abonne -- Les tables que j'ai besoin d'utiliser 
WHERE prenom = "Guillaume"
AND abonne.id_abonne = emprunt.id_abonne; -- jointure ici, on indique la correspondance du champ commun entre les deux tables 
-- Lorsqu'un champ a le meme nom sur plusieurs table, il est bon de préciser la table en préfixe du champ, comme ici abonne.id_abonne 
-- +-----------+-------------+------------+
-- | prenom    | date_sortie | date_rendu |
-- +-----------+-------------+------------+
-- | Guillaume | 2016-12-07  | 2016-12-11 |
-- | Guillaume | 2016-12-15  | 2016-12-30 |
-- | Guillaume | 2024-11-20  | NULL       |
-- +-----------+-------------+------------+

-- On peut indiquer des alias de table pour raccourci l'écriture des jointures et l'appel des champs 
SELECT a.prenom, e.date_sortie, e.date_rendu  -- Pour éviter les erreurs d'ambiguité sur des champs avec des noms similaires dans des tables différentes, il est bon de spécifié le nom de la table avant l'appel du champ 
FROM emprunt e, abonne a -- Ici on indique que la table emprunt peut être nommée e et abonne a 
WHERE prenom = "Guillaume"
AND a.id_abonne = e.id_abonne;

-- Autre syntaxe avec INNER JOIN 
SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
INNER JOIN abonne a ON e.id_abonne = a.id_abonne
WHERE a.prenom = "Guillaume";

SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
JOIN abonne a ON e.id_abonne = a.id_abonne
WHERE a.prenom = "Guillaume";

SELECT a.prenom, e.date_sortie, e.date_rendu 
FROM emprunt e 
JOIN abonne a USING (id_abonne)
WHERE a.prenom = "Guillaume";

-- EXERCICE 1 : Nous aimerions connaitre les dates de sortie et les dates de rendu pour les livres écrit par Alphonse Daudet 
SELECT auteur, titre, date_sortie, date_rendu 
FROM livre 
JOIN emprunt USING (id_livre)
WHERE auteur = "Alphonse Daudet";
-- EXERCICE 2 : Qui a emprunté le livre "une vie" sur l'année 2016 
SELECT prenom, titre, date_sortie 
FROM abonne 
JOIN emprunt ON emprunt.id_abonne = abonne.id_abonne 
JOIN livre ON livre.id_livre = emprunt.id_livre 
WHERE livre.titre = "une vie" 
AND date_sortie BETWEEN "2016-01-01" AND "2016-12-31";
-- EXERCICE 3 : Nous aimerions connaitre le nombre de livre emprunté par chaque abonné 
SELECT a.prenom, COUNT(*) AS nombre_livres 
FROM abonne a 
JOIN emprunt e USING (id_abonne)
GROUP BY a.prenom;
-- EXERCICE 4 : Nous aimerions connaitre le nombre de livre emprunté à rendre par chaque abonné 
SELECT prenom, COUNT(*) AS livre_a_rendre 
FROM abonne 
JOIN emprunt USING (id_abonne) 
WHERE date_rendu IS NULL 
GROUP BY prenom;

SELECT prenom, COUNT(id_emprunt) AS livre_a_rendre 
FROM abonne a 
LEFT JOIN emprunt e ON e.id_abonne = a.id_abonne
AND date_rendu IS NULL 
GROUP BY prenom;

SELECT prenom, COUNT(id_emprunt) AS livre_a_rendre 
FROM abonne a 
LEFT JOIN emprunt e ON e.id_abonne = a.id_abonne
WHERE date_rendu IS NULL 
GROUP BY prenom;



-- EXERCICE 5 : Qui (prenom) a emprunté Quoi (titre) et Quand (date_sortie) ?
SELECT a.prenom, l.titre, e.date_sortie 
FROM emprunt e 
JOIN abonne a USING (id_abonne) 
JOIN livre l USING (id_livre);


-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
----------- REQUETES en JOINTURE EXTERNE ------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- Enregistrez vous dans la table (rajoutez un abonné)
INSERT INTO abonne (prenom) VALUES ("Pierra");
-- +-----------+-----------+
-- | id_abonne | prenom    |
-- +-----------+-----------+
-- |         1 | Guillaume |
-- |         2 | Benoit    |
-- |         3 | Chloe     |
-- |         4 | Laura     |
-- |         5 | Pierra    |
-- +-----------+-----------+

-- Affichons tous les prénoms des abonnés SANS EXCEPTION ainsi que les id_livre qu'ils ont emprunté si c'est le cas 
SELECT prenom, id_livre 
FROM abonne a
JOIN emprunt e USING (id_abonne);
-- +-----------+----------+
-- | prenom    | id_livre |
-- +-----------+----------+
-- | Guillaume |      100 |
-- | Benoit    |      101 |
-- | Chloe     |      100 |
-- | Laura     |      103 |
-- | Guillaume |      104 |
-- | Benoit    |      105 |
-- | Chloe     |      105 |
-- | Benoit    |      100 |
-- | Guillaume |      100 |
-- +-----------+----------+

-- On ne voit pas le nouvel utilisateur Pierra 
-- Pourquoi ? Car les jointures faites jusqu'à présent sont des jointures INTERNES et donc ne sortent QUE les résultats qui ont des correspondances dans les deux tables (à savoir dans notre cas ici les abonnés qui ont des emprunts)
-- Si on veut aussi les abonnés n'ayant pas d'emprunts, on doit faire une jointure EXTERNE 
-- Jointure externe : LEFT JOIN ou RIGHT JOIN 

-- LEFT ou RIGHT : Même fonctionnalité SAUF que on donne la priorité dans le sens de la jointure  
SELECT prenom, id_livre 
FROM abonne LEFT JOIN emprunt USING (id_abonne); -- ici avec un LEFT JOIN on considère que c'est de la table abonné que l'on souhaite l'entièreté des informations (meme sans correspondance)

SELECT prenom, id_livre 
FROM emprunt RIGHT JOIN abonne USING (id_abonne); -- Même requête mais ici avec un RIGHT JOIN, car on a écrit la table abonne en dernier ! Donc le RIGHT JOIN donne la priorité à la table citée en dernier 

-- On remarque bien ici l'apparition de l'abonné Pierra, même s'il n'a pas d'emprunt 
+-----------+----------+
| prenom    | id_livre |
+-----------+----------+
| Guillaume |      100 |
| Guillaume |      104 |
| Guillaume |      100 |
| Benoit    |      100 |
| Benoit    |      105 |
| Benoit    |      101 |
| Chloe     |      105 |
| Chloe     |      100 |
| Laura     |      103 |
| Pierra    |     NULL |
+-----------+----------+

-- EXERCICE 1 : Affichez tous les livres sans exception puis les id_abonne ayant emprunté ces livres si c'est le cas
SELECT livre.id_livre, livre.titre, emprunt.id_abonne 
FROM livre 
LEFT JOIN emprunt ON livre.id_livre = emprunt.id_livre ;
-- EXERCICE 2 : Affichez tous les prénoms des abonnés et s'ils ont fait des emprunts, affichez les id_livre, auteur et titre
SELECT a.prenom, l.id_livre, l.auteur, l.titre 
FROM abonne a 
LEFT JOIN emprunt e USING (id_abonne) 
LEFT JOIN livre l USING (id_livre);
-- EXERCICE 3 : Affichez tous les prénoms des abonnés et s'ils ont fait des emprunts, affichez les id_livre, auteur et titre ainsi que les livres non empruntés :)
SELECT prenom, id_livre, auteur, titre 
FROM abonne a 
LEFT JOIN emprunt e USING (id_abonne) 
LEFT JOIN livre l USING (id_livre)
UNION 
SELECT prenom, id_livre, auteur, titre
FROM abonne a 
RIGHT JOIN emprunt e USING (id_abonne) 
RIGHT JOIN livre l USING (id_livre);


SELECT prenom, livre.id_livre, livre.auteur, livre.titre
FROM abonne
LEFT JOIN emprunt ON abonne.id_abonne = emprunt.id_abonne
LEFT JOIN livre ON emprunt.id_livre = livre.id_livre
UNION
SELECT abonne.prenom, id_livre, auteur, titre
FROM livre
LEFT JOIN emprunt ON livre.id_livre = emprunt.id_livre
LEFT JOIN abonne ON emprunt.id_abonne = abonne.id_abonne;
-- ERROR 1052 (23000): Champ: 'id_livre' dans field list est ambigu
-- Si erreur ambigu, il faut rajouter les prefixes de table aux champs 


SELECT prenom, livre.id_livre, livre.auteur, livre.titre
FROM abonne
LEFT JOIN emprunt USING (id_abonne) 
LEFT JOIN livre  USING (id_livre)
UNION
SELECT abonne.prenom, id_livre, auteur, titre
FROM livre
LEFT JOIN emprunt  USING (id_livre)
LEFT JOIN abonne USING (id_abonne) ;