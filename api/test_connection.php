<?php
require_once __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

try {
    $stmt = $pdo->query("SELECT DATABASE() AS db_name");
    $dbName = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode(["success" => true, "database" => $dbName['db_name']]);
} catch (PDOException $e) {
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}
?>
