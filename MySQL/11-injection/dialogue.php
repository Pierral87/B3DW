<?php 

// Pour éviter les injections XSS (du code css et/ou js mis dans les commentaires)
// il est possible de modifier les carac notamment les < > qui représentent des balises.
// à l'affichage (voir en bas de page) on appelle htmlspecialchars() qui permet de transformer ces caractères problématiques en entités html
// exemple :
// <script>while(true){alert('truc');}</script>
// sera écrit dans le code source sous cette forme :
// &lt;script&gt;while(true){alert('truc');}&lt;/script&gt;

// injection css pour faire disparaitre le body
// <style>body{display:none;}</style>

// injection js pour lancer une alert infini
// <script>while(true){alert("merci pour les bitcoins");}</script>

// Outils proche de htmlspecialchars() : htmlentities() / strip_tags()

// Depuis le champ message
// pour injection SQL ', ''); DROP DATABASE dialogue;
// pour injection SQL ', ''); DELETE FROM dialogue;
// pour injection SQL ', NOW()); DELETE FROM commentaire;
// ', NOW()); DO SLEEP(10);  injection en aveugle, permet de voir si l'injection est possible en mettant un temps de délais à la requete c'est à dire je n'ai pas de messages d'erreur visible mais je vois que mon délais est bien pris en compte ! 


// Ici récupération de l'entièreté d'une table pour l'insérer dans un fichier .txt dans un dossier pour lequel j'ai les droits en écriture 
// ', NOW()); SELECT * INTO OUTFILE 'c:/wamp64/tmp/fichier2.txt' FROM commentaire; #
// Ici réinsertion dans notre table visible, du contenu de ce fichier 
// ', NOW()); INSERT INTO commentaire (pseudo, message, date_enregistrement) VALUES ('1', LOAD_FILE('c:/wamp64/tmp/fichier2.txt'), NOW());




/*
EXERCICES :
-----------
- Création d'un espace de dialogue

- 01 - Création de la BDD : dialogue
     -  Table : commentaire
     - Champs de la table commentaire :
        - id_commentaire        INT(3) PK AI
        - pseudo                VARCHAR 255
        - message               TEXT
        - date_enregistrement   DATETIME
        
- 02 - Créer une connexion à cette base avec PDO
- 03 - Création d'un formulaire permettant de poster un message
     - Champs du formulaire : 
        - pseudo (input type="text")
        - message (textarea)
        - bouton de validation
- 04 - Récupération des saisies du form avec controle 
- 05 - Déclenchement d'une requete d'enregistrement pour enregistrer les saisies dans la BDD
- 06 - Requete de récupération des messages afin de les afficher dans cette page
- 07 - Affichage des commentaire avec un peu mise en forme
- 08 - Affichage en haut des messages du nombre de message présent dans la bdd
- 09 - Affichage de la date en français
- 10 - Amélioration du css
*/

// 02 - Créer une connexion à cette base avec PDO
$host = 'mysql:host=localhost;dbname=dialogue'; 
$login = 'root'; // login
$password = ''; // mdp
$options = array(
    PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING, 
    // PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING, 
    // PDO::ATTR_ERRMODE => PDO::ERRMODE_SILENT, 
    PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8' 
);
try {
    $pdo = new PDO($host, $login, $password, $options);
} catch (Exception $e) 
{
    echo "Site indisponible";
    exit;
}



