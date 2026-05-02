<?php
session_start();

$error = "";
$success = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $address  = $_POST["address"];
    $phone    = $_POST["phone"];
    $email    = $_POST["email"];
    $password = $_POST["password"];

    $conn = mysqli_connect("localhost", "root", "", "ecommerce_project");

    if (!$conn) {
        $error = "Database connection failed.";
    } else {
        $username_safe = mysqli_real_escape_string($conn, $username);
        $address_safe  = mysqli_real_escape_string($conn, $address);
        $phone_safe    = mysqli_real_escape_string($conn, $phone);
        $email_safe    = mysqli_real_escape_string($conn, $email);
        $password_safe = mysqli_real_escape_string($conn, $password);

        $check = mysqli_query($conn, "SELECT email FROM customer WHERE email = '$email_safe'");

        if ($check && mysqli_num_rows($check) > 0) {
            $error = "Email already registered.";
        } else {
            $sql1 = "INSERT INTO customer (name, address, phone_number, email)
                     VALUES ('$username_safe', '$address_safe', '$phone_safe', '$email_safe')";

            $sql2 = "INSERT INTO account (login, password)
                     VALUES ('$email_safe', '$password_safe')";

            if (mysqli_query($conn, $sql1) && mysqli_query($conn, $sql2)) {
                mysqli_close($conn);
                header("Location: index.php");
                exit();
            } else {
                $error = "Registration failed. Please try again.";
            }
        }

        mysqli_close($conn);
    }
}
?>