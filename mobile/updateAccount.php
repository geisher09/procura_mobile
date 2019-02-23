<?php 

include 'connection.php';

$ID = $_POST["id"];
$username = $_POST["username"];
$name = $_POST["name"];

$connect->query("UPDATE users SET username = '".$username."', name = '".$name."'
    WHERE id='".$ID."'");
/*$ID = '7';
$username = 'audreynoelle';
$name = 'Audrey Noelle';

$connect->query("UPDATE users SET username = '".$username."', name = '".$name."'
    WHERE id='".$ID."'");*/

?>