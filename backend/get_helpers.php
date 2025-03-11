<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');

include 'db.php';

try {
    $sql = "SELECT * FROM helpers";
    $stmt = $db->prepare($sql);
    $stmt->execute();
    $helpers = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo json_encode($helpers);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>