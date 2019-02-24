<?php 

include 'connection.php';

/*check if entered new username already exists*/
$ID = $_POST["id"];

//$username = sectorhead;
if($ID == '1'){
	$username = $_POST["username"];;

	$queryResult=$connect->query("SELECT * FROM users WHERE username='".$username."'");
	$rows = $queryResult->num_rows;

	if($rows > 0) {
		echo('wrong_username');
	}else{
		echo('correct_username');
	}
}else{
	/*checking is old password entered is same as the users current pass*/
	$User_ID = $_POST["uid"]; 
	$password= $_POST["password"];
	$user = $connect->query("SELECT * FROM users WHERE id = '".$User_ID."' AND user_type_id != '4' ");

	if ($user) {
		$row = mysqli_fetch_assoc($user);
		if ($row) {
			$hash = $row['password'];
			if (password_verify($password,$hash)) {
				echo "correct_password";
			}
			else {
				echo "wrong_password";
			}

		}
	}else{
		echo "Connection failed";
	}
}

?>