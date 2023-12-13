<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

//variables submitted by user
$gameusername = $_POST["username"];
$gamertag = $_POST["gamertag"];
$achcondition = $_POST["ach_condition"];
$achname = $_POST["ach_name"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

echo "php: " . $gameusername . " " . $gamertag . " " . $achcondition . " " . $achname;

//$sql = "INSERT INTO gainachievement VALUES ('testcondition', 'test11', 'TEST', 'Beyond Every One')";
$sql = "CALL InsertGainAch('$achcondition', AES_ENCRYPT('$gameusername', 'pewpewpew'), '$gamertag', '$achname')";
$result = $conn->query($sql);

if ($result) {
	echo "Achievement Gained: " . $achname;
    }
else {
        echo ($conn->error);
    }

$conn->close();
?>
