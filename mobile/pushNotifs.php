<?php 

include 'connection.php';

$ID = $_POST["id"];
//$ID = '2';
date_default_timezone_set('Asia/Manila');
$duration = 2;
$datenow = date("Y-m-d H:i:s", strtotime("+$duration sec"));

$queryResult=$connect->query("
	SELECT *
	FROM notifications  
	WHERE notifiable_id = '".$ID."' AND created_at = '".$datenow."' AND read_at is NULL");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);
//echo ($datenow);
?>