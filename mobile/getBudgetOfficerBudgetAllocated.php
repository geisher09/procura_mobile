<?php 

include 'connection.php';

$queryResult=$connect->query("
	SELECT
	id,
	budget_year,
	is_active,
	fund_101,
	fund_164,
	fund_101 + fund_164 total
	from budget_years ORDER BY budget_year DESC");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);

?>