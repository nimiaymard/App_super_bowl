<?php
session_start();
require_once '../backend/db_connection.php'; // Assurez-vous que le chemin est correct

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Vérifier si l'utilisateur existe
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user && password_verify($password, $user['password'])) {
        // Mot de passe correct, démarrer la session
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['user_email'] = $user['email'];
        $_SESSION['user_firstname'] = $user['firstname'];
        $_SESSION['user_lastname'] = $user['lastname'];
        echo 'Connexion réussie';
        // Rediriger vers l'espace utilisateur
        header("Location: ../public/user-space.html");
        exit;
    } else {
        echo 'Email ou mot de passe incorrect.';
    }
} else {
    echo 'Méthode de requête non valide.';
}
?>