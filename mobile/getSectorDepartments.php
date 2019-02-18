<?php 

include 'connection.php';

$ID = $_POST["id"];
//$ID = '5';

$queryResult=$connect->query("
	SELECT
	departments.name departmentname,
	coalesce(department_budgets.fund_101, 'Unallocated') dfund_101,
	coalesce(department_budgets.fund_164, 'Unallocated') dfund_164
	from departments
	LEFT OUTER JOIN department_budgets
	on departments.id=department_budgets.department_id
	LEFT OUTER JOIN sector_budgets
	on department_budgets.sector_budget_id = sector_budgets.id
	WHERE department_budgets.sector_budget_id = '".$ID."'");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);

?>