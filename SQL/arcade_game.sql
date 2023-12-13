-- phpMyAdmin SQL Dump
-- version 5.0.4deb2+deb11u1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 01, 2023 at 11:21 AM
-- Server version: 10.5.21-MariaDB-0+deb11u1
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `arcade_game`
--

DELIMITER $$
--
-- Procedures
--

GRANT SELECT, INSERT, UPDATE ON `arcade_game`.* TO `player`@`localhost`;

CREATE DEFINER=`admin`@`localhost` PROCEDURE `InsertGainAch` (IN `achcondition` VARCHAR(150), IN `gameusername` VARBINARY(50), IN `gamertag` VARCHAR(5), IN `achname` VARCHAR(50))  BEGIN

	IF NOT EXISTS (SELECT * FROM gainachievement WHERE (gamertag = gamer_tag) AND (achname = achievement_name))
                   THEN
                   		INSERT INTO gainachievement VALUES (achcondition, gameusername, gamertag, achname);
                   END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertGainSkin` (IN `unlcond` VARCHAR(150), IN `gameusername` VARBINARY(50), IN `gamertag` VARCHAR(5), IN `skinname` VARCHAR(50))  NO SQL
BEGIN

	IF NOT EXISTS (SELECT * FROM unlockskin WHERE (gamertag = gamer_tag) AND (skinname = skin_name))
                   THEN
                   		INSERT INTO unlockskin VALUES (unlcond, gameusername, skinname,  gamertag);
                   END IF;

END$$

CREATE DEFINER=`admin`@`localhost` PROCEDURE `UpdateHighScores` (IN `p_Username` VARBINARY(50))  BEGIN
    DECLARE max_score INT;

    -- Select maximum score for the specific username
    SELECT MAX(score_amount) INTO max_score FROM leaderboard WHERE username = p_Username;

    -- Update high scores for the given username
    UPDATE leaderboard 
    SET is_highscore = 0 
    WHERE (score_amount < max_score) AND (username = p_Username);
    
    IF ((SELECT COUNT(*) FROM leaderboard WHERE username = p_Username) > 2)
    THEN
    DELETE FROM leaderboard WHERE username = p_Username
    ORDER BY score_amount
    ASC
    LIMIT 1;
    END IF;
    
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `achievement`
--

CREATE TABLE `achievement` (
  `achievement_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `achievement_description` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `achievement`
--

INSERT INTO `achievement` (`achievement_name`, `achievement_description`) VALUES
('Beyond All', 'Earn 300 points in one round'),
('Bigger Please', 'Destroy a boss spaceship for the first time in hard mode'),
('Fire Finger', '1000 Words typed in one round'),
('First Blood', 'Shot at the first ship'),
('First round', 'Play This game for the first time.'),
('First Step', 'Earn 10 points in one round'),
('Halfway there', 'Earn 150 points in one round'),
('Harder Please', 'Earn 100 points on hard'),
('No escape', 'First time dying'),
('Too Easy', 'Play on hard for the first time'),
('Why?', '5000 Words typed in one round');

-- --------------------------------------------------------

--
-- Table structure for table `gainachievement`
--

