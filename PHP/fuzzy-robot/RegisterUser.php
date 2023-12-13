<?php
// Assuming $conn is your mysqli connection object
$servername = "localhost";
$username = "player";
$password = "player";
$dbname = "arcade_game";

// Variables submitted by user
$signupUser = strtolower($_POST["signupUser"]);
$signupTag = strtolower($_POST["signupTag"]);
$signupPass = strtolower($_POST["signupPass"]);
$signupConfpass = strtolower($_POST["signupConfpass"]);

// Encryption key
$encryptionKey = 'pewpewpew'; // Replace with your actual encryption key

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($signupUser != "" && $signupTag != "" && $signupPass != "") {
    // Using prepared statements to prevent SQL injection
    $stmt = $conn->prepare("SELECT AES_DECRYPT(username, ?) AS user, gamer_tag FROM player WHERE username = AES_ENCRYPT(?, ?) OR gamer_tag = ?");
    $stmt->bind_param("ssss", $encryptionKey, $signupUser, $encryptionKey, $signupTag);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {

        while($row = $result->fetch_assoc()){

        if ($row['user'] == $signupUser){

                echo "Username is taken";

                }

        elseif ($row['gamer_tag'] == $signupTag){

                echo "Gamer tag is taken";
                }

          }

    } else {
        if ($signupPass == $signupConfpass) {
            // Using prepared statement for INSERT to prevent SQL injection
            $stmt = $conn->prepare("INSERT INTO player (username, password, gamer_tag) VALUES (AES_ENCRYPT(?, ?), AES_ENCRYPT(?, ?), ?)");
            $stmt->bind_param("sssss", $signupUser, $encryptionKey, $signupPass, $encryptionKey, $signupTag);
            $stmt->execute();

            echo "created";
        } else {
            echo "passwords do not match";
        }
    }
} else {
    echo "all fields are required";
}

$conn->close();
?>
