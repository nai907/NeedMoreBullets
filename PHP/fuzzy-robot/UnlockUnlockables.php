<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

//variables submitted by user
$gameusername = $_POST["username"];
$gamertag = $_POST["gamertag"];
$unl_condition = $_POST["unl_condition"];
$unl_name = $_POST["unl_name"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

echo "php: " . $gameusername . " " . $gamertag . " " . $achcondition . " " . $achname;

//$sql = "INSERT INTO gainachievement VALUES ('testcondition', 'test11', 'TEST', 'Beyond Every One')";
$sql = "CALL InsertGainSkin('$unl_condition', AES_ENCRYPT('$gameusername', 'pewpewpew'), '$gamertag', '$unl_name')";
$result = $conn->query($sql);

if ($result) {
        echo "Skin Gained: " . $unl_name;
    }
else {
        echo ($conn->error);
    }

$conn->close();
?>
