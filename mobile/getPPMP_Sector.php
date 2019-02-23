<?php 

include 'connection.php';

//$_POST["pid"] $_POST["uid"]

$ID = $_POST["pid"];
$UserID = $_POST["uid"];

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

/*$queryResult=$connect->query("
	SELECT projects.user_id, projects.id, projects.title, projects.created_at, departments.name departmentname, users.name approver
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
	where projects.user_id = '".$UserID."' AND users.user_type_id = '1'
	");*/
	$approved=array();
	$rejected=array();
	$pending=array();
	$senderApp=array();
	$senderRej=array();
	$senderPen=array();
	for($i=0; $i<sizeof($department); $i++){
		$queryResult2=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at, departments.name departmentname
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved = '1' AND projects.submitted_at is NOT NULL ORDER BY projects.created_at DESC
			");
		$queryResult3=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at, departments.name departmentname
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved = '0' AND projects.submitted_at is NOT NULL ORDER BY projects.created_at ASC
			");

		$queryResult4=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.submitted_at, departments.name departmentname
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
			where projects.user_id = '".$department[$i]['id']."' AND users.user_type_id = '1' AND projects.is_approved IS NULL AND projects.submitted_at is NOT NULL ORDER BY projects.created_at ASC
			");

		if($ID==2){
			while ($fetchData=$queryResult2->fetch_assoc()) {
				$approved[]=$fetchData;
			}
		}elseif ($ID==3) {
			while ($fetchData=$queryResult3->fetch_assoc()) {
				$rejected[]=$fetchData;
				//$rejected[$i]['user_id'] = $department[0]['name'];
			}
		}else{
			while ($fetchData=$queryResult4->fetch_assoc()) {
				$pending[]=$fetchData;
				//$pending[$i]['user_id'] = $department[0]['name'];
			}
		}
	}

	if($ID==2){
		for($i=0; $i<sizeof($approved); $i++){
			$querySenderApp=$connect->query("
			SELECT users.id, users.name, users.user_image
			from users
			where users.id = '".$approved[$i]['user_id']."' AND users.user_type_id = '1'
			");

			while ($fetchData=$querySenderApp->fetch_assoc()) {
			$senderApp[]=$fetchData;
			$approved[$i]['name'] = $senderApp[$i]['name'];
			$approved[$i]['user_image'] = $senderApp[$i]['user_image'];
			}
		}
		
	}elseif($ID==3){
		for($i=0; $i<sizeof($rejected); $i++){
			$querySenderApp=$connect->query("
			SELECT users.id, users.name, users.user_image
			from users
			where users.id = '".$rejected[$i]['user_id']."' AND users.user_type_id = '1'
			");

			while ($fetchData=$querySenderApp->fetch_assoc()) {
			$senderRej[]=$fetchData;
			$rejected[$i]['name'] = $senderRej[$i]['name'];
			$rejected[$i]['user_image'] = $senderRej[$i]['user_image'];
			}
		}
		
	}else{
		for($i=0; $i<sizeof($pending); $i++){
			$querySenderApp=$connect->query("
			SELECT users.id, users.name, users.user_image
			from users
			where users.id = '".$pending[$i]['user_id']."' AND users.user_type_id = '1'
			");

			while ($fetchData=$querySenderApp->fetch_assoc()) {
			$senderPen[]=$fetchData;
			$pending[$i]['name'] = $senderPen[$i]['name'];
			$pending[$i]['user_image'] = $senderPen[$i]['user_image'];
			}
		}
		
	}
	//array_push($approved, $department);
	//array_push($rejected, $department);
	//array_push($pending, $department);
	/*echo json_encode($department);*/
	if($ID==2){
		echo json_encode($approved);
	}elseif ($ID==3) {
		echo json_encode($rejected);
	}else{
		echo json_encode($pending);
	}
	?>