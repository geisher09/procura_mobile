<?php 

include 'connection.php';

/*check if entered new username already exists*/
$username = 'sectorhead';

$queryResult=$connect->query("SELECT * FROM users WHERE username='".$username."'");
$rows = $queryResult->num_rows;

if($rows > 0) {
    echo('wrong');
}else{
	echo('correct');
}

/*checking is old password entered is same as the users current pass*/
$ID = '2'; 
$password= '1234';
$user = $connect->query("SELECT * FROM users WHERE id = '".$ID."' AND user_type_id != '4' ");

if ($user) {
	$row = mysqli_fetch_assoc($user);
	if ($row) {
		$hash = $row['password'];
		if (password_verify($password,$hash)) {
			echo "correct";
		}
		else {
			echo "wrong";
		}

	}
}else{
	echo "Connection failed";
}

/*hashing a password*/
$hashed_password = password_hash($password, PASSWORD_DEFAULT);
//print_r($hashed_password);

?>