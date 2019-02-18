<?php 

include 'connection.php';

/*check if entered new username already exists*/
$username = 'sectorheaddc';

$queryResult=$connect->query("SELECT * FROM users WHERE username='".$username."'");
$rows = $queryResult->num_rows;

if($rows > 0) {
    echo('1');
}else{
	echo('0');
}

/*checking is old password entered is same as the users current pass*/
$ID = '2'; 
$password = '23';
$user = $connect->query("SELECT * FROM users WHERE id = '".$ID."' AND user_type_id != '4' ");

if ($user) {
	$row = mysqli_fetch_assoc($user);
	if ($row) {
		$hash = $row['password'];
		if (password_verify($password,$hash)) {
			echo "Password matched";
		}
		else {
			echo "Password mismatched";
		}

	}
}else{
	echo "Connection failed";
}

/*hashing a password*/
$hashed_password = password_hash($password, PASSWORD_DEFAULT);
echo($hashed_password);

?>