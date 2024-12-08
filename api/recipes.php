<?php
header('Content-Type: application/json; charset=utf-8');
require_once 'C:\xampp\htdocs\PHPSemesralka\api\db.php';

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        if (isset($_GET['id'])) {

            try {
                $stmt = $pdo->prepare("SELECT * FROM recipes WHERE id = ?");
                $stmt->execute([$_GET['id']]);
                $recipe = $stmt->fetch(PDO::FETCH_ASSOC);

                if (!$recipe) {
                    http_response_code(404);
                    echo json_encode(["success" => false, "message" => "Recept nenájdený"]);
                    exit;
                }


                $stmtIng = $pdo->prepare("
                    SELECT i.id, i.name, i.unit, ri.amount 
                    FROM recipe_ingredients ri 
                    JOIN ingredients i ON ri.ingredient_id = i.id 
                    WHERE ri.recipe_id = ?
                ");
                $stmtIng->execute([$_GET['id']]);
                $ingredients = $stmtIng->fetchAll(PDO::FETCH_ASSOC);
                $recipe['ingredients'] = $ingredients;

                echo json_encode(["success" => true, "data" => $recipe]);
            } catch (PDOException $e) {
                echo json_encode(["success" => false, "message" => "Chyba pri získavaní receptu: " . $e->getMessage()]);
            }
        } else if (isset($_GET['search'])) {
            // Vyhľadávanie receptov
            $search = "%" . $_GET['search'] . "%";
            try {
                $stmt = $pdo->prepare("SELECT id, name, description FROM recipes WHERE name LIKE ?");
                $stmt->execute([$search]);
                $recipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(["success" => true, "data" => $recipes]);
            } catch (PDOException $e) {
                echo json_encode(["success" => false, "message" => "Chyba pri vyhľadávaní receptov: " . $e->getMessage()]);
            }
        } else {

            try {
                $stmt = $pdo->query("SELECT id, name, description FROM recipes");
                $recipes = $stmt->fetchAll(PDO::FETCH_ASSOC);
                echo json_encode(["success" => true, "data" => $recipes]);
            } catch (PDOException $e) {
                echo json_encode(["success" => false, "message" => "Chyba pri získavaní receptov: " . $e->getMessage()]);
            }
        }
        break;

    case 'POST':

        $input = json_decode(file_get_contents('php://input'), true);
        if (!isset($input['name']) || !isset($input['ingredients'])) {
            http_response_code(400);
            echo json_encode(["success" => false, "message" => "Nesprávne dáta"]);
            exit;
        }

        try {
            $pdo->beginTransaction();


            $stmt = $pdo->prepare("INSERT INTO recipes (name, description, steps) VALUES (?, ?, ?)");
            $stmt->execute([$input['name'], $input['description'], $input['steps']]);
            $recipeId = $pdo->lastInsertId();


            $stmtIng = $pdo->prepare("INSERT INTO recipe_ingredients (recipe_id, ingredient_id, amount) VALUES (?, ?, ?)");
            foreach ($input['ingredients'] as $ing) {
                $stmtIng->execute([$recipeId, $ing['id'], $ing['amount']]);
            }

            $pdo->commit();
            echo json_encode(["success" => true, "id" => $recipeId]);
        } catch (PDOException $e) {
            $pdo->rollBack();
            echo json_encode(["success" => false, "message" => "Chyba pri pridávaní receptu: " . $e->getMessage()]);
        }
        break;

    case 'DELETE':
        if (!isset($_GET['id'])) {
            http_response_code(400);
            echo json_encode(["success" => false, "message" => "Nezadali ste ID receptu"]);
            exit;
        }

        try {
            $stmt = $pdo->prepare("DELETE FROM recipes WHERE id = ?");
            $stmt->execute([$_GET['id']]);
            echo json_encode(["success" => true]);
        } catch (PDOException $e) {
            echo json_encode(["success" => false, "message" => "Chyba pri odstraňovaní receptu: " . $e->getMessage()]);
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(["success" => false, "message" => "Metóda nie je podporovaná"]);
        break;
}
?>
