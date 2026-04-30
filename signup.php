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
    <form  method="POST">
        <h1>create account</h1>
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" placeholder="enter your name"><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="enter your email"><br><br>

        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phone" placeholder="enter your phone number"><br><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" placeholder="enter your address"><br><br>
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