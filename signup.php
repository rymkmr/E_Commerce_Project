<?php
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
    $user = trim($_POST['username'] ?? '');
    $address = trim($_POST['address'] ?? '');
    $phone = trim($_POST['phone'] ?? '');
    $email = trim($_POST['email'] ?? '');

    if (strlen($user) >= 3 && $address !== '' && $phone !== '' && filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $stmt = $conn->prepare("INSERT INTO customer (`name`,`address`,`phone_number`, `email`) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssss", $user, $address, $phone, $email);

        if ($stmt->execute()) {
            $msg = "Account created successfully!";
            $class = "success";
            header("Location: index.php");
            exit();
        } else {
            $msg = "Error creating account.";
            $class = "error";
        }
        $stmt->close();
    } else {
        $msg = "Please fill out all fields correctly.";
        $class = "error";
    }
}

if ($conn) {
    $conn->close();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>create account</title>
</head>
<body id="signup-page">
  <div id="signin-form"> 
    <form  method="POST">
        <h1>create account</h1>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="enter your name"><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="enter your email"><br><br>

        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phone" placeholder="enter your phone number"><br><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" placeholder="enter your address" list="addresses"><br><br>
      <datalist id="addresses">
           <option value="Adrar">
           <option value="Chlef">
           <option value="Laghouat">
           <option value="Oum El Bouaghi">
           <option value="Batna">
           <option value="Béjaïa">
           <option value="Biskra">
           <option value="Béchar">
           <option value="Blida">
           <option value="Bouira">
           <option value="Tamanrasset">
           <option value="Tizi Ouzou">
           <option value="Alger">
           <option value="Boumérdès">
           <option value="El Tarf">
           <option value="Tindouf">
           <option value="Tissemsilt">
           <option value="El Oued">
      </datalist> 

       

        <button type="submit">Sign up</button>

        <?php
          if ($_SERVER["REQUEST_METHOD"] == "POST" || !$conn) {?>
          <p class="<?php echo $class; ?>"><?php echo $msg; ?></p>
       <?php } ?>

    </form>

    
  </div>
</body>
</html>
