<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

// Inclure le fichier de connexion existant
include 'db.php';

try {
    // Utiliser la variable $db définie dans db.php
    $sql = "SELECT * FROM helpers";
    $stmt = $db->prepare($sql);
    $stmt->execute();
    $helpers = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($helpers);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>