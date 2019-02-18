<?php 

include 'connection.php';

$UserID = $_POST["uid"];
//$UserID = '6';
//QUERY FOR DEPTS UNDER SECTORHEAD
$deptHeadResult=$connect->query("
	SELECT department_heads.id
	from department_heads
	LEFT JOIN departments
	on department_heads.department_id = departments.id
	LEFT JOIN sectors
	on departments.sector_id = sectors.id
	LEFT JOIN sector_heads
	on sectors.id = sector_heads.sector_id
	LEFT JOIN users
	on sector_heads.id = users.userable_id
	where users.id = '".$UserID."'
	");
$deptHeads=array();

while ($fetchData=$deptHeadResult->fetch_assoc()) {
	$deptHeads[]=$fetchData;
}

$department=array();
for($i=0; $i<sizeof($deptHeads); $i++){
	$deptResult=$connect->query("
		SELECT users.id, users.name
		from users
		where users.userable_id = '".$deptHeads[$i]['id']."' AND users.user_type_id = '1'
		");

	while ($fetchData2=$deptResult->fetch_assoc()) {
		$department[]=$fetchData2;
	}
}

$pendingPPMP=array();
$senderPen=array();
$pendingPR=array();
$senderPen2=array();
for($i=0; $i<sizeof($department); $i++){
	$queryResult4=$connect->query("
		SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.updated_at datec , departments.name departmentname, CONCAT('PPMP') requestType
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
		where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved is NULL
		");
	while ($fetchData=$queryResult4->fetch_assoc()) {
		$pendingPPMP[]=$fetchData;
	}
	$queryResult5=$connect->query("
		SELECT projects.user_id, purchase_requests.id, purchase_requests.pr_number, purchase_requests.updated_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
		from purchase_requests
		LEFT OUTER JOIN projects
		on purchase_requests.project_id = projects.id
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
		where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND purchase_requests.is_approved is NULL
		");
	while ($fetchData2=$queryResult5->fetch_assoc()) {
		$pendingPR[]=$fetchData2;
	}

}

for($i=0; $i<sizeof($pendingPPMP); $i++){
	$querySenderApp=$connect->query("
		SELECT users.id, users.name, users.user_image
		from users
		where users.id = '".$pendingPPMP[$i]['user_id']."' AND users.user_type_id = '1'
		");

	while ($fetchData=$querySenderApp->fetch_assoc()) {
		$senderPen[]=$fetchData;
		$pendingPPMP[$i]['name'] = $senderPen[$i]['name'];
		$pendingPPMP[$i]['user_image'] = $senderPen[$i]['user_image'];
	}
}

for($i=0; $i<sizeof($pendingPR); $i++){
	$querySenderApp2=$connect->query("
		SELECT users.id, users.name, users.user_image
		from users
		where users.id = '".$pendingPR[$i]['user_id']."' AND users.user_type_id = '1'
		");

	while ($fetchData=$querySenderApp2->fetch_assoc()) {
		$senderPen2[]=$fetchData;
		$pendingPR[$i]['name'] = $senderPen2[$i]['name'];
		$pendingPR[$i]['user_image'] = $senderPen2[$i]['user_image'];
	}
}


$merge = array_merge($pendingPPMP, $pendingPR);

function date_compare($a, $b)
{
    $t1 = strtotime($a['datec']);
    $t2 = strtotime($b['datec']);
    return $t2 - $t1;
}    
usort($merge, 'date_compare');

echo json_encode($merge);

?>