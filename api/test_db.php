<?php
require_once 'db.php';

header('Content-Type: application/json; charset=utf-8');

if ($pdo) {
    echo json_encode(["success" => true, "message" => "Pripojenie k databáze úspešné"]);
} else {
    echo json_encode(["success" => false, "message" => "Pripojenie k databáze zlyhalo"]);
}
?>