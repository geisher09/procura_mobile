<?php 

include 'connection.php';

function getToken($length){
     $token = "";
     $codeAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
     $codeAlphabet.= "abcdefghijklmnopqrstuvwxyz";
     $codeAlphabet.= "0123456789";
     $max = strlen($codeAlphabet); // edited

    for ($i=0; $i < $length; $i++) {
        $token .= $codeAlphabet[random_int(0, $max-1)];
    }

    return $token;
}

$imagename = getToken(36);
$imagename = $imagename+'.jpg';

$image = $_FILES['image']['name'];

$imagePath = "C://xampp/htdocs/Procura/storage/app/public/user_images/".$image;

$ID = $_POST['idnum'];

move_uploaded_file($_FILES['image']['tmp_name'], $imagePath);

$newpath = 'user_images/'.$image;

$connect->query("UPDATE users SET user_image = '".$newpath."' WHERE id = '".$ID."'");

?>