$req = '';
// - 04 - Récupération des saisies du form avec controle 
if( isset($_POST['pseudo']) && isset($_POST['message']) ) {
    $pseudo = trim($_POST['pseudo']);
    $message = trim($_POST['message']);

    // - 05 - Déclenchement d'une requete d'enregistrement pour enregistrer les saisies dans la BDD
    $req = "INSERT INTO commentaire (pseudo, message, date_enregistrement) VALUES ('$pseudo', '$message', NOW())";

    // ICI QUERY LANCE UNE REQUETE IMMEDIATEMENT !!! ON EVITE, SINON INJECTION POSSIBLE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // On garde la ligne ci dessous pour test les injections
    $enregistrement = $pdo->query($req);

    // CI DESSOUS LA REQUETE EN VERSION PREPAREE QUI NOUS PROTEGE DE TOUTES INJECTIONS SQL !!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Pour éviter les injections SQL il faut privilégier prepare() car $pseudo et $message viennent du formulaire et pourrait contenir du code malveillant.
    // Avec prepare les injections ne sont pas possibles.

    // On décommente les 4 lignes ci dessous pour lancer plutôt en requête préparée et donc, se protéger des injections 
    // $enregistrement = $pdo->prepare("INSERT INTO commentaire (pseudo, message, date_enregistrement) VALUES (:pseudo, :message, NOW())");
    // $enregistrement->bindParam(':pseudo', $pseudo, PDO::PARAM_STR);
    // $enregistrement->bindParam(':message', $message, PDO::PARAM_STR);
    // $enregistrement->execute();

    // Pour éviter de renvoyer le même enregistrement en rechargeant la page, on va rediriger avec PHP sur cette page après l'enregistrement pour perdre les données dans $_POST
    // header('location:dialogue1.php');
}

// - 06 - Requete de récupération des messages afin de les afficher dans cette page
$liste_commentaire = $pdo->query("SELECT pseudo, message, date_format(date_enregistrement, '%d/%m/%Y à %H:%i:%s') AS date_fr FROM commentaire ORDER BY date_enregistrement DESC");
?>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">

        <!-- Google font -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <!-- Playfair display -->
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@500&display=swap" rel="stylesheet">
        <!-- Roboto -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" rel="stylesheet">

        <!-- FontAwesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <style>
            * {
                font-family: 'Roboto', sans-serif;
            }
            h1, h2, h3, h4, h5, h6 {
                font-family: 'Playfair Display', serif;
            }
        </style>

        <title>Dialogue</title>
    </head>
    <body class="bg-secondary" >
        <div class="container bg-light g-0">
            <div class='row '>
                <div class="col-12">
                    <h2 class="text-center text-dark fs-1 bg-light p-5 border-bottom"><i class="far fa-comments"></i> Espace de dialogue <i class="far fa-comments"></i></h2>
                    <form method="post" class="mt-5 mx-auto w-50 border p-3 bg-white">
                        
                        <?php echo $req; // on affiche la requete pour voir les injections SQL ?>
                    
                        <hr>
                        <div class="mb-3">
                            <label for="pseudo" class="form-label">Pseudo <i class="fas fa-user-alt"></i></label>
                            <input type="text" class="form-control" id="pseudo" name="pseudo">
                        </div>
                        <div class="mb-3">
                            <label for="message" class="form-label">Message <i class="fas fa-feather-alt"></i></label>
                            <textarea class="form-control" id="message" name="message"></textarea>
                        </div>
                        <div class="mb-3">
                            <hr>
                            <button type="submit" class="btn btn-secondary w-100" id="enregistrer" name="enregistrer"><i class="fas fa-keyboard"></i> Enregistrer <i class="fas fa-keyboard"></i></button>
                        </div>
                    </form>
                </div>
            </div>
            <div class='row mt-5'> 
                <div class="col-12">               
                    <!-- Affichage des commentaire -->
                    <p class="w-75 mx-auto mb-3"><?php
                        // - 08 - Affichage en haut des messages du nombre de message présent dans la bdd
                        echo 'il y a : <b>' . $liste_commentaire->rowCount() . '</b> messages';
                    ?></p>
                    <?php 
                        // - 07 - Affichage des commentaire avec un peu mise en forme
                        while($commentaire = $liste_commentaire->fetch(PDO::FETCH_ASSOC)) {
                            echo '<div class="card w-75 mx-auto mb-3">
                                    <div class="card-header bg-dark text-white">
                                        Par : ' . htmlspecialchars($commentaire['pseudo']) . ', le : ' . $commentaire['date_fr'] . '
                                    </div>
                                    <div class="card-body">
                                        <p class="card-text">' . htmlspecialchars($commentaire['message']) . '</p>
                                    </div>
                                </div>';
                        }
                    
                    
                    ?>
                    
                </div>
            </div>
        </div>


        <!-- Option 1: Bootstrap Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>
    </body>
</html>
