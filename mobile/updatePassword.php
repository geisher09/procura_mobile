<?php 

include 'connection.php';

$ID = $_POST["id"];
$password = $_POST["password"];

$hashed_password = password_hash($password, PASSWORD_DEFAULT);

$connect->query("UPDATE users SET password = '".$hashed_password."'
    WHERE id='".$ID."'");

/*$ID = '7';
$password = '123456';

$hashed_password = password_hash($password, PASSWORD_DEFAULT);

$connect->query("UPDATE users SET password = '".$hashed_password."'
    WHERE id='".$ID."'");*/

?>