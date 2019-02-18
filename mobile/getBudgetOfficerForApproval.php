<?php 

include 'connection.php';

$queryResult4=$connect->query("
	SELECT budget_proposals.id proposal_id, budget_proposals.for_year, budget_proposals.proposal_name title, budget_proposals.proposal_file, budget_proposals.amount, budget_proposals.is_approved, budget_proposals.remarks, budget_proposals.updated_at datec, users.id user_id, users.name, users.user_image, departments.name departmentname, CONCAT('BP') requestType
	from budget_proposals
	LEFT OUTER JOIN users
	on budget_proposals.user_id = users.id
	LEFT OUTER JOIN departments
	on budget_proposals.department_id = departments.id 
	where budget_proposals.is_approved IS NULL ");



$pending=array();

while ($fetchData=$queryResult4->fetch_assoc()) {
	$pending[]=$fetchData;
}

echo json_encode($pending);
?>