<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

$loginUser = $_POST["loginUser"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT skin_name from unlockskin WHERE username = AES_ENCRYPT('$loginUser', 'pewpewpew')";
$result = $conn->query($sql);



if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo $row["skin_name"] . "\n";
  }
} else {
  echo "0 results";
}
$conn->close();
?>
