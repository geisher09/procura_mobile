<?php 

include 'connection.php';

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

	$pendingPPMP=array();
	$senderPen=array();
	for($i=0; $i<sizeof($department); $i++){
		$queryResult4=$connect->query("
			SELECT projects.user_id, users.name, users.user_image, projects.id, projects.title, projects.created_at, departments.name departmentname
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

	echo json_encode($pendingPPMP);	

	?>