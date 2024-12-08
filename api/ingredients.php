<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once '../db.php';

try {
    $stmt = $pdo->query("SELECT id, name, unit FROM ingredients");
    $ingredients = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(["success" => true, "data" => $ingredients]);
} catch (Exception $e) {
    echo json_encode(["success" => false, "message" => $e->getMessage()]);
}

require_once __DIR__ . '/db.php';


header('Content-Type: application/json; charset=utf-8');

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':

        try {
            $stmt = $pdo->query("SELECT id, name, unit FROM ingredients");
            $ingredients = $stmt->fetchAll(PDO::FETCH_ASSOC);
            echo json_encode(["success" => true, "data" => $ingredients]);
        } catch (PDOException $e) {
            http_response_code(500); // Установим HTTP статус 500 в случае ошибки
            echo json_encode(["success" => false, "message" => "Ошибка при получении ингредиентов: " . $e->getMessage()]);
        }
        break;

    case 'POST':

        $data = json_decode(file_get_contents('php://input'), true);

        if (empty($data['name'])) {
            http_response_code(400);
            echo json_encode(["success" => false, "message" => "Название ингредиента обязательно"]);
            exit;
        }

        try {
            $stmt = $pdo->prepare("INSERT INTO ingredients (name, unit) VALUES (?, ?)");
            $stmt->execute([$data['name'], $data['unit'] ?? '']);
            echo json_encode(["success" => true, "id" => $pdo->lastInsertId()]);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(["success" => false, "message" => "Ошибка при добавлении ингредиента: " . $e->getMessage()]);
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(["success" => false, "message" => "Метод не поддерживается"]);
        break;
}
?>
