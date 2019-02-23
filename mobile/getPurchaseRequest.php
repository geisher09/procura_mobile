<?php 

include 'connection.php';

$ID = $_POST["pid"];


if($ID == '1'){
	$pendingPR = array();
	$queryResult5=$connect->query("
		SELECT projects.user_id, purchase_requests.id prId, purchase_requests.pr_number, purchase_requests.submitted_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
		from purchase_requests
		LEFT OUTER JOIN projects
		on purchase_requests.project_id = projects.id
		LEFT OUTER JOIN department_budgets
		on projects.department_budget_id = department_budgets.id
		LEFT OUTER JOIN departments
		on department_budgets.id = departments.id
		LEFT OUTER JOIN users
		on projects.user_id = users.id
		where purchase_requests.is_approved IS NULL AND purchase_requests.submitted_at is NOT NULL
		");
	while ($fetchData2=$queryResult5->fetch_assoc()) {
		$pendingPR[]=$fetchData2;
	}

	echo json_encode($pendingPR);

}else if($ID == '2'){
	$approvedPR = array();
	$queryResult5=$connect->query("
		SELECT projects.user_id, purchase_requests.id prId, purchase_requests.pr_number, purchase_requests.submitted_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
		from purchase_requests
		LEFT OUTER JOIN projects
		on purchase_requests.project_id = projects.id
		LEFT OUTER JOIN department_budgets
		on projects.department_budget_id = department_budgets.id
		LEFT OUTER JOIN departments
		on department_budgets.id = departments.id
		LEFT OUTER JOIN users
		on projects.user_id = users.id
		where purchase_requests.is_approved = '1' AND purchase_requests.submitted_at is NOT NULL
		");
	while ($fetchData2=$queryResult5->fetch_assoc()) {
		$approvedPR[]=$fetchData2;
	}

	echo json_encode($approvedPR);

}else{
	$rejectedPR = array();
	$queryResult5=$connect->query("
		SELECT projects.user_id, purchase_requests.id prId, purchase_requests.pr_number, purchase_requests.submitted_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
		from purchase_requests
		LEFT OUTER JOIN projects
		on purchase_requests.project_id = projects.id
		LEFT OUTER JOIN department_budgets
		on projects.department_budget_id = department_budgets.id
		LEFT OUTER JOIN departments
		on department_budgets.id = departments.id
		LEFT OUTER JOIN users
		on projects.user_id = users.id
		where purchase_requests.is_approved = '0' AND purchase_requests.submitted_at is NOT NULL
		");
	while ($fetchData2=$queryResult5->fetch_assoc()) {
		$rejectedPR[]=$fetchData2;
	}

	echo json_encode($rejectedPR);
	
}



?>