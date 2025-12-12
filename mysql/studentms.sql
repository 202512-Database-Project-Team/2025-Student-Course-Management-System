-- MySQL dump 10.13  Distrib 5.7.33, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: studentms
-- ------------------------------------------------------
-- Server version	5.7.33-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `c`
--
SET NAMES 'utf8mb4';
set character set  utf8mb4;
drop database if exists studentms;
CREATE DATABASE studentms DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT all ON studentms.* TO 'root'@'%';
use studentms;

DROP TABLE IF EXISTS `c`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `c` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(30) NOT NULL,
  `ccredit` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c`
--

LOCK TABLES `c` WRITE;
/*!40000 ALTER TABLE `c` DISABLE KEYS */;
INSERT INTO `c` VALUES (7,'数据结构',6),(8,'组合数学',3),(9,'计算机网络',5),(10,'计算机组成原理',5),(11,'RJC教你做选课系统',10);
/*!40000 ALTER TABLE `c` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ct`
--

DROP TABLE IF EXISTS `ct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ct` (
  `ctid` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `term` varchar(30) NOT NULL,
  PRIMARY KEY (`ctid`),
  KEY `cid` (`cid`),
  KEY `tid` (`tid`),
  CONSTRAINT `ct_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `c` (`cid`),
  CONSTRAINT `ct_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `t` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ct`
--

LOCK TABLES `ct` WRITE;
/*!40000 ALTER TABLE `ct` DISABLE KEYS */;
INSERT INTO `ct` VALUES (5,8,4,'22-春季学期'),(6,7,4,'22-春季学期'),(7,10,13,'22-春季学期'),(8,9,13,'22-春季学期'),(9,11,4,'22-春季学期');
/*!40000 ALTER TABLE `ct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s`
--

DROP TABLE IF EXISTS `s`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `s` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sname` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s`
--

LOCK TABLES `s` WRITE;
/*!40000 ALTER TABLE `s` DISABLE KEYS */;
INSERT INTO `s` VALUES (1,'阮健乘','1234'),(2,'张四','123'),(3,'李四','1234'),(4,'彭昊辉','123456'),(6,'林春霞','123'),(7,'董一超','12345'),(8,'董超','123'),(9,'张千','10086'),(10,'李万','10085'),(14,'薇尔莉特','123'),(21,'庄亮','123'),(22,'钟平','1234'),(23,'李煜豪','123'),(24,'胡嵩鼎','1234'),(100,'zhang','100');
/*!40000 ALTER TABLE `s` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sct`
--

DROP TABLE IF EXISTS `sct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sct` (
  `sctid` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `grade` float DEFAULT NULL,
  `term` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`sctid`),
  KEY `sid` (`sid`),
  KEY `tid` (`tid`),
  KEY `cid` (`cid`),
  CONSTRAINT `sct_ibfk_1` FOREIGN KEY (`sid`) REFERENCES `s` (`sid`),
  CONSTRAINT `sct_ibfk_2` FOREIGN KEY (`tid`) REFERENCES `ct` (`tid`),
  CONSTRAINT `sct_ibfk_3` FOREIGN KEY (`cid`) REFERENCES `ct` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `sct` VALUES (1,1,1,1,'通过',1);
--
-- Dumping data for table `sct`
--

DROP TABLE IF EXISTS `apply_exemption`;

CREATE TABLE `apply_exemption` (
    `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `sid` INT(11) NOT NULL COMMENT '关联学生表s.sid',
    `cid` INT(11) NOT NULL COMMENT '关联课程表c.cid',
    `term` VARCHAR(30) NOT NULL COMMENT '申请学期 (如: 22-春季学期)',
    `reason` VARCHAR(255) DEFAULT NULL COMMENT '申请理由',
    `status` INT(1) DEFAULT 0 COMMENT '0:待审核, 1:已通过, 2:已驳回',
    `audit_reason` VARCHAR(255) DEFAULT NULL COMMENT '审核意见',
    `audit_by` INT(11) DEFAULT NULL COMMENT '审核人(教师ID)',
    `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    `audit_time` DATETIME DEFAULT NULL COMMENT '审核时间',
    `image_url` VARCHAR(255) DEFAULT NULL COMMENT '存放图片路径或 URL',
    PRIMARY KEY (`id`),
    KEY `idx_sid` (`sid`),
    KEY `idx_cid` (`cid`),
    CONSTRAINT `fk_apply_sid` FOREIGN KEY (`sid`) REFERENCES `s` (`sid`) ON DELETE CASCADE,
    CONSTRAINT `fk_apply_cid` FOREIGN KEY (`cid`) REFERENCES `c` (`cid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生免修免考申请表';







LOCK TABLES `sct` WRITE;
/*!40000 ALTER TABLE `sct` DISABLE KEYS */;
INSERT INTO `sct` VALUES (10,2,8,4,1,'22-春季学期'),(11,2,10,13,NULL,'22-春季学期'),(12,2,7,4,NULL,'22-春季学期'),(13,4,8,4,10,'22-春季学期'),(14,4,7,4,NULL,'22-春季学期'),(15,4,10,13,NULL,'22-春季学期');
/*!40000 ALTER TABLE `sct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t`
--

DROP TABLE IF EXISTS `t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `t` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t`
--

LOCK TABLES `t` WRITE;
/*!40000 ALTER TABLE `t` DISABLE KEYS */;
INSERT INTO `t` VALUES (4,'李玉民','123'),(6,'admin','123'),(13,'张三','123');
/*!40000 ALTER TABLE `t` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

GRANT all ON studentms.* TO 'root'@'%';
