<?php 

include 'connection.php';

//$_POST["pid"] $_POST["uid"]

$ID = $_POST["pid"];
$UserID = $_POST["uid"];


$queryResult=$connect->query("
	SELECT projects.user_id, projects.id, projects.title, projects.created_at, departments.name departmentname, users.name approver, projects.submitted_at
	from projects
	LEFT OUTER JOIN department_budgets
	on projects.department_budget_id = department_budgets.id
	LEFT OUTER JOIN departments
	on department_budgets.id = departments.id
	LEFT OUTER JOIN sectors
	on departments.sector_id = sectors.id
	LEFT OUTER JOIN sector_heads
	on sectors.id = sector_heads.sector_id
	LEFT OUTER JOIN users
	on sector_heads.id = users.userable_id
	where projects.user_id = '".$UserID."' AND users.user_type_id = '3'
	");

$queryResult2=$connect->query("
	SELECT projects.user_id, projects.id, projects.title, projects.created_at, departments.name departmentname, users.name approver, projects.submitted_at
	from projects
	LEFT OUTER JOIN department_budgets
	on projects.department_budget_id = department_budgets.id
	LEFT OUTER JOIN departments
	on department_budgets.id = departments.id
	LEFT OUTER JOIN sectors
	on departments.sector_id = sectors.id
	LEFT OUTER JOIN sector_heads
	on sectors.id = sector_heads.sector_id
	LEFT OUTER JOIN users
	on sector_heads.id = users.userable_id
	where projects.user_id = '".$UserID."' AND users.user_type_id = '3' AND projects.is_approved = '1'
	");

$queryResult3=$connect->query("
	SELECT projects.user_id, projects.id, projects.title, projects.created_at, departments.name departmentname, users.name approver, projects.submitted_at
	from projects
	LEFT OUTER JOIN department_budgets
	on projects.department_budget_id = department_budgets.id
	LEFT OUTER JOIN departments
	on department_budgets.id = departments.id
	LEFT OUTER JOIN sectors
	on departments.sector_id = sectors.id
	LEFT OUTER JOIN sector_heads
	on sectors.id = sector_heads.sector_id
	LEFT OUTER JOIN users
	on sector_heads.id = users.userable_id
	where projects.user_id = '".$UserID."' AND users.user_type_id = '3' AND projects.is_approved = '0'
	");

$queryResult4=$connect->query("
	SELECT projects.user_id, projects.id, projects.title, projects.created_at, departments.name departmentname, users.name approver, projects.submitted_at
	from projects
	LEFT OUTER JOIN department_budgets
	on projects.department_budget_id = department_budgets.id
	LEFT OUTER JOIN departments
	on department_budgets.id = departments.id
	LEFT OUTER JOIN sectors
	on departments.sector_id = sectors.id
	LEFT OUTER JOIN sector_heads
	on sectors.id = sector_heads.sector_id
	LEFT OUTER JOIN users
	on sector_heads.id = users.userable_id
	where projects.user_id = '".$UserID."' AND users.user_type_id = '3' AND projects.is_approved is NULL
	");

if($ID==2){
	$approved=array();

	while ($fetchData=$queryResult2->fetch_assoc()) {
		$approved[]=$fetchData;
	}

	echo json_encode($approved);
}elseif ($ID==3) {

	$rejected=array();

	while ($fetchData=$queryResult3->fetch_assoc()) {
		$rejected[]=$fetchData;
	}

	echo json_encode($rejected);
}elseif ($ID==4) {

	$pending=array();

	while ($fetchData=$queryResult4->fetch_assoc()) {
		$pending[]=$fetchData;
	}

	echo json_encode($pending);
}else{
	$all=array();

	while ($fetchData=$queryResult->fetch_assoc()) {
		$all[]=$fetchData;
	}

	echo json_encode($all);
}

?>