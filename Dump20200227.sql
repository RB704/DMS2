-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: dms
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `device`
--

DROP TABLE IF EXISTS `device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `device` (
  `device_id` int NOT NULL AUTO_INCREMENT,
  `device_type` varchar(45) DEFAULT NULL,
  `device_company` varchar(45) DEFAULT NULL,
  `device_name` varchar(45) DEFAULT NULL,
  `specification_id` int DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `warranty_period_yrs` int DEFAULT NULL,
  `warranty_status` bit(1) DEFAULT NULL,
  `device_serial_number` varchar(45) DEFAULT NULL,
  `device_condition` enum('working','gone_for_repair','discarded') DEFAULT 'working',
  PRIMARY KEY (`device_id`),
  UNIQUE KEY `device_serial_number_UNIQUE` (`device_serial_number`),
  KEY `specification_id` (`specification_id`),
  CONSTRAINT `device_ibfk_1` FOREIGN KEY (`specification_id`) REFERENCES `specification_of_device` (`specification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `device`
--

LOCK TABLES `device` WRITE;
/*!40000 ALTER TABLE `device` DISABLE KEYS */;
INSERT INTO `device` VALUES (1,'mobile','apple','iphone X',1,'2020-02-02',1,_binary '','11111','working'),(2,'mobile','apple','iphone xr',2,'2020-02-02',1,_binary '','11112','working'),(3,'laptop','dell','alienware 1',3,'2020-02-02',1,_binary '','11113','working'),(4,'laptop','lenovo','alienware 2',4,'2020-02-02',1,_binary '','11114','working'),(5,'headphone','logitech','true bass',5,'2020-02-02',1,_binary '','11115','working');
/*!40000 ALTER TABLE `device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission` (
  `permission_id` int NOT NULL,
  `permission_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'write'),(2,'read');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `priority`
--

DROP TABLE IF EXISTS `priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `priority` (
  `priority_id` int NOT NULL,
  `priority_alloted` enum('low','medium','high') DEFAULT NULL,
  PRIMARY KEY (`priority_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `priority`
--

LOCK TABLES `priority` WRITE;
/*!40000 ALTER TABLE `priority` DISABLE KEYS */;
INSERT INTO `priority` VALUES (1,'low'),(2,'medium'),(3,'high');
/*!40000 ALTER TABLE `priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_faulty_device`
--

DROP TABLE IF EXISTS `report_faulty_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_faulty_device` (
  `device_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `description_of_fault` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`device_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `report_faulty_device_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`),
  CONSTRAINT `report_faulty_device_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_faulty_device`
--

LOCK TABLES `report_faulty_device` WRITE;
/*!40000 ALTER TABLE `report_faulty_device` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_faulty_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request` (
  `booking_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `priority_id` int DEFAULT NULL,
  `booking_date` timestamp NULL DEFAULT NULL,
  `return_date` timestamp NULL DEFAULT NULL,
  `status` enum('approved','pending','rejected') DEFAULT 'pending',
  `specification_id` int DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `priority_id` (`priority_id`),
  KEY `specification_id` (`specification_id`),
  CONSTRAINT `request_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `request_ibfk_3` FOREIGN KEY (`priority_id`) REFERENCES `priority` (`priority_id`),
  CONSTRAINT `request_ibfk_4` FOREIGN KEY (`specification_id`) REFERENCES `specification_of_device` (`specification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (1,1,1,'2020-02-27 10:36:47','2020-03-08 10:36:47','approved',1),(2,2,1,'2020-02-27 10:38:39','2020-03-08 10:38:39','approved',2),(3,3,1,'2020-02-27 10:38:39','2020-03-08 10:38:39','approved',3),(4,4,3,'2020-02-27 10:38:39','2020-03-08 10:38:39','approved',4),(5,5,3,'2020-02-27 10:38:39','2020-03-08 10:38:39','approved',5);
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role_id` int NOT NULL,
  `role_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'super admin'),(2,'admin'),(3,'hr'),(4,'employee');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permission` (
  `role_id` int DEFAULT NULL,
  `permission_id` int DEFAULT NULL,
  KEY `role_id_idx` (`role_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `role_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permission`
--

LOCK TABLES `role_permission` WRITE;
/*!40000 ALTER TABLE `role_permission` DISABLE KEYS */;
INSERT INTO `role_permission` VALUES (1,1),(1,2),(2,1),(2,2),(3,1),(3,2),(4,2);
/*!40000 ALTER TABLE `role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specification_of_device`
--

DROP TABLE IF EXISTS `specification_of_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specification_of_device` (
  `specification_id` int NOT NULL,
  `device_memory_gb` int DEFAULT NULL,
  `device_ram_gb` int DEFAULT NULL,
  `device_cpu` varchar(45) DEFAULT NULL,
  `device_gpu` varchar(45) DEFAULT NULL,
  `device_battery_mah` int DEFAULT NULL,
  `device_connectivity` enum('wired','bluetooth') DEFAULT NULL,
  PRIMARY KEY (`specification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specification_of_device`
--

LOCK TABLES `specification_of_device` WRITE;
/*!40000 ALTER TABLE `specification_of_device` DISABLE KEYS */;
INSERT INTO `specification_of_device` VALUES (1,64,4,'a10','mali 650',2500,NULL),(2,64,4,'a11','mali 650',2500,NULL),(3,1000,12,'intel i9','1080 ti',8000,NULL),(4,1000,16,'intel i9','2050 ti',8000,NULL),(5,NULL,NULL,NULL,NULL,NULL,'wired');
/*!40000 ALTER TABLE `specification_of_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_f_name` varchar(45) DEFAULT NULL,
  `user_l_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `department` varchar(45) DEFAULT NULL,
  `designation` varchar(45) DEFAULT NULL,
  `role_id` int DEFAULT NULL,
  `user_active` bit(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'rajan','kumar','rajan@gmail.com','12345','it','developer',1,_binary ''),(2,'manish','sharma','manish@gmail.com','12345','it','developer',1,_binary ''),(3,'kiran','singh','kiran@gmail.com','12345','qa','tester',1,_binary ''),(4,'ram','kumar','ram@gmail.com','12345','qa','tester',1,_binary ''),(5,'vaibhav','rajput','vaibhav@gmail.com','12345','management','hr',1,_binary ''),(6,'rinku','sharma','r@gmail.com','12345','management','super admin',1,_binary ''),(7,'kapil','gupta','k@gmail.com','12345','management','admin',1,_binary '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_device`
--

DROP TABLE IF EXISTS `user_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_device` (
  `user_id` int NOT NULL,
  `device_id` int NOT NULL,
  UNIQUE KEY `device_id_UNIQUE` (`device_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_device_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `device` (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_device`
--

LOCK TABLES `user_device` WRITE;
/*!40000 ALTER TABLE `user_device` DISABLE KEYS */;
INSERT INTO `user_device` VALUES (1,1),(2,2),(3,3),(4,4),(5,5);
/*!40000 ALTER TABLE `user_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_personal_info`
--

DROP TABLE IF EXISTS `user_personal_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_personal_info` (
  `user_id` int NOT NULL,
  `date_of_joining` date DEFAULT NULL,
  `user_address` varchar(45) DEFAULT NULL,
  `user_aadhar_number` varchar(45) DEFAULT NULL,
  `user_phone_number` varchar(45) DEFAULT NULL,
  `user_pan_number` varchar(45) DEFAULT NULL,
  `user_country` varchar(45) DEFAULT NULL,
  `user_state` varchar(45) DEFAULT NULL,
  `user_city` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_personal_info_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_personal_info`
--

LOCK TABLES `user_personal_info` WRITE;
/*!40000 ALTER TABLE `user_personal_info` DISABLE KEYS */;
INSERT INTO `user_personal_info` VALUES (1,'2016-02-02','zx','1111 1111 1111 1111','1111111111','aaaaaaaaaa','india','haryana'),(2,'2016-02-02','zx','2222 2222 2222 ','2222222222','bbbbbbbbbb','india','haryana'),(3,'2016-02-02','zx','3333 3333 3333 3333','3333333333','cccccccccc','india','haryana'),(4,'2016-02-02','zx','4444 4444 4444 4444','4444444444','dddddddddd','india','haryana'),(5,'2016-02-02','zx','5555 5555 5555 5555','5555555555','eeeeeeeeee','india','haryana');
/*!40000 ALTER TABLE `user_personal_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role` (
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `user_role_ibfk_2` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (6,1),(7,2),(5,3),(1,4),(2,4),(3,4),(4,4);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-27 18:00:29
