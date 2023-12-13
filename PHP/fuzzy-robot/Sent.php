<?php
$servername = "localhost";
$username = "player";
$password = "player";
$dbname = "arcade_game";
$ekey = "pewpewpew";
//variables submitted by user
$loginUser = strtolower($_POST["loginUser"]);
$loginPass = strtolower($_POST["loginPass"]);

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}


$sql = $conn->prepare("SELECT * FROM player WHERE username = AES_ENCRYPT(?, ?) AND password = AES_ENCRYPT(?, ?)");
$sql->bind_param("ssss", $loginUser, $ekey, $loginPass, $ekey);

$sql->execute();
$result = $sql->get_result();

if ($result->num_rows > 0) {
  // output data of each row

        echo "Login Success.";


  }

else {
    echo "Wrong Credentials.";
}
$sql->close();
$conn->close();
?>
