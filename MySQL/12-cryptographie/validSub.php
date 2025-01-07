<?php 

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
$pseudo = $_GET["pseudo"];
$encryptedData = $pdo->query("SELECT email FROM membre WHERE pseudo = '$pseudo'")->fetch();


// Déchiffrement
$keyPath = 'keyfile.key'; // Chemin vers le fichier contenant la clé
$key = base64_decode(trim(file_get_contents($keyPath))); // Lire et décoder la clé
if ($key === false) {
    die("Problème d'inscription");
}

$decodedData = base64_decode($encryptedData["email"]);
$iv = substr($decodedData, 0, openssl_cipher_iv_length('aes-256-cbc'));
$ciphertext = substr($decodedData, openssl_cipher_iv_length('aes-256-cbc'));

$decryptedData = openssl_decrypt($ciphertext, 'aes-256-cbc', $key, 0, $iv);
echo "Voilà l'email déchiffré : $decryptedData\n";