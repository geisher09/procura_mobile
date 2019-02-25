<?php 

include 'connection.php';

$UserID = $_POST["uid"];
//$UserID = '6';
//QUERY FOR DEPTS UNDER SECTORHEAD
$str = file_get_contents('C://xampp/htdocs/Procura/storage/settings.json');
$json = json_decode($str, true); // decode the JSON into an associative array
$approver = $json['pr_approver_id'];

if($UserID == $approver){
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
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at datec , departments.name departmentname, CONCAT('PPMP') requestType
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved ='1' AND projects.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
			");
		while ($fetchData=$queryResult4->fetch_assoc()) {
			$pendingPPMP[]=$fetchData;
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
	
	$queryResult5=$connect->query("
		SELECT projects.user_id, purchase_requests.id, purchase_requests.pr_number, purchase_requests.submitted_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
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

	$pendingPPMP2=array();
	$senderPen2=array();
	$pendingPR2=array();
	$senderPen22=array();
	for($i=0; $i<sizeof($department); $i++){
		$queryResult42=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at datec , departments.name departmentname, CONCAT('PPMP') requestType
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved ='0' AND projects.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
			");
		while ($fetchData2=$queryResult42->fetch_assoc()) {
			$pendingPPMP2[]=$fetchData2;
		}

	}

	for($i=0; $i<sizeof($pendingPPMP2); $i++){
		$querySenderApp2=$connect->query("
			SELECT users.id, users.name, users.user_image
			from users
			where users.id = '".$pendingPPMP2[$i]['user_id']."' AND users.user_type_id = '1'
			");

		while ($fetchData2=$querySenderApp2->fetch_assoc()) {
			$senderPen2[]=$fetchData2;
			$pendingPPMP2[$i]['name'] = $senderPen2[$i]['name'];
			$pendingPPMP2[$i]['user_image'] = $senderPen2[$i]['user_image'];
		}
	}
	
	$queryResult52=$connect->query("
		SELECT projects.user_id, purchase_requests.id, purchase_requests.pr_number, purchase_requests.submitted_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
		from purchase_requests
		LEFT OUTER JOIN projects
		on purchase_requests.project_id = projects.id
		LEFT OUTER JOIN department_budgets
		on projects.department_budget_id = department_budgets.id
		LEFT OUTER JOIN departments
		on department_budgets.id = departments.id
		LEFT OUTER JOIN users
		on projects.user_id = users.id
		where purchase_requests.is_approved ='0' AND purchase_requests.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
		");
	while ($fetchData22=$queryResult52->fetch_assoc()) {
		$pendingPR2[]=$fetchData22;
	}

	$pendingPPMP3=array();
	$senderPen3=array();
	$pendingPR3=array();
	$senderPen23=array();
	for($i=0; $i<sizeof($department); $i++){
		$queryResult43=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at datec , departments.name departmentname, CONCAT('PPMP') requestType
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved IS NULL AND projects.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
			");
		while ($fetchData3=$queryResult43->fetch_assoc()) {
			$pendingPPMP3[]=$fetchData3;
		}

	}

	for($i=0; $i<sizeof($pendingPPMP3); $i++){
		$querySenderApp3=$connect->query("
			SELECT users.id, users.name, users.user_image
			from users
			where users.id = '".$pendingPPMP3[$i]['user_id']."' AND users.user_type_id = '1'
			");

		while ($fetchData3=$querySenderApp3->fetch_assoc()) {
			$senderPen3[]=$fetchData3;
			$pendingPPMP3[$i]['name'] = $senderPen3[$i]['name'];
			$pendingPPMP3[$i]['user_image'] = $senderPen3[$i]['user_image'];
		}
	}
	
	$queryResult53=$connect->query("
		SELECT projects.user_id, purchase_requests.id, purchase_requests.pr_number, purchase_requests.submitted_at datec, CONCAT('Purchase Request: ',purchase_requests.pr_number) title, purchase_requests.purpose, users.name, users.user_image, departments.name departmentname, CONCAT('PR') requestType
		from purchase_requests
		LEFT OUTER JOIN projects
		on purchase_requests.project_id = projects.id
		LEFT OUTER JOIN department_budgets
		on projects.department_budget_id = department_budgets.id
		LEFT OUTER JOIN departments
		on department_budgets.id = departments.id
		LEFT OUTER JOIN users
		on projects.user_id = users.id
		where purchase_requests.is_approved IS NULL AND purchase_requests.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
		");
	while ($fetchData23=$queryResult53->fetch_assoc()) {
		$pendingPR3[]=$fetchData23;
	}

	$approved = sizeof($pendingPPMP)+sizeof($pendingPR);
	$rejected = sizeof($pendingPPMP2)+sizeof($pendingPR2);
	$pendings = sizeof($pendingPPMP3)+sizeof($pendingPR3);
	$total = $approved+$rejected+$pendings;
	$doc = array(array('APPROVED' => $approved, 'REJECTED' => $rejected, 'PENDING' => $pendings, 'TOTAL' => $total));

	echo json_encode($doc);
	//echo json_encode($doc['PR']);
}else{
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
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at datec , departments.name departmentname, CONCAT('PPMP') requestType
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved ='1' AND projects.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
			");
		while ($fetchData=$queryResult4->fetch_assoc()) {
			$pendingPPMP[]=$fetchData;
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

	$pendingPPMP2=array();
	$senderPen2=array();
	$pendingPR2=array();
	$senderPen22=array();
	for($i=0; $i<sizeof($department); $i++){
		$queryResult42=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at datec , departments.name departmentname, CONCAT('PPMP') requestType
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved ='0' AND projects.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
			");
		while ($fetchData2=$queryResult42->fetch_assoc()) {
			$pendingPPMP2[]=$fetchData2;
		}

	}

	for($i=0; $i<sizeof($pendingPPMP2); $i++){
		$querySenderApp2=$connect->query("
			SELECT users.id, users.name, users.user_image
			from users
			where users.id = '".$pendingPPMP2[$i]['user_id']."' AND users.user_type_id = '1'
			");

		while ($fetchData2=$querySenderApp2->fetch_assoc()) {
			$senderPen2[]=$fetchData2;
			$pendingPPMP2[$i]['name'] = $senderPen2[$i]['name'];
			$pendingPPMP2[$i]['user_image'] = $senderPen2[$i]['user_image'];
		}
	}

	$pendingPPMP3=array();
	$senderPen3=array();
	$pendingPR3=array();
	$senderPen23=array();
	for($i=0; $i<sizeof($department); $i++){
		$queryResult43=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at datec , departments.name departmentname, CONCAT('PPMP') requestType
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved IS NULL AND projects.submitted_at is NOT NULL ORDER BY projects.submitted_at DESC
			");
		while ($fetchData3=$queryResult43->fetch_assoc()) {
			$pendingPPMP3[]=$fetchData3;
		}

	}

	for($i=0; $i<sizeof($pendingPPMP3); $i++){
		$querySenderApp3=$connect->query("
			SELECT users.id, users.name, users.user_image
			from users
			where users.id = '".$pendingPPMP3[$i]['user_id']."' AND users.user_type_id = '1'
			");

		while ($fetchData3=$querySenderApp3->fetch_assoc()) {
			$senderPen3[]=$fetchData3;
			$pendingPPMP3[$i]['name'] = $senderPen3[$i]['name'];
			$pendingPPMP3[$i]['user_image'] = $senderPen3[$i]['user_image'];
		}
	}

	$approved = sizeof($pendingPPMP);
	$rejected = sizeof($pendingPPMP2);
	$pendings = sizeof($pendingPPMP3);
	$total = $approved+$rejected+$pendings;
	$doc = array(array('APPROVED' => $approved, 'REJECTED' => $rejected,
'PENDING' => $pendings, 'TOTAL' => $total));

	echo json_encode($doc);
}


?>