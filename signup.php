<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $msg="";
    $user = $_POST['username'];
    $pass = $_POST['password'];
    $confirm = $_POST['confirm'];
    if(
    
    
       strlen($user)>=3 &&
       strlen($pass)>=6 &&
       $pass == $confirm

    ){
        $msg="account create successfuly!";
        $class="success";
        $customer = $conn->prepare("INSERT INTO customer (name, address, phone_number, email) VALUES (?, ?, ?, ?)");
$address = "Not provided";
$phone = "0000000000";
$email = $user . "@example.com";
$customer->bind_param("ssss", $user, $address, $phone, $email);
$customer->execute();

$customerId = $conn->insert_id;

$account = $conn->prepare("INSERT INTO account (customer_id, login, password) VALUES (?, ?, ?)");
$account->bind_param("iss", $customerId, $user, $pass);
$account->execute();

        header("Location: index.php");
        exit();
    }else{
        $msg="Invalid username or password.";
        $class="error";
    }
   
       
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
    <form id="signinForm" method="POST">
        <h1>create account</h1>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="enter your name"><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="enter your password" required><br><br>

        <label for="confirm">Confirm Password:</label>
        <input type="password" id="confirm" name="confirm" placeholder=" your password" required><br><br>

        <button type="submit">Sign up</button>

        <?php
          if ($_SERVER["REQUEST_METHOD"] == "POST") {?>
          <p class="<?php echo $class; ?>"><?php echo $msg; ?></p>
       <?php } ?>

    </form>

    
  </div>
</body>
</html>
