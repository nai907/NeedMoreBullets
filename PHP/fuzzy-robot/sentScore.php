<?php
$servername = "localhost";
$username = "admin";
$password = "needmorebullets";
$dbname = "arcade_game";

$Score = $_POST["Score"];
$DateTime = $_POST["DateTime"];
$Username = $_POST["Username"];
$GamerTag = $_POST["GamerTag"];

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

//$sql = "INSERT INTO leaderboard(score_amount, date_time_added, username, is_highscore, gamer_tag) values ('$Score','$DateTime','$Username',0,'GamerTag')";
$sql = "SELECT MAX(score_amount) as high_score FROM leaderboard WHERE username = AES_ENCRYPT('$Username', 'pewpewpew')";
$result = $conn->query($sql);
$row = $result->fetch_assoc();
$currentHighScore = $row['high_score'];
if ($Score > $currentHighScore)
{
	$is_highscore = 1;
	//$currentHighScore = (int)$currentHighScore

}
if ($Score <= $currentHighScore)
{
	$is_highscore = 0;
}
$sql = "INSERT INTO leaderboard(score_amount, date_time_added, username, is_highscore, gamer_tag) values ($Score,'$DateTime',AES_ENCRYPT('$Username','pewpewpew'),$is_highscore,'$GamerTag')";
$result = $conn->query($sql);

if ($result === TRUE) {
  // output data of each row
  echo "success";
  $sql = "CALL UpdateHighScores(AES_ENCRYPT('$Username', 'pewpewpew'))";
  $result = $conn->query($sql);
  if ($result === TRUE) 
  {
	  echo "update score success";
  }

  else{

	  echo ("Error Description: " . $conn -> error);
      }
}
else {
  echo("Error description: " . $conn -> error);
}
$conn->close();
?>
