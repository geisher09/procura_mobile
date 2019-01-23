<?php 

include 'connection.php';

$image = $_FILES['image']['name'];

$imagePath = "assets/UserSignatures/".$image;

$ID = $_POST['idnum'];
//2.3.png
//2,3,png

$split_img = explode('.', $image);
$present_no = (int)$split_img[1];
$prev_no = $present_no - 1;
$image_to_del = $split_img[0].'.'.$prev_no.".png";
echo $image_to_del;

move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

$newpath = "./".$imagePath;

$connect->query("UPDATE users SET user_signature = '.$newpath.' WHERE id = '".$ID."'");

unlink('assets/UserSignatures/'.$image_to_del);

?>