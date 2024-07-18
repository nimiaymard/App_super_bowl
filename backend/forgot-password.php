<?php
require_once 'db_connection.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];

    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user) {
        $new_password = bin2hex(random_bytes(8));
        $hashed_password = password_hash($new_password, PASSWORD_BCRYPT);

        $stmt = $pdo->prepare("UPDATE users SET password = ? WHERE email = ?");
        $stmt->execute([$hashed_password, $email]);

        mail($email, "Votre nouveau mot de passe", "Votre nouveau mot de passe est : $new_password");

        echo 'Un email avec votre nouveau mot de passe a été envoyé.';
    } else {
        echo 'Email non trouvé.';
    }
}

