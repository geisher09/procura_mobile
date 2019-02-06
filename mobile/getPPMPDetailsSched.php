<?php 

include 'connection.php';

$ID = '1';

$schedResult=$connect->query("
	SELECT
	schedules.month
	from schedules
	LEFT OUTER JOIN project_item_schedule
	on project_item_schedule.schedule_id = schedules.id
	LEFT OUTER JOIN project_items
	on project_item_schedule.project_item_id = project_items.id
	where project_items.id = '".$ID."'");


$result2=array();

while ($fetchData=$schedResult->fetch_assoc()) {
	$result2[]=$fetchData;
}


echo json_encode($result2);


?>