
<?php
require_once "db.php";
$msg="";
$class="";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user = $_POST['username'];
    $pass = $_POST['password'];

    $stmt = $conn->prepare("SELECT * FROM account WHERE login = ? AND password = ?");
    $stmt->bind_param("ss", $user, $pass);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $msg = "Login successful!";
        $class = "success";
        header("Location: main.html");
        exit();
    } else {
        $msg = "Invalid username or password.";
        $class = "error";
    }


       
    }else {
        $msg="Invalid username or password.";//save error message in msg variable
        $class="error";
    }
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

           <label for="username">Username:</label>
           <input type="text" id="username" name="username" placeholder="enter your name"><br><br>

           <label for="password">Password:</label>
           <input type="password" id="password" name="password" placeholder="enter your password" required><br><br>

           <button type="submit">Login</button>
           <p>Don't have an account? <a href="signup.php">Sign in</a>.</p>
        </form>
        <?php
        if ($_SERVER["REQUEST_METHOD"] == "POST") {?>
        <p class="<?php echo $class; ?>"><?php echo $msg; ?></p>
        <?php } ?>
    </div>
    
</body>
</html>
