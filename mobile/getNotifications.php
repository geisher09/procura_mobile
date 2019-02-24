<?php 

include 'connection.php';

$ID = $_POST["id"];
$User_ID = $_POST["uid"];
//$ID = '2';
//$User_ID = '5';

if($ID == '1'){
	$queryResult=$connect->query("
		SELECT *
		from notifications
		WHERE notifiable_id = '".$User_ID."' ORDER BY created_at DESC");


	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	echo json_encode($result);
}elseif($ID == '2'){
	$queryResult2=$connect->query("
		SELECT *
		from notifications
		WHERE notifiable_id = '".$User_ID."' AND read_at IS NULL");


	$result2=array();

	while ($fetchData=$queryResult2->fetch_assoc()) {
		$result2[]=$fetchData;
	}

	echo json_encode($result2);
}


?>