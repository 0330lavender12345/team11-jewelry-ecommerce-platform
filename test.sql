CREATE DATABASE  IF NOT EXISTS `team11_silverwrb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `team11_silverwrb`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: team11_silverwrb
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cartID` int NOT NULL AUTO_INCREMENT,
  `customerID` varchar(45) NOT NULL,
  `productID` varchar(45) NOT NULL,
  `orderQ` int NOT NULL,
  PRIMARY KEY (`cartID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,'1','2',2),(2,'1','1',1),(3,'1','3',1),(4,'1','10',1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guestbook`
--

DROP TABLE IF EXISTS `guestbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guestbook` (
  `GBNO` tinyint NOT NULL AUTO_INCREMENT,
  `ProductID` int NOT NULL,
  `Content` text,
  `Putdate` date DEFAULT NULL,
  `star` double DEFAULT NULL,
  PRIMARY KEY (`GBNO`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guestbook`
--

LOCK TABLES `guestbook` WRITE;
/*!40000 ALTER TABLE `guestbook` DISABLE KEYS */;
/*!40000 ALTER TABLE `guestbook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `MembersID` int unsigned NOT NULL AUTO_INCREMENT,
  `MembersEmail` varchar(45) NOT NULL,
  `MembersName` varchar(45) NOT NULL,
  `MembersPWD` varchar(45) NOT NULL,
  `MembersPhone` varchar(45) DEFAULT NULL,
  `MembersAddress` varchar(45) DEFAULT NULL,
  `Memberstype` varchar(45) DEFAULT 'member',
  PRIMARY KEY (`MembersID`,`MembersEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'try@gmail.com','try','1234','0900000001','桃園中壢','member'),(2,'ABC@gmail.com','ABC','2345','0900000002',NULL,'member'),(3,'Will@gmail.com','Will','0000','0900000003',NULL,'member');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `TradeID` int NOT NULL AUTO_INCREMENT,
  `OrderID` int NOT NULL,
  `OrderDate` datetime NULL,
  `OrderPay` varchar(45) NOT NULL,
  `OrderShip` varchar(45) NOT NULL,
  `ProductName` varchar(45) NOT NULL,
  `ProductPrice` int NOT NULL,
  `ProductAmount` int NOT NULL,
  `OrderTPrice` int NOT NULL,
  PRIMARY KEY (`TradeID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(45) NOT NULL,
  `ProductPrice` int DEFAULT NULL,
  `ProductClassification` varchar(20) DEFAULT NULL,
  `ProductIntro` varchar(100) DEFAULT NULL,
  `ProductIMG` varchar(45) DEFAULT NULL,
  `ProductINV` int DEFAULT NULL,
  `isAvailable` BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `ProductID_UNIQUE` (`ProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES 
(1,'銀河星宇戒指',350,'ring','銀河系列戒指，靈感源自浩瀚無垠的銀河系，以精緻的工藝和獨特的設計囊括星空的美麗和神秘。','assets/Images/ring01.jpg',30,TRUE),
(2,'銀河星辰戒指',350,'ring','銀河系列戒指，靈感源自浩瀚無垠的銀河系，以精緻的工藝和獨特的設計囊括星空的美麗和神秘。','assets/Images/ring02.jpg',40,TRUE),
(3,'銀河星輝戒指',350,'ring','銀河系列戒指，靈感源自浩瀚無垠的銀河系，以精緻的工藝和獨特的設計囊括星空的美麗和神秘。','assets/Images/ring03.jpg',20,TRUE),
(4,'銀環之舞戒指',400,'ring','以流暢的曲線和精緻的設計，展現出獨特的動感與美麗。','assets/Images/ring04.jpg',50,TRUE),
(5,'細褶輕舞戒指',400,'ring','以細膩的轉動設計為特色，仿若輕盈的舞姿在指間輕舞飛揚。','assets/Images/ring05.jpg',65,TRUE),
(6,'銀韻纏繞戒指',400,'ring','戒指的纏繞設計靈感源自大自然的優美曲線，象徵著生命的無盡延續與無限可能。','assets/Images/ring06.jpg',90,TRUE),
(7,'情繫心弦項鍊',1000,'necklace','將愛情的甜蜜與浪漫完美地呈現，代表著彼此深厚的情感和心弦的共鳴。','assets/Images/necklace01.jpg',10,TRUE),
(8,'星光密銀項鍊',1000,'necklace','靈感源自浩瀚無垠的銀河系，以精緻的工藝和獨特的設計囊括星空的美麗和神秘。','assets/Images/necklace02.jpg',23,TRUE),
(9,'銀韻葉影項鍊',1500,'necklace','優雅的葉子造型，猶如微風拂過時的柔美輪廓，展現出自然的美感和生命的活力。','assets/Images/necklace03.jpg',10,TRUE),
(10,'涙之物語項鍊',1500,'necklace','每一滴淚水都承載著一段感人的故事，讓您在每次佩戴時都能感受到深深的情感共鳴。','assets/Images/necklace04.jpg',12,TRUE),
(11,'聖潔十字項鍊',800,'necklace','十字是一種祝福，象徵著潔淨和光明，為您帶來心靈的寧靜和安定。','assets/Images/necklace05.jpg',14,TRUE),
(12,'白金古巴項鍊',800,'necklace','融合了白金的高貴與古巴風情的獨特，讓您在高貴之中略帶一絲野性展現個人魅力。','assets/Images/necklace06.jpg',58,TRUE),
(13,'銀線光影手鍊',1000,'bracelet','光影系列手鍊，靈感來自於月光下閃爍的銀色光芒，以簡約而優雅的設計捕捉光與影之間的微妙變幻。','assets/Images/bracelet01.jpg',34,TRUE),
(14,'魅力光影手鍊',1000,'bracelet','光影系列手鍊，靈感來自於月光下閃爍的銀色光芒，以簡約而優雅的設計捕捉光與影之間的微妙變幻。','assets/Images/bracelet02.jpg',28,TRUE),
(15,'典雅光影手鍊',900,'bracelet','光影系列手鍊，靈感來自於月光下閃爍的銀色光芒，以簡約而優雅的設計捕捉光與影之間的微妙變幻。','assets/Images/bracelet03.jpg',29,TRUE),
(16,'銀珠柔光手鍊',900,'bracelet','每一顆銀珠都經過精細拋光，散發出溫潤柔和的光澤，猶如月光下的珍珠般迷人，展現出低調卻引人注目的美感。','assets/Images/bracelet04.jpg',11,TRUE),
(17,'曜石繫情手鍊',1200,'bracelet','有一種石名為三生石，意寓愛你三生三世，象徵著深厚的情感和堅定不移的愛情。','assets/Images/bracelet05.jpg',25,TRUE),
(18,'浪漫際遇手鍊',1200,'bracelet','浪漫的邂逅和不期而遇的愛情，共同譜寫屬於您們的專屬故事。','assets/Images/bracelet06.jpg',57,TRUE),
(19,'優雅幾何耳環',300,'earring','簡約設計與時尚元素、時尚與優雅並存，每一對耳環都猶如一件藝術品，為您的造型增添迷人的魅力。','assets/Images/earing01.jpg',30,TRUE),
(20,'極簡菱形框耳環',300,'earring','極簡主義風格設計，沒有多餘的裝飾，僅有菱形框架，展現出簡約而不失品味的風格。','assets/Images/earing02.jpg',22,TRUE),
(21,'現代裝飾藝術耳環',300,'earring','融合了抽象、幾何或流線型等元素，展現了藝術品味和個性魅力。','assets/Images/earing03.jpg',21,TRUE),
(22,'月影之歌貼耳式耳環',300,'earring','以月亮和音樂的意象為靈感，讓您仿佛置身於月光下，感受夜晚下月和影的美妙旋律','assets/Images/earing04.jpg',8,TRUE),
(23,'鑽石微光貼耳式耳環',500,'earring','精湛的手工鑲嵌工藝，每顆鑽石都在光線下綻放出璀璨的微光，讓您在每一個瞬間都如同鑽石般閃耀迷人，散發無盡的魅力與光芒。','assets/Images/earing05.jpg',44,TRUE),
(24,'點綴夜空貼耳式耳環',300,'earring','靈感源自夜空中的繁星閃爍，專為散發優雅與高貴氣質的您精心打造，為您的整體造型增添一份神秘而高貴的魅力。','assets/Images/earing06.jpg',23,TRUE);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-25 21:23:21
