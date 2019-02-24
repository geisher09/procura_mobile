<?php 

include 'connection.php';

$UserID = $_POST["uid"];
//$UserID = '5';
//QUERY FOR DEPTS UNDER SECTORHEAD
$str = file_get_contents('C://xampp/htdocs/Procura/storage/settings.json');
$json = json_decode($str, true); // decode the JSON into an associative array
$approver = $json['pr_approver_id'];

if($UserID == $approver){
	$pendingPR = array();

	$queryResult5=$connect->query("
		SELECT projects.user_id, purchase_requests.id proposal_id, purchase_requests.pr_number, purchase_requests.submitted_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
		from purchase_requests
		LEFT OUTER JOIN projects
		on purchase_requests.project_id = projects.id
		LEFT OUTER JOIN department_budgets
		on projects.department_budget_id = department_budgets.id
		LEFT OUTER JOIN departments
		on department_budgets.id = departments.id
		LEFT OUTER JOIN users
		on projects.user_id = users.id
		where purchase_requests.is_approved ='1' AND purchase_requests.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
		");
	while ($fetchData2=$queryResult5->fetch_assoc()) {
		$pendingPR[]=$fetchData2;
	}

	$queryResult4=$connect->query("
		SELECT budget_proposals.id proposal_id, budget_proposals.for_year, budget_proposals.proposal_name title, budget_proposals.proposal_file, budget_proposals.amount, budget_proposals.is_approved, budget_proposals.remarks, budget_proposals.updated_at datec, users.id user_id, users.name, users.user_image, departments.name departmentname, CONCAT('BP') requestType
		from budget_proposals
		LEFT OUTER JOIN users
		on budget_proposals.user_id = users.id
		LEFT OUTER JOIN departments
		on budget_proposals.department_id = departments.id 
		where budget_proposals.is_approved ='1' ORDER BY budget_proposals.updated_at DESC");



	$pending=array();

	while ($fetchData=$queryResult4->fetch_assoc()) {
		$pending[]=$fetchData;
	}

	$merge = array_merge($pending, $pendingPR);

	$prcount = sizeof($pendingPR);
	$bpcount = sizeof($pending);

	$doc = array('BP' => strval($bpcount), 'PR' => strval($prcount));

	echo json_encode($doc);

}else{
	$queryResult4=$connect->query("
		SELECT budget_proposals.id proposal_id, budget_proposals.for_year, budget_proposals.proposal_name title, budget_proposals.proposal_file, budget_proposals.amount, budget_proposals.is_approved, budget_proposals.remarks, budget_proposals.updated_at datec, users.id user_id, users.name, users.user_image, departments.name departmentname, CONCAT('BP') requestType
		from budget_proposals
		LEFT OUTER JOIN users
		on budget_proposals.user_id = users.id
		LEFT OUTER JOIN departments
		on budget_proposals.department_id = departments.id 
		where budget_proposals.is_approved ='1' ORDER BY budget_proposals.updated_at DESC");



	$pending=array();

	while ($fetchData=$queryResult4->fetch_assoc()) {
		$pending[]=$fetchData;
	}

	//$prcount = sizeof($pendingPR);
	$bpcount = sizeof($pending);

	$doc = array('BP' => strval($bpcount), 'PR' => 0);

	echo json_encode($doc);
}

?>