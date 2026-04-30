
<?php
$msg="";
$class="";
if ($_SERVER["REQUEST_METHOD"] == "POST") {//check if the form is submitted using POST method
    $user = $_POST['email'];
    $pass = $_POST['password'];
    if(
      
      strlen($user)>=3 &&
      strlen($pass)>=6 

    ){
        $msg="Login successful!";//save success message in msg variable
        $class="success";
        header("Location: main.html");//redirect to main.html if login is successful
        exit();
       
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

           <label for="email">Email:</label>
           <input type="email" id="email" name="email" placeholder="enter your email"><br><br>

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