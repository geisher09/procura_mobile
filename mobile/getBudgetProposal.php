<?php 

include 'connection.php';

$ID = $_POST["id"];

$queryResult=$connect->query("
	SELECT budget_proposals.id, budget_proposals.for_year, budget_proposals.proposal_name, budget_proposals.proposal_file, budget_proposals.amount, budget_proposals.is_approved, users.id user_id, users.name, users.user_image, departments.name departmentname
	from budget_proposals
	LEFT OUTER JOIN users
	on budget_proposals.user_id = users.id
	LEFT OUTER JOIN departments
	on budget_proposals.department_id = departments.id ORDER BY budget_proposals.updated_at ASC
	");

$queryResult2=$connect->query("
	SELECT budget_proposals.id, budget_proposals.for_year, budget_proposals.proposal_name, budget_proposals.proposal_file, budget_proposals.amount, budget_proposals.is_approved, users.id user_id, users.name, users.user_image, departments.name departmentname
	from budget_proposals
	LEFT OUTER JOIN users
	on budget_proposals.user_id = users.id
	LEFT OUTER JOIN departments
	on budget_proposals.department_id = departments.id 
	where budget_proposals.is_approved = '1' ORDER BY budget_proposals.updated_at DESC");

$queryResult3=$connect->query("
	SELECT budget_proposals.id, budget_proposals.for_year, budget_proposals.proposal_name, budget_proposals.proposal_file, budget_proposals.amount, budget_proposals.is_approved, users.id user_id, users.name, users.user_image, departments.name departmentname
	from budget_proposals
	LEFT OUTER JOIN users
	on budget_proposals.user_id = users.id
	LEFT OUTER JOIN departments
	on budget_proposals.department_id = departments.id 
	where budget_proposals.is_approved = '0' ORDER BY budget_proposals.updated_at DESC");

$queryResult4=$connect->query("
	SELECT budget_proposals.id, budget_proposals.for_year, budget_proposals.proposal_name, budget_proposals.proposal_file, budget_proposals.amount, budget_proposals.is_approved, users.id user_id, users.name, users.user_image, departments.name departmentname
	from budget_proposals
	LEFT OUTER JOIN users
	on budget_proposals.user_id = users.id
	LEFT OUTER JOIN departments
	on budget_proposals.department_id = departments.id 
	where budget_proposals.is_approved IS NULL ORDER BY budget_proposals.updated_at ASC");
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