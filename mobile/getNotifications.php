<?php 

include 'connection.php';

$ID = $_POST["id"];
$User_ID = $_POST["uid"];
//$ID = '2';
//$User_ID = '3';

if($ID == '1'){
	$queryResult=$connect->query("
		SELECT *
		from notifications
		WHERE notifiable_id = '".$User_ID."'");


	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	echo json_encode($result);
}else{
	$queryResult=$connect->query("
		SELECT *
		from notifications
		WHERE notifiable_id = '".$User_ID."' AND read_at IS NULL");


	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	echo json_encode(sizeof($result));
}


?>