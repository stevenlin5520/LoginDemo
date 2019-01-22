/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.7.17-log : Database - ssm
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ssm` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ssm`;

/*Table structure for table `wx_login` */

DROP TABLE IF EXISTS `wx_login`;

CREATE TABLE `wx_login` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `openid` varchar(255) DEFAULT NULL,
  `session_key` varchar(255) DEFAULT NULL,
  `nickName` varchar(255) DEFAULT NULL,
  `gender` int(1) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `avatarUrl` varchar(255) DEFAULT NULL,
  `addTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `wx_login` */

insert  into `wx_login`(`id`,`openid`,`session_key`,`nickName`,`gender`,`country`,`province`,`city`,`avatarUrl`,`addTime`) values 
(32,'oyMvT5Lihfbj04qU6EVanyq3g9Fo','d4fYu4h42whrYXy3z/keow==','Key先生',1,'China','Sichuan','Luzhou','https://wx.qlogo.cn/mmopen/vi_32/X9FT5ck3rC9vZ8vkwfQibzicuhyicYaDMuyzrpAr5ItRKfUXCLmIHIw9vTaJGdWroMMUhUFrKD60rtlicwmNOSbB9w/1322','2019-01-20 04:33:35');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
