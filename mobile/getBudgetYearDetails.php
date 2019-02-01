<?php 

include 'connection.php';

$ID = $_POST["id"];

$queryResult=$connect->query("
	SELECT
	id,
	budget_year,
	fund_101,
	fund_164
	from budget_years where id = '".$ID."'");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);

?>