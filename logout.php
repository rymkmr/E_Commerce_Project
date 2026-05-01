<?php
session_start();// Start the session to access session variables
session_unset();// Unset all session variables to log the user out
session_destroy();// Destroy the session to complete the logout process
header("Location: index.php");
exit();
?>