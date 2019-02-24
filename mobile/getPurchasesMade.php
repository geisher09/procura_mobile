<?php 

include 'connection.php';

//$_POST["pid"] $_POST["uid"]

$UserID = $_POST["uid"];
//$UserID = '2';
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
	where projects.user_id = '".$UserID."' AND purchase_requests.submitted_at IS NOT NULL ORDER BY purchase_requests.submitted_at LIMIT 10
	");

$all=array();

while ($fetchData=$queryResult->fetch_assoc()) {
	$all[]=$fetchData;
}

//echo json_encode($all);
$totall = 0;
$alltot = array();
	$result2=array();

for($i=0; $i<sizeof($all); $i++){
	$queryResult2=$connect->query("
		SELECT
		purchase_request_items.total_cost
		from purchase_requests
		LEFT OUTER JOIN purchase_request_items
		on purchase_requests.id = purchase_request_items.purchase_request_id
		LEFT OUTER JOIN project_items
		on purchase_request_items.project_item_id = project_items.id
		where purchase_requests.id = '".$all[$i]['prId']."'");

	$result=array();
	$sum = 0;

	while ($fetchData=$queryResult2->fetch_assoc()) {
		$result[]=$fetchData;
	}
	//echo json_encode(array_sum($result));
	//echo json_encode($result[1]);
	foreach ($result as $item) {
		$sum += $item['total_cost'];
	}
	$result2[] = array('id'=>$i, 'tot' => $sum);
}
echo json_encode($result2);

?>