<?php
header('Content-Type: application/json');
require 'db_connection.php';

try {
    // Vérifier la connexion
    if (!$pdo) {
        echo json_encode(['error' => 'Échec de la connexion à la base de données']);
        exit;
    }

    // Exécuter la requête
    $stmt = $pdo->query("SELECT id, team1, team2, date, time, status, weather FROM matches");
    $matches = $stmt->fetchAll();

    // Vérifier les résultats de la requête
    if ($matches === false) {
        echo json_encode(['error' => 'Échec de la récupération des matches']);
        exit;
    }

    // Envoyer les résultats
    echo json_encode(['matches' => $matches]);

} catch (\PDOException $e) {
    echo json_encode(['error' => 'Échec de la requête SQL: ' . $e->getMessage()]);
}
?>
