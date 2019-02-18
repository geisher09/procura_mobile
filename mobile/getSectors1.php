<?php 

include 'connection.php';

$queryResult=$connect->query("
	SELECT
	sectors.name,
	coalesce(sector_budgets.fund_101, 'Unallocated') fund_101,
	coalesce(sector_budgets.fund_164, 'Unallocated') fund_164
	from sectors
	LEFT OUTER JOIN sector_budgets
	on sectors.id=sector_budgets.sector_id and sector_budgets.budget_year_id = '1' ORDER BY sectors.id");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);

?>