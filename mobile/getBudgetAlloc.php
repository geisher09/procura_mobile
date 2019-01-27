<?php 

include 'connection.php';

$queryResult=$connect->query("
	SELECT
	sectors.name as sectorname,
	departments.name departmentname,
	coalesce(department_budgets.fund_101, 'Unallocated') fund_101,
	coalesce(department_budgets.fund_164, 'Unallocated') fund_164
	from departments
	LEFT OUTER JOIN department_budgets
	on departments.id=department_budgets.id
	LEFT OUTER JOIN sectors
	on departments.sector_id=sectors.id
	");


$result=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
}

echo json_encode($result);

?>