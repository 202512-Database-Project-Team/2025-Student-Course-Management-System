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
INSERT INTO `c` VALUES (1001,'数据结构',3),
(1002,'计算机网络',3),
(1003,'计算机组成原理',4),
(1004,'操作系统',3),
(1005,'数据库系统原理',3),
(1006,'编译原理',4),
(1007,'软件工程',3),
(1008,'人工智能导论',2),
(1009,'机器学习',4),
(1010,'深度学习',5),
(1011,'算法设计与分析',3),
(1012,'离散数学',3),
(1013,'嵌入式系统',4),
(1014,'信息安全基础',2),
(1015,'网络安全',3),
(1016,'分布式系统',3),
(1017,'云计算',4),
(1018,'大数据技术',3),
(1019,'计算机图形学',3),
(1020,'人机交互',4);
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
INSERT INTO `ct` VALUES (1,1001,81000001,'22-春季学期'),
(2,1004,81000002,'22-春季学期'),
(3,1005,81000003,'22-春季学期'),
(4,1008,81000004,'22-春季学期'),
(5,1009,81000005,'22-春季学期'),
(6,1010,81000006,'22-春季学期'),
(7,1014,81000007,'22-春季学期'),
(8,1018,81000008,'22-春季学期'),
(9,1019,81000009,'22-春季学期'),
(10,1020,81000010,'22-春季学期');
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
INSERT INTO `s` VALUES (82250001,'张吉惟','111'),
(82250002,'林国瑞','222'),
(82250003,'林玟书','3333'),
(82250004,'林雅南','4444'),
(82250005,'江奕云','12345'),
(82250006,'刘柏宏','10086'),
(82250007,'阮建安','123'),
(82250008,'林子帆','123'),
(82250009,'夏志豪','123'),
(82250010,'吉茹定','123'),
(82250011,'李中冰','123'),
(82250012,'黄文隆','123'),
(82250013,'谢彦文','123'),
(82250014,'傅智翔','123'),
(82250015,'洪振霞','123'),
(82250016,'刘姿婷','123'),
(82250017,'荣姿康','123'),
(82250018,'吕致盈','123'),
(82250019,'方一强','123'),
(82250020,'黎芸贵','123'),
(82250021,'郑伊雯','123'),
(82250022,'雷进宝','123'),
(82250023,'吴美隆','123'),
(82250024,'吴心真','123'),
(82250025,'王美珠','123'),
(82250026,'郭芳天','123'),
(82250027,'李雅惠','123'),
(82250028,'陈文婷','123'),
(82250029,'曹敏侑','123'),
(82250030,'王依婷','123'),
(82250031,'陈婉璇','123'),
(82250032,'吴美玉','123'),
(82250033,'蔡依婷','123'),
(82250034,'郑昌梦','123'),
(82250035,'林家纶','123'),
(82250036,'黄丽昆','123'),
(82250037,'李育泉','123'),
(82250038,'黄芸欢','123'),
(82250039,'吴韵如','123'),
(82250040,'李肇芬','123'),
(82250041,'卢木仲','123'),
(82250042,'李成白','123'),
(82250043,'方兆玉','123'),
(82250044,'刘翊惠','123'),
(82250045,'丁汉臻','123'),
(82250046,'吴佳瑞','123'),
(82250047,'舒绿珮','123'),
(82250048,'周白芷','123'),
(82250049,'张姿妤','123'),
(82250050,'张虹伦','123'),
(82250051,'周琼玟','123'),
(82250052,'倪怡芳','123'),
(82250053,'郭贵妃','123'),
(82250054,'杨佩芳','123'),
(82250055,'黄文旺','123'),
(82250056,'黄盛玫','123'),
(82250057,'郑丽青','123'),
(82250058,'许智云','123'),
(82250059,'张孟涵','123'),
(82250060,'李小爱','123'),
(82250061,'王恩龙','123'),
(82250062,'朱政廷','123'),
(82250063,'邓诗涵','123'),
(82250064,'陈政倩','123'),
(82250065,'吴俊伯','123'),
(82250066,'阮馨学','123');
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
INSERT INTO `sct` VALUES (1,82250001,1001,81000001,NULL,'22-春季学期');
--
-- Dumping data for table `sct`
--

DDROP TABLE IF EXISTS `apply_exemption`;
CREATE TABLE `apply_exemption` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
    `sid` int(11) NOT NULL COMMENT '学生ID',
    `cid` int(11) NOT NULL COMMENT '课程ID',
    `term` varchar(30) NOT NULL COMMENT '学期',
    `reason` varchar(255) DEFAULT NULL COMMENT '申请理由',
    `proof` varchar(255) DEFAULT NULL COMMENT '证明材料URL',
    `status` int(1) DEFAULT 0 COMMENT '0:待审核, 1:已通过, 2:已驳回',
    `audit_reason` varchar(255) DEFAULT NULL COMMENT '审核意见',
    `audit_by` int(11) DEFAULT NULL COMMENT '审核人ID',
    `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
    `audit_time` datetime DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





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
INSERT INTO `t` VALUES (6,'admin','123'),(81000001,'王伟','123456'),
(81000002,'张磊','123456'),
(81000003,'陈涛','123456'),
(81000004,'刘芳','123456'),
(81000005,'杨雪','123456'),
(81000006,'周婷','123456'),
(81000007,'张文华','123456'),
(81000008,'王建国','123456'),
(81000009,'李志强','123456'),
(81000010,'刘成伟','123456');
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
