<?php 

include 'connection.php';

//$_POST["pid"] $_POST["uid"]

$UserID = $_POST["uid"];
$str = file_get_contents('C://xampp/htdocs/Procura/storage/settings.json');
$json = json_decode($str, true); // decode the JSON into an associative array
$approver = $json['pr_approver_id'];

$PPMPResult=$connect->query("
	SELECT projects.updated_at datec, projects.user_id, projects.id, projects.title title, departments.name departmentname, users.name approver, projects.is_approved, projects.remarks, CONCAT('PPMP') requestType, CONCAT('proposal_filePPMP') proposal_file
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

$ppmp=array();

while ($PPMPData=$PPMPResult->fetch_assoc()) {
	$ppmp[]=$PPMPData;
}

$PRResult=$connect->query("
	SELECT purchase_requests.updated_at datec, purchase_requests.id, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name approver, purchase_requests.is_approved, purchase_requests.remarks, CONCAT('PR') requestType, CONCAT('proposal_filePR') proposal_file
	from purchase_requests
	LEFT OUTER JOIN projects
	on purchase_requests.project_id = projects.id
	LEFT OUTER JOIN users
	on users.id = '".$approver."'
	where projects.user_id = '".$UserID."'
	");

$pr=array();

while ($PRData=$PRResult->fetch_assoc()) {
	$pr[]=$PRData;
}

$BPResult=$connect->query("
	SELECT  budget_proposals.id, budget_proposals.proposal_file, budget_proposals.updated_at datec, budget_proposals.for_year, budget_proposals.proposal_name title, budget_proposals.amount, budget_proposals.is_approved, users.name approver, budget_proposals.remarks, CONCAT('BP') requestType
	from budget_proposals
	LEFT OUTER JOIN users
	on users.user_type_id = '2'
	where budget_proposals.user_id = '".$UserID."'
	");

$bp=array();

while ($BPData=$BPResult->fetch_assoc()) {
	$bp[]=$BPData;
}

$merge = array_merge($ppmp, $pr, $bp);

function date_compare($a, $b)
{
    $t1 = strtotime($a['datec']);
    $t2 = strtotime($b['datec']);
    return $t2 - $t1;
}    
usort($merge, 'date_compare');

echo json_encode($merge);
?>