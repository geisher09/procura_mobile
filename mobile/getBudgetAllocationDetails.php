<?php 

include 'connection.php';

$ID = $_POST["pid"];
$yearID = $_POST["yid"];


if($ID == '1'){
	$queryResult=$connect->query("
		SELECT
		budget_years.is_active,
		budget_years.id,
		budget_years.fund_101 + budget_years.fund_164 total,
		IFNULL((SUM(sector_budgets.fund_101)+SUM(sector_budgets.fund_164)),'0') totalAlloc,
		IFNULL(((budget_years.fund_101 + budget_years.fund_164) - (SUM(sector_budgets.fund_101) + SUM(sector_budgets.fund_164))), budget_years.fund_101 + budget_years.fund_164) leftAlloc	from budget_years
		LEFT OUTER JOIN sector_budgets
		on budget_years.id=sector_budgets.budget_year_id where budget_years.is_active='1'");

	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	echo json_encode($result);
}else{
	$queryResult2=$connect->query("
	SELECT
	budget_years.is_active,
	budget_years.id,
	budget_years.fund_101 + budget_years.fund_164 total,
	IFNULL((SUM(sector_budgets.fund_101)+SUM(sector_budgets.fund_164)),'0') totalAlloc,
	IFNULL(((budget_years.fund_101 + budget_years.fund_164) - (SUM(sector_budgets.fund_101) + SUM(sector_budgets.fund_164))), budget_years.fund_101 + budget_years.fund_164) leftAlloc	from budget_years
	LEFT OUTER JOIN sector_budgets
	on budget_years.id=sector_budgets.budget_year_id where budget_years.id='".$yearID."'");

	$result2=array();

	while ($fetchData2=$queryResult2->fetch_assoc()) {
		$result2[]=$fetchData2;
	}

	echo json_encode($result2);
}



?>