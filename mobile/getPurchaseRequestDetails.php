<?php 

include 'connection.php';

$ID = $_POST["id"];
//$ID = '4';


$queryResult=$connect->query("
	SELECT
	purchase_requests.pr_number, project_items.uom unit, 
	CONCAT(project_items.description,' ',purchase_request_items.specifications) description, purchase_request_items.quantity, project_items.unit_cost, purchase_request_items.total_cost
	from purchase_requests
	LEFT OUTER JOIN purchase_request_items
	on purchase_requests.id = purchase_request_items.purchase_request_id
	LEFT OUTER JOIN project_items
	on purchase_request_items.project_item_id = project_items.id
	where purchase_requests.id = '".$ID."'");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);
?>


