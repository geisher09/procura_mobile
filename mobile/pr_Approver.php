<?php 

$str = file_get_contents('C://xampp/htdocs/Procura/storage/settings.json');
$json = json_decode($str, true); // decode the JSON into an associative array
$approver = $json['pr_approver_id'];
echo $approver;

?>