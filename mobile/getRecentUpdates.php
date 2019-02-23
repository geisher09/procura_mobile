<?php 

include 'connection.php';

$User_ID = $_POST["uid"];
//$User_ID = '3';

$queryResult=$connect->query("
	SELECT *
	from notifications
	WHERE notifiable_id = '".$User_ID."' ORDER BY updated_at DESC LIMIT 5");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);


?>