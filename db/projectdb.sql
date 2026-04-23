-- ===============================================================
-- Web Application - Project 2024-2025 DB
-- ===============================================================

-- ---------------------------------------------------------------
-- PART A: DB SCHEMA
-- ---------------------------------------------------------------

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UNAME` varchar(50) NOT NULL COMMENT 'username',
  `UPASSHASH` varchar(64) NOT NULL COMMENT 'password hash value (using SHA256)',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UNAME` (`UNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- ----------------------------
-- Table structure for topics
-- ----------------------------
DROP TABLE IF EXISTS `topics`;
CREATE TABLE `topics` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(100) NOT NULL COMMENT 'Short Name',
  `DESCRIPTION` varchar(256) NOT NULL DEFAULT '' COMMENT 'Brief Description',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `NAME` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Date Message Sent',
  `TOPIC_ID` int(10) unsigned NOT NULL,
  `USER_ID` int(10) unsigned NOT NULL,
  `MSG` varchar(256) NOT NULL COMMENT 'A short message about a specific topic.',
  `DATE_SENT` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date Message Sent',
  PRIMARY KEY (`ID`),
  KEY `TOPIC_ID` (`TOPIC_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`TOPIC_ID`) REFERENCES `topics` (`ID`),
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;


-- ---------------------------------------------------------------
-- PART B: DB RECORDS
-- ---------------------------------------------------------------

INSERT INTO `users` VALUES ('1', 't', 'e3b98a4da31a127d4bde6e43033f66ba274cab0eb7eb1c70ec41402bf6273dd8');
INSERT INTO `users` VALUES ('2', 'test', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08');
INSERT INTO `users` VALUES ('3', 'tim', 'c0d19e4483571ff07cb01a4d3f5484102d7f333c4cafa64a2821f55031ea6041');
INSERT INTO `users` VALUES ('4', 'vas', '74356fbb67fef5edcfb2809b4b5e86def771fc45920009d4ab83d3b7e191284e');
INSERT INTO `users` VALUES ('5', 'maria', '94aec9fbed989ece189a7e172c9cf41669050495152bc4c1dbf2a38d7fd85627');
INSERT INTO `users` VALUES ('6', 'eleni', 'ea25818a98c22c877759fd528eb38b3aec1d6ef92610b0bd819aac32dbf35077');

INSERT INTO `topics` VALUES ('1', 'Client-side Development', 'Discussion about client-side technologies such as HTML, CSS and JavaScript.');
INSERT INTO `topics` VALUES ('2', 'Server-side Development', 'Discussion about server-side technologies, such as Java, Servlet, JSP, Sessions, Cookies, and Interaction with RDBMS using JDBC API.');
INSERT INTO `topics` VALUES ('3', 'Network-Protocols', 'Discussion about Network Protocols, such as HTTP/HTTPS and DNS.');
INSERT INTO `topics` VALUES ('4', 'Operating Systems', 'Discussion about Operating Systems.');
INSERT INTO `topics` VALUES ('5', 'Hardware', 'Discussion about Hardware, including but not limited to CPU, GPU and TPU!');

INSERT INTO `messages` VALUES ('1', '2', '2', 'Test Message ...', '2025-05-17 13:04:04');
INSERT INTO `messages` VALUES ('2', '3', '3', 'In this course we mainly focus on Application Layer.', '2025-05-17 13:04:30');
INSERT INTO `messages` VALUES ('3', '3', '6', 'Which one ?', '2025-05-17 13:04:41');
INSERT INTO `messages` VALUES ('5', '3', '3', 'Mainly, HTTP and DNS.', '2025-05-17 13:04:58');
INSERT INTO `messages` VALUES ('6', '3', '3', 'Adequate knowledge of TCP and IP protocols is necessary.', '2025-05-17 13:05:08');
INSERT INTO `messages` VALUES ('8', '4', '3', 'In this course we do not focus on Operating Systems (OS).', '2025-05-17 13:05:32');
INSERT INTO `messages` VALUES ('9', '4', '3', 'Nevertheless they are rather important for both client and server.', '2025-05-17 13:05:42');
INSERT INTO `messages` VALUES ('10', '5', '3', 'Servers should be powerful machines.', '2025-05-17 13:05:58');
INSERT INTO `messages` VALUES ('11', '5', '3', 'GPU is essential for Deep Neural Networks (DNNs).', '2025-05-17 13:06:13');
INSERT INTO `messages` VALUES ('12', '5', '5', 'Can a train a transformer-based DNN in my laptop.', '2025-05-17 13:06:28');
INSERT INTO `messages` VALUES ('13', '5', '4', 'To be honest, no !!!', '2025-05-17 13:06:39');


-- ---------------------------------------------------------------
-- PART C: NOTES
-- ---------------------------------------------------------------
-- 
-- For testing purpose the username and password are the same !
-- 
-- The Hash Value generated using SHA-256 algorithm.
-- 
-- ---------------------------------------------------------------

-- ===============================================================