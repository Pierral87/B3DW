--------------------------------- Les contraintes d'intégrité ---------------------------------

-- Lorsque l'on a une relation entre nos tables, pour faire des jointures ou autre (on définit ça lors de la modélisation)
-- On va créer des clés étrangères 
-- Pour "valider" la relation, en plus de catégoriser le champ prévu pour être une FK dans notre table, on va devoir rajouter une contrainte de clé étrangère 
-- Une contrainte de clé étrangère nous permet de maintenir l'intégrité des données en empéchant l'ajout de données fantomes dans nos tables 
-- Par exemple sur notre base bibliothèque, je ne peux pas insérer un emprunt avec un id_abonne qui ne correspond pas à un abonné réel, idem pour l'id_livre, je ne peux pas insérer un faux id_livre, la contrainte me protège de ce côté là
-- On peut régler différents mode sur nos contraintes 

-- D'abord, on met en place une contrainte sur une action de "ON DELETE" suppression sur un élément parent pour comprendre comment cela doit se passer par rapport à sa jointure 
-- Et une contrainte sur l'action "ON UPDATE" (modification et insertion) pour comprendre comment la système réagit en cas d'insert ou d'update de cet élément

-- Les MODE de fonctionnement des contraintes 

    -- RESTRICT (ou NO ACTION, similaire en MySQL) : Tant qu'un emprunt est rattaché à un abonné, on ne peut pas supprimer l'abonné ! Ni modifier son id. On pourra uniquement le faire si aucun emprunt n'est rattaché à cet abonné.
    -- SET NULL : Inscrira NULL dans le champ de la FK  si on supprime ou modifie l'abonnée 
    -- CASCADE : (=repercussion) Si on modifie l'id d'un abonné, il sera également modifié dans tous ses emprunts, si on supprime l'abonné, tous ses emprunts seront également supprimés ! ATTENTION le mode CASCADE est à manipuler avec précaution (on repense au REPLACE de notre chapitre 1 sur la syntaxe des requêtes de modification)


-- Pour ajouter un index et contraintes via PHPMyAdmin, se rendre sur la base, puis la table, puis l'onglet structure.
    -- Sur chaque ligne on a accès en fin de ligne au bouton "Plus" qui nous permet de définir le champ comme étant un "index" (pour optimiser les requêtes lancées sur ce champ)
        -- Après avoir défini le champ comme étant un index, on clique sur le bouton "Vue Relationnelle" au dessus de la liste des champs pour ensuite définir quel index correspond à quel champ d'une autre table ainsi que pour définir ses modes de contrainte sur ON DELETE et ON UPDATE 


CREATE DATABASE taxi;

USE TAXI;

CREATE TABLE IF NOT EXISTS `association_vehicule_conducteur` (
  `id_association` int(3) NOT NULL AUTO_INCREMENT,
  `id_vehicule` int(3) DEFAULT NULL,
  `id_conducteur` int(3) DEFAULT NULL,
  PRIMARY KEY (`id_association`)
  
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


INSERT INTO `association_vehicule_conducteur` (`id_association`, `id_vehicule`, `id_conducteur`) VALUES
(1, 501, 1),
(2, 502, 2),
(3, 503, 3),
(4, 504, 4),
(5, 501, 3);


CREATE TABLE IF NOT EXISTS `conducteur` (
  `id_conducteur` int(3) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(30) NOT NULL,
  `nom` varchar(30) NOT NULL,
  PRIMARY KEY (`id_conducteur`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


INSERT INTO `conducteur` (`id_conducteur`, `prenom`, `nom`) VALUES
(1, 'Julien', 'Avigny'),
(2, 'Morgane', 'Alamia'),
(3, 'Philippe', 'Pandre'),
(4, 'Amelie', 'Blondelle'),
(5, 'Alex', 'Richy');


DROP TABLE IF EXISTS `vehicule`;
CREATE TABLE IF NOT EXISTS `vehicule` (
  `id_vehicule` int(3) NOT NULL AUTO_INCREMENT,
  `marque` varchar(30) NOT NULL,
  `modele` varchar(30) NOT NULL,
  `couleur` varchar(30) NOT NULL,
  `immatriculation` varchar(9) NOT NULL,
  PRIMARY KEY (`id_vehicule`)
) ENGINE=InnoDB AUTO_INCREMENT=507 DEFAULT CHARSET=latin1;

INSERT INTO `vehicule` (`id_vehicule`, `marque`, `modele`, `couleur`, `immatriculation`) VALUES
(501, 'Peugeot', '807', 'noir', 'AB-355-CA'),
(502, 'Citroen', 'C8', 'bleu', 'CE-122-AE'),
(503, 'Mercedes', 'Cls', 'vert', 'FG-953-HI'),
(504, 'Volkswagen', 'Touran', 'noir', 'SO-322-NV'),
(505, 'Skoda', 'Octavia', 'gris', 'PB-631-TK'),
(506, 'Volkswagen', 'Passat', 'gris', 'XN-973-MM');

-- EXERCICES 

        -- Créer les relations de cette base dans PhpMyAdmin 
        -- Créer ensuite les contraintes par rapport aux questions suivantes 

    -- ATTENTION, chaque question est à prendre indépendamment de la suivante, car les contraintes ne sont pas toutes faisables en même temps 

-- 1/ 	Pour éviter les erreurs, la société de taxis aimerait que l’on ne puisse pas faire une mauvaise association lors de la saisie.
-- 2/	La société de taxis peut modifier leurs conducteurs via leur logiciel, lorsqu’un conducteur est modifié (dans la table conducteur - changement d’id), la société aimerait que la modification soit répercutée dans la table « association_vehicule_conducteur ».
-- 3/	La société de taxis peut supprimer des conducteurs via leur logiciel, ils aimeraient bloquer la possibilité de supprimer un conducteur (dans la table conducteur) tant que celui-ci conduit un véhicule.
-- 4/	La société de taxis peut modifier un véhicule via leur logiciel. Lorsqu’un véhicule est modifié (dans la table véhicule - changement d’id), la société aimerait que la modification soit répercutée dans la table « association_vehicule_conducteur ».
-- 5/	Si un véhicule est supprimé alors qu’un ou plusieurs conducteurs le conduisaient, la société aimerait garder la présence de ces conducteurs dans la table « association_vehicule_conducteur » en précisant « null » comme valeur dans le champ correspondant puisque le véhicule aura été supprimé.

-- 01 - Qui conduit la voiture 503 ? 
-- 02 - Quelle(s) voiture(s) est conduite par le conducteur 3 ? 
-- 03 - Qui conduit quoi ? (on veut les prenoms associés à un modele + marque)
-- 04 - Ajoutez vous dans la liste des conducteurs.
            -- Afficher tous les conducteurs (meme ceux qui n'ont pas de correspondance avec les vehicules) puis les vehicules qu'ils conduisent si c'est le cas
-- 05 - Ajoutez un nouvel enregistrement dans la table des véhicules.
        -- Afficher tous les véhicules (meme ceux qui n'ont pas de correspondance avec les conducteurs) puis les conducteurs si c'est le cas
-- 06 - Afficher tous les conducteurs et tous les vehicules, peu importe les correspondances.
