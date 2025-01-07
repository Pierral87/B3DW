/* 

Projet SQL : Création d'une base de données pour un e-shop sécurisé
Contexte

Votre mission est de concevoir une base de données pour un e-shop permettant de gérer les produits, les utilisateurs, les commandes, les évaluations, les commentaires, et les coupons. Ce projet mettra en œuvre vos compétences en modélisation, création et manipulation de bases de données relationnelles, tout en intégrant des notions de sécurité et d’optimisation.
Objectifs pédagogiques

    Comprendre les principes de modélisation relationnelle et les appliquer dans un contexte réaliste.
    Concevoir une base de données relationnelle complexe avec des relations de différents types (1-N, N-N).
    Manipuler les bases de données avec des commandes SQL pour effectuer des opérations courantes.
    Intégrer des notions de sécurité (contraintes, relations clés étrangères, gestion des accès).

Étapes du projet :

-----------------------------------------------------------------------------------------------
Étape 1 : Analyse des besoins et modélisation

    Voici ce qui ressort de notre entretien avec le client :
        Les utilisateurs doivent pouvoir s’inscrire et se connecter.
        Les produits sont organisés en catégories (hiérarchiques, c'est à dire on peut gérer des sous-catégories).
        Les utilisateurs peuvent passer des commandes avec des détails précis.
        Les clients peuvent laisser des notations et des commentaires sur les produits.
        Les administrateurs peuvent proposer des coupons de réduction.
    Identifiez les entités principales ainsi que leurs relations
-----------------------------------------------------------------------------------------------

Étape 2 : Modélisation de la base de données

    Construisez le modèle relationnel à partir des entités identifiées :
        Déterminez les clés primaires et les clés étrangères pour chaque table, les types de chaque champs.
        Ajoutez des contraintes.
    Prévoyez les relations spécifiques :
        Notations et commentaires (relation entre utilisateurs et produits).
        Hiérarchies dans les catégories.
        Utilisation de coupons dans les commandes.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!! Livrable attendu : Un diagramme UML montrant les tables, leurs colonnes, et leurs relations. !!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-----------------------------------------------------------------------------------------------

Étape 3 : Création des tables

    Créez vos tables, à la main ou dans PHPMyAdmin, définissez la totalité des relations, les clés etc.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!! Livrable attendu : Un export de la BDD (via PhpMyAdmin) au format .sql  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-----------------------------------------------------------------------------------------------

Étape 4 : Insérer des données

    Ajoutez des utilisateurs, des produits, des catégories, des commandes, etc., pour tester votre base.
    Veillez à insérer des données cohérentes (exemple : un utilisateur laisse un commentaire uniquement sur un produit qu’il a acheté).
    Ajoutez des coupons et liez-les à des commandes.
-----------------------------------------------------------------------------------------------

Étape 5 : Sécurisation et optimisation

    Vérifiez que toutes les relations entre les tables sont respectées grâce aux clés étrangères.
    Définissez des index sur les champs qui vous semblent judicieux
    Proposez des idées pour améliorer la sécurité de la BDD

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!! Livrable attendu : Un document expliquant les mesures de sécurisation prises !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-----------------------------------------------------------------------------------------------

Étape 6 : Manipulation des données

Réalisez les requêtes SQL suivantes :

1. Gestion des utilisateurs

    Inscription d’un nouvel utilisateur :
        Définir LES requêtes nécessaires au bon déroulement d'une inscription utilisateur.

    Connexion d’un utilisateur :
        Écrivez la requête qui va permettre de retrouver l'utilisateur qui tente de se connecter

    Liste des utilisateurs inscrits :
        Écrivez une requête pour afficher tous les utilisateurs, triés par date d’inscription du plus récent au plus ancien.

2. Gestion des produits et catégories

    Affichage des produits :
        Écrivez une requête pour afficher tous les produits avec leur catégorie, triés par nom.

    Filtrage par catégorie :
        Écrivez une requête pour afficher les produits appartenant à une catégorie spécifique.

    Recherche de produit :
        Écrivez une requête pour afficher les produits dont le nom contient un mot-clé donné.

    Produits les mieux notés :
        Écrivez une requête pour afficher les 5 produits ayant la meilleure note moyenne.

    Ajout d’un produit (admin) :
        Écrivez une requête pour insérer un nouveau produit avec son nom, sa description, son prix, sa catégorie et son stock.

3. Gestion des commandes

    Création d’une commande :
        Écrivez les requêtes pour insérer une nouvelle commande pour un utilisateur donné.

    Ajout de produits à une commande :
        Écrivez une requête pour ajouter un produit à une commande existante avec une quantité et un prix.

    Historique des commandes d’un utilisateur :
        Écrivez une requête pour afficher toutes les commandes passées par un utilisateur, avec la date, le statut, et les détails des produits.

    Commandes en attente (admin) :
        Écrivez une requête pour afficher les commandes ayant le statut "en cours de traitement".

4. Gestion des évaluations et des commentaires

    Ajout d’une évaluation :
        Écrivez une requête pour insérer une évaluation d’un produit par un utilisateur, avec une note et un commentaire.

    Affichage des commentaires pour un produit :
        Écrivez une requête pour afficher tous les commentaires pour un produit donné, triés par date.

    Moyenne des notes d’un produit :
        Écrivez une requête pour calculer la moyenne des notes d’un produit donné.

5. Gestion des coupons

    Ajout d’un coupon (admin) :
        Écrivez une requête pour insérer un nouveau coupon avec son code, sa réduction et sa date d’expiration.

    Utilisation d’un coupon dans une commande :
        Écrivez une requête pour associer un coupon à une commande existante.

    Affichage des coupons expirés (admin) :
        Écrivez une requête pour afficher les coupons dont la date d’expiration est passée.

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!! Livrable attendu : Un fichier SQL contenant toutes les requêtes demandées. !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




*/


