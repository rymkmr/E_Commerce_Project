<?php
session_start();

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email    = $_POST["email"];
    $password = $_POST["password"];
}
if (strlen($email) < 3) {
    $error = "Email must be at least 3 characters.";
} elseif (strlen($password) < 6) {
    $error = "Password must be at least 6 characters.";
} else {
    $conn = mysqli_connect("localhost", "root", "", "ecommerce_project");

    if (!$conn) {
        $error = "Database connection failed.";
    } else {
        $email_safe = mysqli_real_escape_string($conn, $email);
        $password_safe = mysqli_real_escape_string($conn, $password);

        $sql = "SELECT * FROM account 
                WHERE login = '$email_safe' 
                AND password = '$password_safe'";
        
        $result = mysqli_query($conn, $sql);

        if ($result && mysqli_num_rows($result) > 0) {
            $_SESSION["email"] = $email;
            mysqli_close($conn);
            header("Location: main.html");
            exit();
        } else {
            $error = "Invalid email or password.";
        }

        mysqli_close($conn);
    }
}
?>