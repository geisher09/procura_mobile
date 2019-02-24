<?php 

include 'connection.php';

$ID = $_POST["id"];
$User_ID = $_POST["uid"];
//$ID = '2';

if($ID == '1'){
	$queryResult=$connect->query("
		SELECT
		budget_years.is_active,
		sector_budgets.id,
		sector_budgets.sector_id,
		sector_budgets.fund_101 + sector_budgets.fund_164 total,
		IFNULL((SUM(sector_budgets.fund_101)+SUM(sector_budgets.fund_164)),'0') totalAlloc,
		IFNULL(((budget_years.fund_101 + budget_years.fund_164) - (SUM(sector_budgets.fund_101) + SUM(sector_budgets.fund_164))), budget_years.fund_101 + budget_years.fund_164) leftAlloc
		from sector_budgets
		LEFT OUTER JOIN budget_years
		on sector_budgets.budget_year_id = budget_years.id
		LEFT OUTER JOIN sectors
		on sector_budgets.sector_id = sectors.id
		LEFT OUTER JOIN sector_heads
		on sectors.id = sector_heads.sector_id
		LEFT OUTER JOIN users
		on sector_heads.id = users.userable_id
		where users.id = '".$User_ID."' AND budget_years.is_active='1' AND user_type_id = '3'");

	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	$queryResult2 = $connect->query("
		SELECT * from department_budgets
		where department_budgets.sector_budget_id = '".$result[0]['id']."'
		");

	$result2=array();

	while ($fetchData2=$queryResult2->fetch_assoc()) {
		$result2[]=$fetchData2;
	}

	$totalfund_101 = 0;
	$totalfund_164 = 0;
	for($i=0; $i<sizeof($result2); $i++){
		$totalfund_101 += $result2[$i]['fund_101'];
		$totalfund_164 += $result2[$i]['fund_164'];
	}
	$tot = $totalfund_101+$totalfund_164;

	$result[0]['totalAlloc'] = strval($tot);
	$result[0]['leftAlloc'] = strval($result[0]['total']-$result[0]['totalAlloc']);

	echo json_encode($result);
}else{
	$queryResult=$connect->query("
		SELECT
		budget_years.is_active,
		sector_budgets.id,
		sector_budgets.sector_id,
		sector_budgets.fund_101 + sector_budgets.fund_164 total,
		IFNULL((SUM(sector_budgets.fund_101)+SUM(sector_budgets.fund_164)),'0') totalAlloc,
		IFNULL(((budget_years.fund_101 + budget_years.fund_164) - (SUM(sector_budgets.fund_101) + SUM(sector_budgets.fund_164))), budget_years.fund_101 + budget_years.fund_164) leftAlloc
		from sector_budgets
		LEFT OUTER JOIN budget_years
		on sector_budgets.budget_year_id = budget_years.id
		LEFT OUTER JOIN sectors
		on sector_budgets.sector_id = sectors.id
		LEFT OUTER JOIN sector_heads
		on sectors.id = sector_heads.sector_id
		LEFT OUTER JOIN users
		on sector_heads.id = users.userable_id
		where users.id = '".$User_ID."' AND budget_years.is_active='1' AND user_type_id = '3'");

	$result=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$result[]=$fetchData;
	}

	$queryResult2 = $connect->query("
		SELECT * from department_budgets
		where department_budgets.sector_budget_id = '".$result[0]['id']."'
		");

	$result2=array();

	while ($fetchData2=$queryResult2->fetch_assoc()) {
		$result2[]=$fetchData2;
	}

	$totalfund_101 = 0;
	$totalfund_164 = 0;
	for($i=0; $i<sizeof($result2); $i++){
		$totalfund_101 += $result2[$i]['fund_101'];
		$totalfund_164 += $result2[$i]['fund_164'];
	}
	$tot = $totalfund_101+$totalfund_164;

	$result[0]['totalAlloc'] = $tot;
	$result[0]['leftAlloc'] = $result[0]['total']-$result[0]['totalAlloc'];

	$queryResult=$connect->query(
		"SELECT
		sectors.id sectorid,
		sector_budgets.id,
		sectors.name,
		coalesce(sector_budgets.fund_101, 'Unallocated') fund_101,
		coalesce(sector_budgets.fund_164, 'Unallocated') fund_164
		from sectors
		LEFT JOIN sector_budgets
		on sectors.id=sector_budgets.sector_id
		WHERE sector_budgets.id = '".$result[0]['id']."'
		");


	$resultSECT=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$resultSECT[]=$fetchData;
	}

	echo json_encode($resultSECT);
}




?>