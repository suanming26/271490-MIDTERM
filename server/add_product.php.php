<?php

include_once("dbconnect.php");
$prname = $_POST['name'];
$prtype = $_POST['type'];
$prprice = $_POST['price'];
$prqty = $_POST['quantity'];
$encoded_string = $_POST["encoded_string"];

$sqlinsert = "INSERT INTO tbl_products(prname,prtype,prprice,prqty) VALUES('$prname','$prtype','$prprice','$prqty')";
if ($con->query($sqlinsert) === TRUE){
    $decoded_string = base64_decode($encoded_string);
    $filename = mysqli_insert_id($con);
    $path = '../images/products/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
    echo "success";
}else{
    echo "failed";
}

?>