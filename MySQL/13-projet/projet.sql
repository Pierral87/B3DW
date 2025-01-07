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