<?php
session_start();
require_once __DIR__ . "/db_connect.php";

$msg = "";
$class = "";

try {
    $conn = get_db_connection();
} catch (RuntimeException $e) {
    http_response_code(503);
    $msg = "Service temporarily unavailable. Please try again later.";
    $class = "error";
    $conn = null;
}

if ($_SERVER["REQUEST_METHOD"] == "POST" && $conn) {
    $user = trim($_POST['email'] ?? '');
    $pass = $_POST['password'] ?? '';

    if (strlen($user) >= 3 && strlen($pass) >= 6) {
        $stmt = $conn->prepare("SELECT customer_id, email FROM customer WHERE email = ?");
        $stmt->bind_param("s", $user);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $_SESSION["email"] = $user;

            $msg = "Login successful!";
            $class = "success";
            header("Location: main.html");
            exit();
        } else {
            $msg = "Invalid username or password.";
            $class = "error";
        }
        $stmt->close();
    } else {
        $msg = "Invalid username or password.";
        $class = "error";
    }
}

if ($conn) {
    $conn->close();
}
?> 

<!--html code-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
</head>
<body>
    <div id="login-form">
        <h1>Login</h1>
         <form method="POST">

           <label for="email">Email:</label>
           <input type="email" id="email" name="email" placeholder="enter your email"><br><br>

           <label for="password">Password:</label>
           <input type="password" id="password" name="password" placeholder="enter your password" required><br><br>

           <button type="submit">Login</button>
           <p>Don't have an account? <a href="signup.php">Sign in</a>.</p>
        </form>
        <?php
        if ($_SERVER["REQUEST_METHOD"] == "POST" || !$conn) {?>
        <p class="<?php echo $class; ?>"><?php echo $msg; ?></p>
        <?php } ?>
    </div>
    
</body>
</html>
