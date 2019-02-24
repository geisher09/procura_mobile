<?php
include 'connection.php';

$userID = '';
$username = $_POST["username"];
$password = $_POST["password"];

//$username = 'sectorhead';
//$password = '1234';

$user_rec = 0;

$user = $connect->query("SELECT * FROM users WHERE username = '".$username."' AND user_type_id != '4'");

if ($user) {
	$row = mysqli_fetch_assoc($user);
	if ($row) {
		$hash = $row['password'];
		if (password_verify($password,$hash)) {
			$user_rec = 1;
			$user_id = $connect->query("SELECT id FROM users WHERE username = '".$username."' ");
			while($fetchData = $user_id->fetch_assoc()){
				$userID = $fetchData['id'];
			}
		}
		else {
			$user_rec = 0;
		}

	}
}else{
	$userID = '0';
}


echo json_encode($user_rec == 1 ? $userID : '0');

?>