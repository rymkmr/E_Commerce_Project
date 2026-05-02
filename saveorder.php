<?php
header('Content-Type: application/json');
session_start();
require_once __DIR__ . "/db_connect.php";

try {
    $conn = get_db_connection();
} catch (RuntimeException $e) {
    http_response_code(503);
    echo json_encode(["error" => "Service temporarily unavailable"]);
    exit();
}

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    http_response_code(405);
    echo json_encode(["error" => "Invalid request"]);
    exit();
}

$data = json_decode(file_get_contents("php://input"), true);
if (!isset($data["cart"]) || !is_array($data["cart"]) || count($data["cart"]) === 0) {
    http_response_code(400);
    echo json_encode(["error" => "Cart is empty"]);
    exit();
}

$userEmail = $_SESSION["email"] ?? null;
if (!$userEmail) {
    http_response_code(401);
    echo json_encode(["error" => "User not logged in"]);
    exit();
}

$stmt = $conn->prepare("SELECT customer_id FROM customer WHERE email = ?");
$stmt->bind_param("s", $userEmail);
$stmt->execute();
$result = $stmt->get_result();
$customer = $result->fetch_assoc();
$stmt->close();

if (!$customer) {
    http_response_code(404);
    echo json_encode(["error" => "Customer not found"]);
    exit();
}

$customer_id = (int)$customer["customer_id"];

$stmt = $conn->prepare("INSERT INTO orders (customer_id, product_id, quantity, order_date, total_price) VALUES (?, ?, ?, NOW(), ?)");

foreach ($data["cart"] as $item) {
    if (!isset($item["id"], $item["quantity"], $item["price"])) {
        continue;
    }

    $product_id = (string)$item["id"];
    $quantity = (int)$item["quantity"];
    $price = (float)preg_replace('/[^\d.]/', '', (string)$item["price"]);
    $row_total = $price * $quantity;

    if ($quantity <= 0 || $row_total <= 0) {
        continue;
    }

    $stmt->bind_param("isid", $customer_id, $product_id, $quantity, $row_total);
    $stmt->execute();
}

$stmt->close();
$conn->close();

echo json_encode([
    "success" => true,
    "message" => "Order saved successfully"
]);
?>