CREATE TABLE `gainachievement` (
  `achievement_condition` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varbinary(50) NOT NULL,
  `gamer_tag` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `achievement_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gainachievement`
--

INSERT INTO `gainachievement` (`achievement_condition`, `username`, `gamer_tag`, `achievement_name`) VALUES
('Shot at the first ship', 0x0c8131c500df31163c567ebedcc63a23, 'andy', 'First Blood'),
('Play This game for the first time.', 0x0c8131c500df31163c567ebedcc63a23, 'andy', 'First Round'),
('score >= 10', 0x0c8131c500df31163c567ebedcc63a23, 'andy', 'First Step'),
('Shot at the first ship', 0x3e0bd3f7bce2137cfc364e7ed22de606, 'a', 'First Blood'),
('Play This game for the first time.', 0x3e0bd3f7bce2137cfc364e7ed22de606, 'a', 'First Round'),
('score >= 10', 0x3e0bd3f7bce2137cfc364e7ed22de606, 'a', 'First Step'),
('Shot at the first ship', 0x690b8eb0956e69fe58ee92aa5878cd02, '11111', 'First Blood'),
('Play This game for the first time.', 0x690b8eb0956e69fe58ee92aa5878cd02, '11111', 'First Round'),
('score >= 10', 0x690b8eb0956e69fe58ee92aa5878cd02, '11111', 'First Step'),
('score >= 150', 0x690b8eb0956e69fe58ee92aa5878cd02, '11111', 'Halfway there'),
('Destroy a boss spaceship for the first time in hard', 0x6cb09a22a8e8453e3c897370a5b6534a, 'nai', 'Bigger Please'),
('Shot at the first ship', 0x6cb09a22a8e8453e3c897370a5b6534a, 'nai', 'First Blood'),
('Play This game for the first time.', 0x6cb09a22a8e8453e3c897370a5b6534a, 'nai', 'First Round'),
('score >= 10', 0x6cb09a22a8e8453e3c897370a5b6534a, 'nai', 'First Step'),
('Play on hard for the first time', 0x6cb09a22a8e8453e3c897370a5b6534a, 'nai', 'Too Easy'),
('Shot at the first ship', 0xb17e7a2e22a216707776ffcc2a872398, 'q', 'First Blood'),
('Play This game for the first time.', 0xb17e7a2e22a216707776ffcc2a872398, 'q', 'First Round'),
('Destroy a boss spaceship for the first time in hard', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'pup', 'Bigger Please'),
('Shot at the first ship', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'pup', 'First Blood'),
('Play This game for the first time.', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'pup', 'First Round'),
('score >= 10', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'pup', 'First Step'),
('Play on hard for the first time', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'pup', 'Too Easy'),
('Destroy a boss spaceship for the first time in hard', 0xe93b6c9028128a38add7335c400a5cb9, 'pc', 'Bigger Please'),
('Shot at the first ship', 0xe93b6c9028128a38add7335c400a5cb9, 'pc', 'First Blood'),
('Play This game for the first time.', 0xe93b6c9028128a38add7335c400a5cb9, 'pc', 'First Round'),
('score >= 10', 0xe93b6c9028128a38add7335c400a5cb9, 'pc', 'First Step'),
('Play on hard for the first time', 0xe93b6c9028128a38add7335c400a5cb9, 'pc', 'Too Easy');

-- --------------------------------------------------------

--
-- Table structure for table `leaderboard`
--

CREATE TABLE `leaderboard` (
  `score_id` int(11) NOT NULL,
  `score_amount` int(11) NOT NULL,
  `date_time_added` datetime DEFAULT NULL,
  `username` varbinary(50) NOT NULL,
  `is_highscore` tinyint(1) NOT NULL,
  `gamer_tag` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leaderboard`
--

INSERT INTO `leaderboard` (`score_id`, `score_amount`, `date_time_added`, `username`, `is_highscore`, `gamer_tag`) VALUES
(140, 43, '2023-11-21 03:01:07', 0x6cb09a22a8e8453e3c897370a5b6534a, 1, 'nai'),
(141, 30, '2023-11-21 03:03:51', 0x6cb09a22a8e8453e3c897370a5b6534a, 0, 'nai'),
(144, 10, '2023-11-21 04:15:56', 0x3e0bd3f7bce2137cfc364e7ed22de606, 0, 'a'),
(145, 31, '2023-11-21 04:17:07', 0x3e0bd3f7bce2137cfc364e7ed22de606, 1, 'a'),
(146, 1, '2023-11-21 12:41:33', 0x0c8131c500df31163c567ebedcc63a23, 1, 'andy'),
(147, 5, '2023-11-21 13:11:22', 0xb17e7a2e22a216707776ffcc2a872398, 1, 'q'),
(148, 4, '2023-11-21 13:12:11', 0xb17e7a2e22a216707776ffcc2a872398, 0, 'q'),
(155, 101, '2023-11-21 15:46:52', 0xe93b6c9028128a38add7335c400a5cb9, 1, 'pc'),
(157, 53, '2023-11-21 15:50:56', 0xe93b6c9028128a38add7335c400a5cb9, 0, 'pc'),
(158, 44, '2023-11-21 04:00:43', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 0, 'pup'),
(160, 65, '2023-11-21 04:04:09', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 1, 'pup'),
(162, 213, '2023-11-21 19:28:52', 0x690b8eb0956e69fe58ee92aa5878cd02, 1, '11111');

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `username` varbinary(255) NOT NULL,
  `password` varbinary(255) DEFAULT NULL,
  `gamer_tag` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `player`
--

INSERT INTO `player` (`username`, `password`, `gamer_tag`) VALUES
(0x0c8131c500df31163c567ebedcc63a23, 0x0c8131c500df31163c567ebedcc63a23, 'andy'),
(0x3e0bd3f7bce2137cfc364e7ed22de606, 0x3e0bd3f7bce2137cfc364e7ed22de606, 'a'),
(0x690b8eb0956e69fe58ee92aa5878cd02, 0x00ee91fed935027720bd981b5ff2815d, '11111'),
(0x6cb09a22a8e8453e3c897370a5b6534a, 0xe3211a84efc4cf16213e0eca9ca17039, 'nai'),
(0xb17e7a2e22a216707776ffcc2a872398, 0xb17e7a2e22a216707776ffcc2a872398, 'q'),
(0xc1a1e035760de1f2532b4f36a48d178a, 0x3e9634d7f8ba86bffcbbd77e012132e4, '12345'),
(0xc7ab84f049edef29963a6463ae7bccb7, 0xd3ab94db5c940c94c30534aa043808d7, 'dd'),
(0xcfd65f6a95f8ef742cf6f630d12a8f85, 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'pup'),
(0xe93b6c9028128a38add7335c400a5cb9, 0xe93b6c9028128a38add7335c400a5cb9, 'pc');

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `difficulty` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `audio_volume` float NOT NULL,
  `username` varbinary(50) NOT NULL,
  `gamer_tag` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`difficulty`, `audio_volume`, `username`, `gamer_tag`) VALUES
('Easy', 1, 0x0c8131c500df31163c567ebedcc63a23, 'andy'),
('Easy', 0.087471, 0x3e0bd3f7bce2137cfc364e7ed22de606, 'a'),
('Easy', 1, 0x690b8eb0956e69fe58ee92aa5878cd02, '11111'),
('Easy', 0.0338792, 0x6cb09a22a8e8453e3c897370a5b6534a, 'nai'),
('Easy', 0, 0xb17e7a2e22a216707776ffcc2a872398, 'q'),
('Easy', 0, 0xc1a1e035760de1f2532b4f36a48d178a, '12345'),
('Easy', 0, 0xc7ab84f049edef29963a6463ae7bccb7, 'dd'),
('Normal', 0.221699, 0xe93b6c9028128a38add7335c400a5cb9, 'pc');

-- --------------------------------------------------------

--
-- Table structure for table `skin`
--

CREATE TABLE `skin` (
  `skin_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `skin_description` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `skin`
--

INSERT INTO `skin` (`skin_name`, `skin_description`) VALUES
('Big Boss', 'Isn\'t that a boss?'),
('The Legend', 'Legendary ship that never shows up in this space'),
('Unseen', 'Ship that hasn\'t been seen for a long time');

-- --------------------------------------------------------

--
-- Stand-in structure for view `top_scores_view`
-- (See below for the actual view)
--
CREATE TABLE `top_scores_view` (
`gamer_tag` varchar(5)
,`top_score` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `unlockskin`
--

CREATE TABLE `unlockskin` (
  `unlock_condition` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varbinary(50) NOT NULL,
  `skin_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gamer_tag` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `unlockskin`
--

INSERT INTO `unlockskin` (`unlock_condition`, `username`, `skin_name`, `gamer_tag`) VALUES
('Complete 10 waves at any difficulty', 0x0c8131c500df31163c567ebedcc63a23, 'Big Boss', 'andy'),
('Complete 10 waves at any difficulty', 0x3e0bd3f7bce2137cfc364e7ed22de606, 'Big Boss', 'a'),
('Complete 10 waves at any difficulty', 0x690b8eb0956e69fe58ee92aa5878cd02, 'Big Boss', '11111'),
('Complete 10 waves at any difficulty', 0x6cb09a22a8e8453e3c897370a5b6534a, 'Big Boss', 'nai'),
('Destroy a boss spaceship for the first time in hard', 0x6cb09a22a8e8453e3c897370a5b6534a, 'The Legend', 'nai'),
('Complete 10 waves at any difficulty', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'Big Boss', 'pup'),
('Destroy a boss spaceship for the first time in hard', 0xcfd65f6a95f8ef742cf6f630d12a8f85, 'The Legend', 'pup'),
('Complete 10 waves at any difficulty', 0xe93b6c9028128a38add7335c400a5cb9, 'Big Boss', 'pc'),
('Destroy a boss spaceship for the first time in hard', 0xe93b6c9028128a38add7335c400a5cb9, 'The Legend', 'pc');

-- --------------------------------------------------------

--
-- Structure for view `top_scores_view`
--
DROP TABLE IF EXISTS `top_scores_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`admin`@`localhost` SQL SECURITY DEFINER VIEW `top_scores_view`  AS SELECT `leaderboard`.`gamer_tag` AS `gamer_tag`, max(`leaderboard`.`score_amount`) AS `top_score` FROM `leaderboard` GROUP BY `leaderboard`.`gamer_tag` ORDER BY max(`leaderboard`.`score_amount`) DESC ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `achievement`
--
ALTER TABLE `achievement`
  ADD PRIMARY KEY (`achievement_name`);

--
-- Indexes for table `gainachievement`
--
ALTER TABLE `gainachievement`
  ADD PRIMARY KEY (`username`,`gamer_tag`,`achievement_name`),
  ADD KEY `achievement_name` (`achievement_name`),
  ADD KEY `gamer_tag` (`gamer_tag`);

--
-- Indexes for table `leaderboard`
--
ALTER TABLE `leaderboard`
  ADD PRIMARY KEY (`score_id`),
  ADD KEY `username` (`username`,`gamer_tag`),
  ADD KEY `gamer_tag` (`gamer_tag`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`username`,`gamer_tag`),
  ADD KEY `gamer_tag` (`gamer_tag`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`username`,`gamer_tag`),
  ADD KEY `gamer_tag` (`gamer_tag`);

--
-- Indexes for table `skin`
--
ALTER TABLE `skin`
  ADD PRIMARY KEY (`skin_name`);

--
-- Indexes for table `unlockskin`
--
ALTER TABLE `unlockskin`
  ADD PRIMARY KEY (`username`,`skin_name`,`gamer_tag`),
  ADD KEY `skin_name` (`skin_name`),
  ADD KEY `gamer_tag` (`gamer_tag`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `leaderboard`
--
ALTER TABLE `leaderboard`
  MODIFY `score_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `gainachievement`
--
ALTER TABLE `gainachievement`
  ADD CONSTRAINT `gainachievement_ibfk_1` FOREIGN KEY (`achievement_name`) REFERENCES `achievement` (`achievement_name`),
  ADD CONSTRAINT `gainachievement_ibfk_2` FOREIGN KEY (`username`) REFERENCES `player` (`username`),
  ADD CONSTRAINT `gainachievement_ibfk_3` FOREIGN KEY (`gamer_tag`) REFERENCES `player` (`gamer_tag`);

--
-- Constraints for table `leaderboard`
--
ALTER TABLE `leaderboard`
  ADD CONSTRAINT `leaderboard_ibfk_1` FOREIGN KEY (`username`) REFERENCES `player` (`username`),
  ADD CONSTRAINT `leaderboard_ibfk_2` FOREIGN KEY (`gamer_tag`) REFERENCES `player` (`gamer_tag`);

--
-- Constraints for table `setting`
--
ALTER TABLE `setting`
  ADD CONSTRAINT `setting_ibfk_1` FOREIGN KEY (`username`) REFERENCES `player` (`username`),
  ADD CONSTRAINT `setting_ibfk_2` FOREIGN KEY (`gamer_tag`) REFERENCES `player` (`gamer_tag`);

--
-- Constraints for table `unlockskin`
--
ALTER TABLE `unlockskin`
  ADD CONSTRAINT `unlockskin_ibfk_1` FOREIGN KEY (`skin_name`) REFERENCES `skin` (`skin_name`),
  ADD CONSTRAINT `unlockskin_ibfk_2` FOREIGN KEY (`username`) REFERENCES `player` (`username`),
  ADD CONSTRAINT `unlockskin_ibfk_3` FOREIGN KEY (`gamer_tag`) REFERENCES `player` (`gamer_tag`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
