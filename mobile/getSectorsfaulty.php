<?php 

include 'connection.php';

$ID = $_POST["pid"];
$yearID = $_POST["yid"];

if($ID == '1'){
	$queryResult=$connect->query(
		"SELECT
		sectors.name,
		coalesce(sector_budgets.fund_101, 'Unallocated') fund_101,
		coalesce(sector_budgets.fund_164, 'Unallocated') fund_164
		from sectors
		LEFT JOIN sector_budgets
		on sectors.id=sector_budgets.sector_id
		LEFT JOIN budget_years
		on sector_budgets.budget_year_id = budget_years.id
		WHERE budget_years.is_active = '1'
		");


	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	echo json_encode($result);
}else{
	$queryResult2=$connect->query("
		SELECT
		sectors.name,
		coalesce(sector_budgets.fund_101, 'Unallocated') fund_101,
		coalesce(sector_budgets.fund_164, 'Unallocated') fund_164
		from sectors
		LEFT JOIN sector_budgets
		on sectors.id=sector_budgets.sector_id
		LEFT JOIN budget_years
		on sector_budgets.budget_year_id = budget_years.id
		WHERE budget_years.id = '".$yearID."'
		");


	$result2=array();

	while ($fetchData2=$queryResult2->fetch_assoc()) {
		$result2[]=$fetchData2;
	}

	echo json_encode($result2);
}


?>