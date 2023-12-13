<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

$Difficulty = $_POST["Difficulty"];
$Audio_volume = $_POST["Audio_volume"];
$Username = $_POST["Username"];
$Gamer_tag = $_POST["Gamer_tag"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}


$sql = "UPDATE setting SET difficulty = '$Difficulty', audio_volume = $Audio_volume WHERE username = AES_ENCRYPT('$Username', 'pewpewpew')";
$result = $conn->query($sql);

if ($result == TRUE)
{
	echo "success";
}
else
{
	echo("Error description: " . $conn -> error);
}

$conn->close();
?>
