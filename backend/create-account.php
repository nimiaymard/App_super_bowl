<?php
require_once '../backend/db_connection.php'; // Assurez-vous que le chemin est correct

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    
    // Hashage du mot de passe
    $hashed_password = password_hash($password, PASSWORD_BCRYPT);

    // Vérifier si l'email existe déjà
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    if ($stmt->fetch()) {
        echo 'Cet email est déjà utilisé.';
        exit;
    }

    // Insérer le nouvel utilisateur
    $stmt = $pdo->prepare("INSERT INTO users (firstname, lastname, email, password) VALUES (?, ?, ?, ?)");
    if ($stmt->execute([$firstname, $lastname, $email, $hashed_password])) {
        //echo 'Compte créé avec succès.';
        echo 'Compte créé avec succès. Veuillez vérifier votre email pour confirmer votre inscription.';
        // Désactiver l'envoi de l'email de confirmation
        // Envoi de l'email de confirmation
        mail($email, "Confirmation de votre inscription", "Merci de vous être inscrit. Veuillez cliquer sur le lien suivant pour confirmer votre inscription : [lien de confirmation]");
    } else {
        echo 'Erreur lors de la création du compte. Veuillez réessayer.';
    }
}
?>


