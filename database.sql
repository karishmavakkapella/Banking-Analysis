-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: banking_analysis
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `banking_analysis`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `banking_analysis` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `banking_analysis`;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `account_type` enum('Savings','Current') NOT NULL,
  `opening_balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `account_status` enum('Active','Inactive') DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `accounts_chk_1` CHECK ((`opening_balance` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,1,'BA10001','Savings',10000.00,'Active','2026-10-17 15:18:34'),(2,2,'BA10002','Savings',15000.00,'Active','2026-10-17 15:18:34'),(3,3,'BA10003','Current',20000.00,'Active','2026-10-17 15:18:34'),(4,4,'BA10004','Savings',8000.00,'Active','2026-10-17 15:18:34'),(5,5,'BA10005','Current',12000.00,'Active','2026-10-17 15:18:34');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Arun Kumar','arun@example.com','9000000001','Tirupati','2026-10-17 15:16:34'),(2,'Priya Reddy','priya@example.com','9000000002','Chennai','2026-10-17 15:16:34'),(3,'Rahul Sharma','rahul@example.com','9000000003','Bengaluru','2026-10-17 15:16:34'),(4,'Sneha Rao','sneha@example.com','9000000004','Hyderabad','2026-10-17 15:16:34'),(5,'Kiran Kumar','kiran@example.com','9000000005','Vijayawada','2026-10-17 15:16:34');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `transaction_type` enum('Deposit','Withdrawal') NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `balance_after` decimal(12,2) DEFAULT NULL,
  `payment_method` enum('Cash','UPI','Card','Bank Transfer') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transaction_status` enum('Success','Failed') DEFAULT 'Success',
  `review_flag` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`),
  CONSTRAINT `transactions_chk_1` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,'2026-10-01 09:30:00','Deposit',5000.00,NULL,'UPI','Monthly savings','Success',0,'2026-10-17 15:20:45'),(2,1,'2026-10-03 11:00:00','Withdrawal',1200.00,NULL,'Cash','ATM withdrawal','Success',0,'2026-10-17 15:20:45'),(3,2,'2026-10-04 14:15:00','Deposit',3000.00,NULL,'Bank Transfer','Salary credit','Success',0,'2026-10-17 15:20:45'),(4,2,'2026-10-05 16:30:00','Withdrawal',800.00,NULL,'UPI','Shopping','Success',0,'2026-10-17 15:20:45'),(5,3,'2026-10-06 10:00:00','Deposit',10000.00,NULL,'Bank Transfer','Business income','Success',1,'2026-10-17 15:20:45'),(6,3,'2026-10-07 12:00:00','Withdrawal',2500.00,NULL,'Card','Business expense','Success',0,'2026-10-17 15:20:45'),(7,4,'2026-10-08 13:00:00','Deposit',2000.00,NULL,'Cash','Cash deposit','Success',0,'2026-10-17 15:20:45'),(8,4,'2026-10-09 15:30:00','Withdrawal',500.00,NULL,'UPI','Food payment','Success',0,'2026-10-17 15:20:45'),(9,5,'2026-10-10 09:00:00','Deposit',4000.00,NULL,'UPI','Personal deposit','Success',0,'2026-10-17 15:20:45'),(10,5,'2026-10-11 18:00:00','Withdrawal',1000.00,NULL,'Card','Purchase','Success',0,'2026-10-17 15:20:45'),(11,1,'2026-10-12 20:00:00','Withdrawal',9000.00,NULL,'UPI','Large withdrawal for review','Success',0,'2026-10-17 15:20:45'),(12,3,'2026-10-13 21:00:00','Deposit',50000.00,NULL,'Bank Transfer','Large deposit for review','Success',1,'2026-10-17 15:20:45'),(13,5,'2026-10-25 22:29:17','Deposit',100.00,15100.00,'Cash',NULL,'Success',0,'2026-10-25 16:59:17'),(14,4,'2026-10-25 22:36:27','Withdrawal',1000.00,8500.00,'UPI',NULL,'Success',0,'2026-10-25 17:06:27'),(15,2,'2026-10-14 03:41:00','Deposit',7500.00,24700.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(16,2,'2026-09-30 22:52:00','Withdrawal',2500.00,22200.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(17,2,'2026-10-11 01:23:00','Withdrawal',15000.00,7200.00,'UPI','Sample withdrawal via UPI','Success',1,'2026-10-27 16:29:45'),(18,2,'2026-09-08 12:54:00','Deposit',1000.00,8200.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(19,3,'2026-10-16 03:06:00','Withdrawal',10000.00,67500.00,'UPI','Sample withdrawal via UPI','Success',1,'2026-10-27 16:29:45'),(20,2,'2026-09-28 13:02:00','Deposit',5000.00,13200.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(21,1,'2026-09-18 03:27:00','Withdrawal',4800.00,0.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(22,4,'2026-10-19 10:42:00','Deposit',12000.00,20500.00,'Card','Sample deposit via Card','Success',1,'2026-10-27 16:29:45'),(23,1,'2026-09-04 12:37:00','Deposit',1500.00,1500.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(24,4,'2026-09-07 20:01:00','Withdrawal',1500.00,19000.00,'UPI','Sample withdrawal via UPI','Success',0,'2026-10-27 16:29:45'),(25,2,'2026-09-22 14:00:00','Deposit',1500.00,14700.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(26,1,'2026-09-24 09:40:00','Deposit',1500.00,3000.00,'Card','Sample deposit via Card','Success',0,'2026-10-27 16:29:45'),(27,2,'2026-10-02 12:55:00','Withdrawal',12000.00,2700.00,'UPI','Sample withdrawal via UPI','Success',1,'2026-10-27 16:29:45'),(28,5,'2026-09-09 19:43:00','Deposit',1500.00,16600.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(29,3,'2026-10-13 04:02:00','Deposit',500.00,68000.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(30,4,'2026-10-26 19:18:00','Withdrawal',5000.00,14000.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(31,2,'2026-09-23 10:03:00','Withdrawal',1500.00,1200.00,'UPI','Sample withdrawal via UPI','Success',0,'2026-10-27 16:29:45'),(32,3,'2026-10-10 05:21:00','Withdrawal',3000.00,65000.00,'UPI','Sample withdrawal via UPI','Success',0,'2026-10-27 16:29:45'),(33,3,'2026-09-25 13:38:00','Deposit',4000.00,69000.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(34,2,'2026-09-16 01:58:00','Deposit',3000.00,4200.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(35,5,'2026-09-17 01:52:00','Deposit',250.00,16850.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(36,4,'2026-10-23 03:28:00','Withdrawal',12000.00,2000.00,'Cash','Sample withdrawal via Cash','Success',1,'2026-10-27 16:29:45'),(37,4,'2026-10-23 11:51:00','Withdrawal',750.00,1250.00,'UPI','Sample withdrawal via UPI','Success',0,'2026-10-27 16:29:45'),(38,3,'2026-09-03 16:56:00','Withdrawal',1000.00,68000.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(39,1,'2026-10-27 06:13:00','Deposit',20000.00,23000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',1,'2026-10-27 16:29:45'),(40,1,'2026-09-07 16:07:00','Deposit',2000.00,25000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(41,4,'2026-10-02 02:48:00','Deposit',1500.00,2750.00,'Card','Sample deposit via Card','Success',0,'2026-10-27 16:29:45'),(42,3,'2026-10-23 03:43:00','Deposit',750.00,68750.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(43,5,'2026-10-17 22:33:00','Deposit',4000.00,20850.00,'Card','Sample deposit via Card','Success',0,'2026-10-27 16:29:45'),(44,5,'2026-09-09 11:06:00','Withdrawal',10000.00,10850.00,'Card','Sample withdrawal via Card','Success',1,'2026-10-27 16:29:45'),(45,5,'2026-10-27 19:37:00','Withdrawal',750.00,10100.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(46,1,'2026-10-09 17:01:00','Withdrawal',2000.00,23000.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(47,2,'2026-09-01 14:22:00','Deposit',1500.00,5700.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(48,3,'2026-09-05 11:46:00','Withdrawal',7500.00,61250.00,'Cash','Sample withdrawal via Cash','Success',0,'2026-10-27 16:29:45'),(49,1,'2026-09-25 08:53:00','Withdrawal',3000.00,20000.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(50,2,'2026-09-10 09:40:00','Deposit',500.00,6200.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(51,2,'2026-10-13 13:39:00','Withdrawal',6200.00,0.00,'Cash','Sample withdrawal via Cash','Success',0,'2026-10-27 16:29:45'),(52,4,'2026-09-06 11:28:00','Withdrawal',2750.00,0.00,'Cash','Sample withdrawal via Cash','Success',0,'2026-10-27 16:29:45'),(53,4,'2026-10-17 06:22:00','Deposit',20000.00,20000.00,'Cash','Sample deposit via Cash','Success',1,'2026-10-27 16:29:45'),(54,3,'2026-10-13 23:43:00','Withdrawal',2500.00,58750.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(55,3,'2026-09-09 14:13:00','Deposit',1500.00,60250.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(56,1,'2026-10-13 22:44:00','Withdrawal',1500.00,18500.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(57,3,'2026-10-01 12:36:00','Deposit',4000.00,64250.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(58,2,'2026-10-01 13:57:00','Deposit',1000.00,1000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(59,5,'2026-09-24 21:38:00','Withdrawal',2500.00,7600.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(60,5,'2026-09-10 23:58:00','Withdrawal',1500.00,6100.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(61,2,'2026-08-31 01:02:00','Deposit',12000.00,13000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',1,'2026-10-27 16:29:45'),(62,5,'2026-10-01 18:39:00','Withdrawal',3000.00,3100.00,'UPI','Sample withdrawal via UPI','Success',0,'2026-10-27 16:29:45'),(63,2,'2026-09-01 03:02:00','Deposit',250.00,13250.00,'Card','Sample deposit via Card','Success',0,'2026-10-27 16:29:45'),(64,5,'2026-09-02 20:09:00','Withdrawal',2000.00,1100.00,'Cash','Sample withdrawal via Cash','Success',0,'2026-10-27 16:29:45'),(65,1,'2026-09-16 05:46:00','Withdrawal',500.00,18000.00,'Cash','Sample withdrawal via Cash','Success',0,'2026-10-27 16:29:45'),(66,5,'2026-10-08 19:21:00','Withdrawal',1100.00,0.00,'UPI','Sample withdrawal via UPI','Success',0,'2026-10-27 16:29:45'),(67,1,'2026-10-08 21:25:00','Deposit',20000.00,38000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',1,'2026-10-27 16:29:45'),(68,1,'2026-09-05 09:51:00','Withdrawal',2500.00,35500.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(69,3,'2026-09-18 08:28:00','Withdrawal',10000.00,54250.00,'Cash','Sample withdrawal via Cash','Success',1,'2026-10-27 16:29:45'),(70,3,'2026-09-10 13:38:00','Withdrawal',250.00,54000.00,'UPI','Sample withdrawal via UPI','Success',0,'2026-10-27 16:29:45'),(71,5,'2026-09-08 20:08:00','Deposit',1500.00,1500.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(72,2,'2026-09-13 23:02:00','Deposit',750.00,14000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(73,2,'2026-09-06 11:09:00','Deposit',1000.00,15000.00,'Card','Sample deposit via Card','Success',0,'2026-10-27 16:29:45'),(74,2,'2026-10-20 00:42:00','Withdrawal',2500.00,12500.00,'Cash','Sample withdrawal via Cash','Success',0,'2026-10-27 16:29:45'),(75,3,'2026-10-15 21:53:00','Withdrawal',20000.00,34000.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',1,'2026-10-27 16:29:45'),(76,3,'2026-10-07 18:30:00','Deposit',2500.00,36500.00,'Card','Sample deposit via Card','Success',0,'2026-10-27 16:29:45'),(77,1,'2026-09-05 06:57:00','Deposit',3000.00,38500.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(78,4,'2026-08-30 15:27:00','Withdrawal',12000.00,8000.00,'Card','Sample withdrawal via Card','Success',1,'2026-10-27 16:29:45'),(79,4,'2026-10-16 11:18:00','Withdrawal',1500.00,6500.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(80,3,'2026-10-03 18:13:00','Deposit',20000.00,56500.00,'UPI','Sample deposit via UPI','Success',1,'2026-10-27 16:29:45'),(81,2,'2026-10-27 23:21:00','Withdrawal',1500.00,11000.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(82,5,'2026-09-18 16:57:00','Withdrawal',1500.00,0.00,'Cash','Sample withdrawal via Cash','Success',0,'2026-10-27 16:29:45'),(83,5,'2026-09-19 21:12:00','Deposit',1500.00,1500.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(84,3,'2026-10-19 11:44:00','Deposit',3000.00,59500.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(85,1,'2026-09-22 02:20:00','Withdrawal',2000.00,36500.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(86,4,'2026-09-17 06:36:00','Deposit',4000.00,10500.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(87,3,'2026-09-03 23:19:00','Deposit',1500.00,61000.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(88,3,'2026-10-22 19:49:00','Withdrawal',500.00,60500.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(89,1,'2026-09-30 14:35:00','Deposit',7500.00,44000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(90,1,'2026-09-16 08:58:00','Withdrawal',500.00,43500.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(91,1,'2026-09-11 11:45:00','Deposit',1500.00,45000.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(92,5,'2026-10-08 03:30:00','Withdrawal',1500.00,0.00,'Card','Sample withdrawal via Card','Success',0,'2026-10-27 16:29:45'),(93,1,'2026-09-03 14:03:00','Deposit',3000.00,48000.00,'Card','Sample deposit via Card','Success',0,'2026-10-27 16:29:45'),(94,5,'2026-09-15 11:24:00','Deposit',1000.00,1000.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(95,4,'2026-10-08 21:30:00','Withdrawal',2000.00,8500.00,'Bank Transfer','Sample withdrawal via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(96,4,'2026-09-18 12:55:00','Deposit',3000.00,11500.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(97,1,'2026-08-30 14:02:00','Deposit',1500.00,49500.00,'Bank Transfer','Sample deposit via Bank Transfer','Success',0,'2026-10-27 16:29:45'),(98,5,'2026-10-02 22:36:00','Deposit',15000.00,16000.00,'Cash','Sample deposit via Cash','Success',1,'2026-10-27 16:29:45'),(99,2,'2026-09-18 00:54:00','Deposit',1500.00,12500.00,'Cash','Sample deposit via Cash','Success',0,'2026-10-27 16:29:45'),(100,3,'2026-09-09 07:37:00','Deposit',3000.00,63500.00,'UPI','Sample deposit via UPI','Success',0,'2026-10-27 16:29:45'),(101,3,'2026-10-27 22:03:41','Deposit',5000.00,68500.00,'Bank Transfer',NULL,'Success',0,'2026-10-27 16:33:41'),(102,2,'2026-10-28 09:33:43','Deposit',10000.00,22500.00,'UPI',NULL,'Success',1,'2026-10-28 04:03:43'),(103,1,'2026-10-28 09:34:54','Deposit',10000.00,59500.00,'Cash',NULL,'Success',1,'2026-10-28 04:04:54'),(104,1,'2026-11-02 07:44:52','Deposit',5000.00,64500.00,'UPI',NULL,'Success',0,'2026-11-02 02:14:52'),(105,1,'2026-11-02 11:28:56','Withdrawal',5000.00,59500.00,'UPI',NULL,'Success',0,'2026-11-02 05:58:56'),(106,1,'2026-11-02 11:29:22','Deposit',5000.00,64500.00,'Cash',NULL,'Success',0,'2026-11-02 05:59:22');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-05 19:07:54
