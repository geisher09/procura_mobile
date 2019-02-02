<?php 

include 'connection.php';

$queryResult=$connect->query("
	SELECT
	id,
	budget_year
	from budget_years");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);

?>