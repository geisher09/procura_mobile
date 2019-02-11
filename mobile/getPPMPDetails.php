<?php 

include 'connection.php';

$ID = $_POST["id"];
//$ID = '2';


$queryResult=$connect->query("
	SELECT
	projects.title, project_items.id, project_items.code, project_items.description, CONCAT(project_items.quantity,' ',project_items.uom) qty, project_items.unit_cost, project_items.estimated_budget, project_items.procurement_mode
	from projects
	LEFT OUTER JOIN project_items
	on projects.id = project_items.project_id
	where project_items.project_id = '".$ID."'");


$result=array();
$i = 0;

while ($fetchData=$queryResult->fetch_assoc()) {
	$result[]=$fetchData;
	$schedResult=$connect->query("
		SELECT
		schedules.id
		from schedules
		LEFT JOIN project_item_schedule
		on project_item_schedule.schedule_id = schedules.id
		where project_item_schedule.project_item_id = '".$result[$i]['id']."' ");
	$result2=array();
	$result3=array();
	for($j=0; $j<12; $j++){
		$fetchData2=$schedResult->fetch_assoc();
		$result2[] = $fetchData2;			
	}
	for($j=0; $j<12; $j++){
		if($result2[$j]['id'] == '1'){
			$result2[0]['id'] = '1';
		}elseif($result2[$j]['id'] == '2'){
			$result2[1]['id'] = '2';
		}elseif($result2[$j]['id'] == '3'){
			$result2[2]['id'] = '3';
		}elseif($result2[$j]['id'] == '4'){
			$result2[3]['id'] = '4';
		}elseif($result2[$j]['id'] == '5'){
			$result2[4]['id'] = '5';
		}elseif($result2[$j]['id'] == '6'){
			$result2[5]['id'] = '6';
		}elseif($result2[$j]['id'] == '7'){
			$result2[6]['id'] = '7';
		}elseif($result2[$j]['id'] == '8'){
			$result2[7]['id'] = '8';
		}elseif($result2[$j]['id'] == '9'){
			$result2[8]['id'] = '9';
		}elseif($result2[$j]['id'] == '10'){
			$result2[9]['id'] = '10';
		}elseif($result2[$j]['id'] == '11'){
			$result2[10]['id'] = '11';
		}elseif($result2[$j]['id'] == '12'){
			$result2[11]['id'] = '12';
		}
	}
	for($j=0; $j<12; $j++){
		if($result2[$j]['id'] != strval($j+1)){
			$result2[$j]['id'] = '0';
		}
	}
	array_push($result[$i],$result2);
	$i+=1;
}

echo json_encode($result);
?>


