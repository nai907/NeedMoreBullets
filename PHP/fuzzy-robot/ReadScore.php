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

$sql = "SELECT top_score from top_scores_view";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo $row["top_score"]."<br>";
  }
} else {
    echo "Username does not exists.";
}
//echo "Your top score : ".$conn->query("SELECT MAX(score_amount) from leaderboard where username = 'q' AND is_highscore = 1")->fetch_assoc()["MAX(score_amount)"];
$conn->close();
?>
