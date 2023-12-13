<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

//variables submitted by user
$GamerTag = $_POST["GamerTag"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT top_score from top_scores_view where gamer_tag = '$GamerTag'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "Your top score : ".$row["top_score"];
  }
} else {
    echo "Your top score : 0";
}
$conn->close();
?>
