<?php
function get_db_connection(): mysqli
{
    mysqli_report(MYSQLI_REPORT_OFF);
    $conn = new mysqli("localhost", "root", "", "ecommerce_project");

    if ($conn->connect_error) {
        throw new RuntimeException("Database unavailable");
    }

    $conn->set_charset("utf8mb4");
    return $conn;
}
?>
