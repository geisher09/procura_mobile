<?php 

include 'connection.php';

$ID = $_POST["id"];

$queryResult=$connect->query("
	SELECT
	departments.name departmentname,
	coalesce(department_budgets.fund_101, 'Unallocated') dfund_101,
	coalesce(department_budgets.fund_164, 'Unallocated') dfund_164
	from departments
	LEFT OUTER JOIN department_budgets
	on departments.id=department_budgets.id
	LEFT OUTER JOIN sectors
	on departments.sector_id=sectors.id
	LEFT OUTER JOIN sector_budgets
	on sector_budgets.sector_id=sectors.id
	WHERE sectors.id = '".$ID."'");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);

?>