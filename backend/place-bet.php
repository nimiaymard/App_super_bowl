<?php
require_once 'db_connection.php';
session_start();

if (!isset($_SESSION['user_id'])) {
    echo json_encode(['error' => 'Utilisateur non connecté']);
    exit;
}

$user_id = $_SESSION['user_id'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $match_id = $_POST['match_id'] ?? null;
    $team = $_POST['team'] ?? null;
    $amount = $_POST['amount'] ?? null;

    if ($match_id && $team && $amount) {
        try {
            $stmt = $pdo->prepare("INSERT INTO bets (user_id, match_id, team, amount) VALUES (?, ?, ?, ?)");
            $stmt->execute([$user_id, $match_id, $team, $amount]);
            echo json_encode(['success' => 'Pari placé avec succès']);
        } catch (PDOException $e) {
            echo json_encode(['error' => 'Erreur lors du placement du pari : ' . $e->getMessage()]);
        }
    } else {
        echo json_encode(['error' => 'Veuillez fournir tous les champs requis']);
    }
} else {
    echo json_encode(['error' => 'Requête invalide']);
}
?>



