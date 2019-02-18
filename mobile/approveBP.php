<?php 

include 'connection.php';

$ID = $_POST["id"];
$remarks = $_POST["remarks"];
$is_approved = $_POST["is_approved"];
date_default_timezone_set('Asia/Manila');
$datenow = date("Y-m-d H:i:s");

$User_id = $_POST["uid"];
$type = 'App\Notifications\BudgetProposalApproved';
$insert_type = mysqli_real_escape_string($connect,$type);
$notifiable_type = 'App\User';
$insert_notifiable_type = mysqli_real_escape_string($connect,$notifiable_type);
$data = '{"message":"Your Budget Proposal has been approved!"}';

if(!empty($remarks)){
	$connect->query("UPDATE budget_proposals SET is_approved = '".$is_approved."', remarks = '".$remarks."', updated_at = '".$datenow."' 
	WHERE id='".$ID."'");
	}else{
		$connect->query("UPDATE budget_proposals SET is_approved = '".$is_approved."', updated_at = '".$datenow."' WHERE id='".$ID."'");
	}

function getToken($length){
     $token = "";
     $codeAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
     $codeAlphabet.= "abcdefghijklmnopqrstuvwxyz";
     $codeAlphabet.= "0123456789";
     $max = strlen($codeAlphabet); // edited

    for ($i=0; $i < $length; $i++) {
        $token .= $codeAlphabet[random_int(0, $max-1)];
    }

    return $token;
}

$notif_id = getToken(36);

$connect->query("INSERT into notifications (id, type, notifiable_type, notifiable_id, data, created_at, updated_at)
	VALUES ('".$notif_id."', '".$insert_type."', '".$insert_notifiable_type."', '".$User_id."', '".$data."', '".$datenow."', '".$datenow."')");

?>