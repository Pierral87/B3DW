<?php

/*

    EXERCICE Chiffrement de données sensibles et hash du password :

        Etapes : 
            - Reprendre l'exercice POST Inscription Utilisateur du dossier PHP - Chapitre Post - Exercices
            - Modifier le code pour le faire correspondre à une réelle insertion en bdd (base "crypto"  table "membre"  id_membre, pseudo, email, password)
            - Bien gérer la vérification du doublon en table
            - Gérer la sécurité de l'insertion
            - Hacher le password avec password_hash et en choisissant un algorithme puissant
            - Chiffrer l'email via un chiffrement symétrique 
                - Création d'une clé (en base64) en utilisant openssl rand en command line, la stocker dans un fichier
                - Penser à décoder cette clé de base64 avant de la manipuler dans le reste du code base64_decode
                - Créer un IV aléatoire en cumulant random_bytes() puis openssl_cipher_iv_length()
                - Crypter ensuite la donnée avec openssl_encrypt() en appliquant bien l'IV
                - La retransformer en base64 avant de la stocker base64_encode
            - Insérer en BDD 
            - Lorsque tout est OK et que l'insertion s'effectue convenablement (vérifier les données dans PHPMyAdmin, password hash et email chiffré), mettre en place une redirection vers une page indiquant à l'utilisateur qu'il est convenablement incrit, et lui respécifier son email (il faudra le dechiffrer)
                - Redécoder de base64 l'email récupéré en BDD
                - A partir de là, la chaine récupérée contient l'IV en debut de chaine (celui appliqué au chiffrement, il va falloir le découper avec substr pour extraire à la fois l'iv et à la fois le reste de la chaine cryptée)
                - Une fois la découpe des deux éléments faites, utiliser openssl_decrypt  pour déchiffrer la donnée 


            (créer une clé symétrique : openssl rand -base64 32 > keyfile.key)
            openssl rand : Génère des données aléatoires.
            -base64 : Encode la clé en base64 pour faciliter son stockage ou son transfert.
            32 : Génère une clé de 32 octets (256 bits), idéale pour un algorithme comme AES-256.
            > keyfile.key : Enregistre la clé générée dans un fichier nommé keyfile.key.




*/
try {
    $host = 'mysql:host=localhost;dbname=cryptotest2'; // hôte + bdd
    $login = 'root'; // login
    $password = ''; // mdp
    $options = array(
        PDO::ATTR_ERRMODE => PDO::ERRMODE_WARNING, // gestion des erreurs
        PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8' // on force l'utf8 sur les données provenants de la bdd
    );

    // PDO::ATTR_ERRMODE : On va chercher l'information ATTR_ERRMODE sur la classe PDO

    // Création de l'objet :
    $pdo = new PDO($host, $login, $password, $options);
} catch (Exception $e) {
    die("Site hors service");
}


session_start();


$errors = [];
$success = "";

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $pseudo = trim($_POST['pseudo']);
    $email = trim($_POST['email']);
    // $email = filter_var($_POST['email'], FILTER_VALIDATE_EMAIL);
    $password = $_POST['password'];
    $passwordConfirm = $_POST['password_confirm'];

    // Contrôles de validation
    if (empty($pseudo)) {
        $errors[] = "Le pseudo est requis.";
    }

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $errors[] = "L'email n'est pas valide.";
    }

    if (iconv_strlen($password) < 6) {
        $errors[] = "Le mot de passe doit faire au moins 6 caractères.";
    }

    if ($password !== $passwordConfirm) {
        $errors[] = "Les mots de passe ne se correspondent pas.";
    }

    // - disponibilité du pseudo
    // Pour savoir si le pseudo est disponible, nous devons faire une requete en BDD, si on récupère une ligne, le pseudo est indisponible sinon ok
    $verif_pseudo = $pdo->prepare("SELECT * FROM membre WHERE pseudo = :pseudo"); // on prépare la requete
    $verif_pseudo->bindParam(':pseudo', $pseudo, PDO::PARAM_STR); // on rattache la variable contenant la valeur attendue au marqueur nominatif de la requete préparée
    $verif_pseudo->execute(); // on exécute

    // rowCount() nous renvoie le nombre de ligne obtenue. Si on a plus de 0 ligne, alors le pseudo est indisponible
    if ($verif_pseudo->rowCount() > 0) {
        // cas d'erreur
        $errors[] = "Pseudo déjà pris";
    }

    // Si pas d'erreurs, on enregistre l'utilisateur
    if (empty($errors)) {

        $hashedPassword = password_hash($password, PASSWORD_ARGON2I);
        $keyPath = 'keyfile.key'; // Chemin vers le fichier contenant la clé
        $key = base64_decode(trim(file_get_contents($keyPath))); // Lire et décoder la clé
        if ($key === false) {
            die("Problème d'inscription");
        }

        // Génération d'un IV (vector d'initialisation) sécurisé
        $iv = random_bytes(openssl_cipher_iv_length('aes-256-cbc'));

        // Chiffrement
        $encryptedEmail = openssl_encrypt($email, 'aes-256-cbc', $key, 0, $iv);
        // Encodage en base64 pour stockage ou transmission
        $encryptedEmail = base64_encode($iv . $encryptedEmail);


        try {

            // on lance le insert into :
            $enregistrement = $pdo->prepare("INSERT INTO membre (pseudo, email, password) VALUES (:pseudo, '$encryptedEmail', '$hashedPassword')");
            // Pour le statut :
            // 1 = membre
            // 2 = admin
            $enregistrement->bindParam(':pseudo', $pseudo, PDO::PARAM_STR);
            // $enregistrement->bindParam(':email', $email, PDO::PARAM_STR);
            $enregistrement->execute();
        } catch (Exception $e) {
            $errors[] = "Erreur d'inscriptions.";
        }

        header("location:validSub.php?pseudo=$pseudo");
        $success = "Inscription réussie ! Vous pouvez maintenant vous connecter.";
    }
}
?>

<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <h1>Inscription</h1>

                <?php if (!empty($errors)): ?>
                    <div class="alert alert-danger">
                        <ul>
                            <?php foreach ($errors as $error): ?>
                                <li><?= $error ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                <?php endif; ?>

                <?php if ($success): ?>
                    <div class="alert alert-success">
                        <?= $success ?>
                    </div>
                <?php endif; ?>

                <form action="" method="post">
                    <div class="mb-3">
                        <label for="pseudo" class="form-label">Pseudo</label>
                        <input type="text" class="form-control" id="pseudo" name="pseudo" required>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Mot de passe</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="password_confirm" class="form-label">Confirmer le mot de passe</label>
                        <input type="password" class="form-control" id="password_confirm" name="password_confirm" required>
                    </div>
                    <button type="submit" class="btn btn-primary">S'inscrire</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>