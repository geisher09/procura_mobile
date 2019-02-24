<?php 

include 'connection.php';

//$_POST["pid"] $_POST["uid"]

$ID = $_POST["pid"];
$UserID = $_POST["uid"];
$str = file_get_contents('C://xampp/htdocs/Procura/storage/settings.json');
$json = json_decode($str, true); // decode the JSON into an associative array
$approver = $json['pr_approver_id'];


$queryResult=$connect->query("
	SELECT purchase_requests.id prId,purchase_requests.pr_number, purchase_requests.created_at, purchase_requests.purpose, users.name approver, purchase_requests.submitted_at
	from purchase_requests
	LEFT OUTER JOIN projects
	on purchase_requests.project_id = projects.id
	LEFT OUTER JOIN users
	on users.id = '".$approver."'
	where projects.user_id = '".$UserID."'
	");

$queryResult2=$connect->query("
	SELECT purchase_requests.id prId, purchase_requests.pr_number, purchase_requests.created_at, purchase_requests.purpose, users.name approver, purchase_requests.submitted_at
	from purchase_requests
	LEFT OUTER JOIN projects
	on purchase_requests.project_id = projects.id
	LEFT OUTER JOIN users
	on users.id = '".$approver."'
	where projects.user_id = '".$UserID."' AND purchase_requests.is_approved = '1' AND purchase_requests.submitted_at is NOT NULL
	");

$queryResult3=$connect->query("
	SELECT purchase_requests.id prId, purchase_requests.pr_number, purchase_requests.created_at, purchase_requests.purpose, users.name approver, purchase_requests.submitted_at
	from purchase_requests
	LEFT OUTER JOIN projects
	on purchase_requests.project_id = projects.id
	LEFT OUTER JOIN users
	on users.id = '".$approver."'
	where projects.user_id = '".$UserID."' AND purchase_requests.is_approved = '0' AND purchase_requests.submitted_at is NOT NULL
	");

$queryResult4=$connect->query("
	SELECT purchase_requests.id prId, purchase_requests.pr_number, purchase_requests.created_at, purchase_requests.purpose, users.name approver, purchase_requests.submitted_at
	from purchase_requests
	LEFT OUTER JOIN projects
	on purchase_requests.project_id = projects.id
	LEFT OUTER JOIN users
	on users.id = '".$approver."'
	where projects.user_id = '".$UserID."' AND purchase_requests.is_approved is NULL AND purchase_requests.submitted_at is NOT NULL
	");

if($ID=='2'){
	$approved=array();

	while ($fetchData=$queryResult2->fetch_assoc()) {
		$approved[]=$fetchData;
	}

	echo json_encode($approved);
}elseif ($ID=='3') {

	$rejected=array();

	while ($fetchData=$queryResult3->fetch_assoc()) {
		$rejected[]=$fetchData;
	}

	echo json_encode($rejected);
}elseif ($ID=='4') {

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