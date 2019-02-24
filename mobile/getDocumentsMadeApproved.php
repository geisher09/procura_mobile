<?php
include 'connection.php';

//$_POST["pid"] $_POST["uid"]

$UserID = $_POST["uid"];
//$UserID = '2';
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

$total = sizeof($ppmp)+sizeof($pr)+sizeof($bp);

$doc = array("TOTAL");
$doc2 = array($total);


$merge = array_combine($doc,$doc2);

$PPMPResult2=$connect->query("
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
	where projects.user_id = '".$UserID."' AND users.user_type_id = '3' AND projects.is_approved ='1'
	");

$ppmp2=array();

while ($PPMPData2=$PPMPResult2->fetch_assoc()) {
	$ppmp2[]=$PPMPData2;
}

$PRResult2=$connect->query("
	SELECT purchase_requests.updated_at datec, purchase_requests.id, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name approver, purchase_requests.is_approved, purchase_requests.remarks, CONCAT('PR') requestType, CONCAT('proposal_filePR') proposal_file
	from purchase_requests
	LEFT OUTER JOIN projects
	on purchase_requests.project_id = projects.id
	LEFT OUTER JOIN users
	on users.id = '".$approver."'
	where projects.user_id = '".$UserID."' AND purchase_requests.is_approved='1'
	");

$pr2=array();

while ($PRData2=$PRResult2->fetch_assoc()) {
	$pr2[]=$PRData2;
}

$BPResult2=$connect->query("
	SELECT  budget_proposals.id, budget_proposals.proposal_file, budget_proposals.updated_at datec, budget_proposals.for_year, budget_proposals.proposal_name title, budget_proposals.amount, budget_proposals.is_approved, users.name approver, budget_proposals.remarks, CONCAT('BP') requestType
	from budget_proposals
	LEFT OUTER JOIN users
	on users.user_type_id = '2' 
	where budget_proposals.user_id = '".$UserID."' AND budget_proposals.is_approved='1'
	");

$bp2=array();

while ($BPData2=$BPResult2->fetch_assoc()) {
	$bp2[]=$BPData2;
}

$ppmpcount2 = sizeof($ppmp2);
$prcount2 = sizeof($pr2);
$bpcount2 = sizeof($bp2);

$doc2 = array('PPMP','PR', 'BP');
$doc22 = array(sizeof($ppmp2), sizeof($pr2), sizeof($bp2));
$doc3 = array('DIFF');
$diff = array($total-(sizeof($ppmp2)+sizeof($pr2)+sizeof($bp2)));
$doc4 = array('TD');
$td = array($total-($total-(sizeof($ppmp2)+sizeof($pr2)+sizeof($bp2))));

$merge2 = array_combine($doc2,$doc22);
$merge3 = array_combine($doc3,$diff);
$merge4 = array_combine($doc4,$td);
$mergedcount = array_merge($merge2, $merge, $merge3,$merge4);
echo json_encode($mergedcount);
?>
