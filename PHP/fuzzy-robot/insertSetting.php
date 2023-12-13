<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

$signupUser = $_POST["signupUser"];
$signupTag = $_POST["signupTag"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}


$sql = "insert into setting(difficulty,audio_volume,username,gamer_tag) values ('Easy',0,AES_ENCRYPT('$signupUser', 'pewpewpew'),'$signupTag')";
$result = $conn->query($sql);

if ($result == TRUE)
{

}
else
{
	
}

$conn->close();
?>
