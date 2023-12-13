<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

//variables submitted by user
$loginUser = $_POST["loginUser"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT gamer_tag from top_scores_view";
$result = $conn->query($sql);


if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "#".$row["gamer_tag"]."<br>";

  }
} else {
    echo "Username does not exists.";
}
//echo "Your gamertag : ".$conn->query("SELECT gamer_tag from leaderboard where username = '$loginUser' AND is_highscore = 1")->fetch_assoc()["gamer_tag"];
$conn->close();
?>
