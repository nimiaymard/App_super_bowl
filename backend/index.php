<?php
require_once 'db_connection.php';

// Récupérer les matchs du jour
$query = $pdo->prepare("SELECT team1, team2, time, status FROM matches WHERE DATE(time) = CURDATE()");
$query->execute();
$matches = $query->fetchAll(PDO::FETCH_ASSOC);

// Envoyer les données en JSON
header('Content-Type: application/json');
echo json_encode(['matches' => $matches]);
?>
