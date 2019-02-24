<?php 

include 'connection.php';

$ID = $_POST["uid"];
//$ID = '7';

$queryResult=$connect->query(
		"SELECT
		budget_years.budget_year year,
		sector_budgets.fund_101,
		sector_budgets.fund_164,
		sector_budgets.fund_101 + sector_budgets.fund_164 total
		from budget_years
		LEFT JOIN sector_budgets
		on budget_years.id = sector_budgets.budget_year_id
		LEFT JOIN sectors
		on sector_budgets.sector_id=sectors.id
		LEFT JOIN sector_heads
		on sectors.id = sector_heads.sector_id
		LEFT JOIN users
		on sector_heads.id = users.userable_id
		WHERE users.id = '".$ID."' AND users.user_type_id = '3' ORDER BY budget_years.budget_year DESC
		");


	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	echo json_encode($result);


?>