/*

SOLUTION : 

Modelisation --- Voir image
-----------------------------------------------------------------
Contraintes : 

1. User → Orders (relation 1:N)
    Contrainte :
        ON DELETE SET NULL : Si un utilisateur est supprimé, ses commandes restent dans le système pour traçabilité.
        ON UPDATE CASCADE : Si l'ID utilisateur change (rare, mais possible), il est mis à jour dans les commandes.

2. Orders → OrderItem (relation 1:N)
    Contrainte :
        ON DELETE CASCADE : Si une commande est supprimée, ses articles doivent être supprimés également.
        ON UPDATE CASCADE : Si l'ID de la commande change, il est propagé aux articles.

3. Product → OrderItem (relation 1:N)
    Contrainte :
        ON DELETE RESTRICT : Empêche la suppression d’un produit si des articles de commande y font référence.
        ON UPDATE CASCADE : Si l’ID du produit change, il est propagé aux articles de commande.

4. Category → Product (relation 1:N)
    Contrainte :
        ON DELETE SET NULL : Si une catégorie est supprimée, les produits sont dissociés de leur catégorie.
        ON UPDATE CASCADE : Si l'ID de la catégorie change, il est propagé aux produits.

5. Category → Category (parent ↔ sous-catégorie)
    Contrainte :
        ON DELETE SET NULL : Si une catégorie parente est supprimée, ses sous-catégories deviennent des catégories racines.
        ON UPDATE CASCADE : Si l'ID de la catégorie parente change, il est mis à jour dans les sous-catégories.

6. Product → Review (relation 1:N)
    Contrainte :
        ON DELETE CASCADE : Si un produit est supprimé, ses avis/commentaires sont supprimés.
        ON UPDATE CASCADE : Si l’ID du produit change, il est propagé dans les avis.

7. User → Review (relation 1:N)
    Contrainte :
        ON DELETE SET NULL : Si un utilisateur est supprimé, ses avis restent pour traçabilité.
        ON UPDATE CASCADE : Si l'ID utilisateur change, il est propagé aux avis.

8. Orders → Coupon (relation N:1)
    Contrainte :
        ON DELETE SET NULL : Si un coupon est supprimé, les commandes qui l'utilisent ne sont pas impactées.
        ON UPDATE CASCADE : Si l'ID du coupon change, il est propagé dans les commandes.
----------------------------------------------------------------
Sécu/Optimisation --- Voir .txt
-----------------------------------------------------------------
Requêtes : 

1. Gestion des utilisateurs -----
-- Inscription
Verification d'abord de la disponibilité de l'email via une requete SELECT et un COUNT (ou rowCount en PDO)
INSERT INTO User (name, email, password, role) 
VALUES ('Pierra', 'pierra@mail.com', $hashedpassword, 'client');

-- Connexion
SELECT * FROM User 
WHERE email = 'pierra@mail.com';
Vérification d'un password dans un second temps par rapport au password hashé

-- Liste des utilisateurs
SELECT * FROM User 
ORDER BY created_at DESC;

2. Gestion des produits et catégories -----
-- Affichage des produits
SELECT Product.name, Product.price, Category.name AS category_name 
FROM Product 
INNER JOIN Category ON Product.category_id = Category.id_category 
ORDER BY Product.name;

-- Filtrage par catégorie
SELECT * FROM Product 
WHERE category_id = 2;

-- Recherche de produit
SELECT * FROM Product 
WHERE name LIKE '%keyword%';

-- Produits les mieux notés
SELECT Product.name, AVG(Review.rating) AS avg_rating 
FROM Product 
INNER JOIN Review ON Product.id_product = Review.product_id 
GROUP BY Product.id_product 
ORDER BY avg_rating DESC 
LIMIT 5;

-- Ajout d’un produit
INSERT INTO Product (name, description, price, category_id, stock) 
VALUES ('Produit A', 'Description A', 19.99, 1, 100);

3. Gestion des commandes -----
-- Création d’une commande
INSERT INTO Orders (user_id, status) 
VALUES (1, 'en cours de traitement');

-- Ajout de produits à une commande
INSERT INTO OrderItem (order_id, product_id, quantity, price) 
VALUES (1, 2, 3, 29.99);

-- Historique des commandes d’un utilisateur
SELECT Orders.id_order, Orders.created_at, Orders.status, Product.name, OrderItem.quantity 
FROM Orders 
INNER JOIN OrderItem ON Orders.id_order = OrderItem.order_id 
INNER JOIN Product ON OrderItem.product_id = Product.id_product 
WHERE Orders.user_id = 1;

-- Commandes en attente
SELECT * FROM Orders 
WHERE status = 'en cours de traitement';

4. Gestion des évaluations et des commentaires -----
-- Ajout d’une évaluation
INSERT INTO Review (user_id, product_id, rating, comment) 
VALUES (1, 2, 5, 'Excellent produit !');

-- Affichage des commentaires
SELECT User.name AS user_name, Review.comment, Review.rating, Review.created_at 
FROM Review 
INNER JOIN User ON Review.user_id = User.id_user 
WHERE product_id = 2 
ORDER BY Review.created_at DESC;

-- Moyenne des notes
SELECT AVG(rating) AS avg_rating 
FROM Review 
WHERE product_id = 2;

5. Gestion des coupons -----
-- Ajout d’un coupon
INSERT INTO Coupon (code, discount, expires_at) 
VALUES ('PROMO10', 10, '2024-12-31');

-- Utilisation d’un coupon
UPDATE Orders 
SET coupon_id = 1 
WHERE id_order = 1;

-- Affichage des coupons expirés
SELECT * FROM Coupon 
WHERE expires_at < NOW();




*/