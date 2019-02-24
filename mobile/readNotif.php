<?php 

include 'connection.php';

$ID = $_POST["id"];
date_default_timezone_set('Asia/Manila');
$datenow = date("Y-m-d H:i:s");

$connect->query("UPDATE notifications SET read_at = '".$datenow."' WHERE id='".$ID."'");

?>