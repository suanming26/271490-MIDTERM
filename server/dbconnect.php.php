<?php
$servername = "localhost";
$username = "javathre_271490_myshopAdmin";
$password = "hXShc2vRVwjxbd5";
$dbname = "javathre_271490_myshopdb";

$con = new mysqli($servername,$username,$password,$dbname);
if($conn->connect_error){
    die("Connection failed: " . $conn->connect_error);
    // echo("Failed");
}
// else{
//     echo("Success");
// }
?>