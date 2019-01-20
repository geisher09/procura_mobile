<?php 

include 'connection.php';

$image = $_FILES['image']['name'];

$imagePath = "assets/UserSignatures/".$image;

move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

$newpath = "./".$imagePath;

$connect->query("UPDATE users SET user_signature = '.$newpath.' WHERE id = '2'");

?>