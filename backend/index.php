<?php
require_once 'db_connection.php';

$query = $pdo->query("SELECT team1, team2, time, status FROM matches WHERE date = CURDATE()");
$matches = $query->fetchAll(PDO::FETCH_ASSOC);

header('Content-Type: application/json');
echo json_encode(['matches' => $matches]);

