/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.6.22-enterprise-commercial-advanced : Database - ssm
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

/*Data for the table `wx_login` */

insert  into `wx_login`(`id`,`openid`,`session_key`,`nickName`,`gender`,`country`,`province`,`city`,`avatarUrl`,`addTime`) values 
(34,'oyMvT5Lihfbj04qU6EVanyq3g9Fo','+Qg50xAblH0zbrfY/XdL6A==','??',1,'China','Sichuan','Luzhou','https://wx.qlogo.cn/mmopen/vi_32/X9FT5ck3rC9vZ8vkwfQibzicuhyicYaDMuyzrpAr5ItRKfUXCLmIHIw9vTaJGdWroMMUhUFrKD60rtlicwmNOSbB9w/1325520','2019-01-20 05:26:36'),
(35,'oyMvT5Hu5OXY0F7GG9qAA0oyzgIU','NRiPCZuVx913ZIXyxLsjxA==','?????',1,'Andorra','','','https://wx.qlogo.cn/mmopen/vi_32/1UrfvicTAZqfJIqAjbEiaGJiaLcP3nNdOWlDPFfc7HzYo6thRUiaF1euibTNqbvKEBNLeo8MPZ40jW2VkzcLd6AqiaeA/132','2019-01-20 05:27:29');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
