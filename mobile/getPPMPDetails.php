<?php 

include 'connection.php';

$ID = '1';

$queryResult=$connect->query("
	SELECT
	projects.title, project_items.code, project_items.description, CONCAT(project_items.quantity,' ',project_items.uom) qty, project_items.unit_cost, project_items.estimated_budget, project_items.procurement_mode
	from projects
	LEFT OUTER JOIN project_items
	on projects.id = project_items.project_id
	where project_items.project_id = '".$ID."'");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}


echo json_encode($result);


?>