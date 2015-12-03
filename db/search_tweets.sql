/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.6.16 : Database - test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`test` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `test`;

/*Table structure for table `tweets` */

DROP TABLE IF EXISTS `tweets`;

CREATE TABLE `tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `tweets` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `tweets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `tweets` */

insert  into `tweets`(`id`,`user_id`,`place`,`tweets`,`created_at`) values (3,1,'viet nam','[{\"desc\":\"Truth \\\"@Manda_like_wine: Everything makes sense once you find and replace \\\"prayers\\\" with \\\"posturing.\\\"\\\"\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/650711334129025024\\/DJntrbF__normal.jpg\",\"created_at\":\"Thu Dec 03 03:52:48 +0000 2015\",\"lat\":13.9797707,\"long\":108.0052931},{\"desc\":\"\\\"@TheMichaelMoran: I know what all those words mean, I have no idea what you said. https:\\/\\/t.co\\/eLhpXuBXvi\\\"\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/650711334129025024\\/DJntrbF__normal.jpg\",\"created_at\":\"Wed Dec 02 17:14:45 +0000 2015\",\"lat\":13.9797758,\"long\":108.0052678},{\"desc\":\"Just posted a photo @ Pleiku https:\\/\\/t.co\\/ubMlvPuc8o\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/650711334129025024\\/DJntrbF__normal.jpg\",\"created_at\":\"Wed Dec 02 14:01:20 +0000 2015\",\"lat\":13.98333333,\"long\":108},{\"desc\":\"Comic book my students made @ Pleiku https:\\/\\/t.co\\/VU8eDedw8g\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/650711334129025024\\/DJntrbF__normal.jpg\",\"created_at\":\"Wed Dec 02 14:00:14 +0000 2015\",\"lat\":13.98333333,\"long\":108},{\"desc\":\"#\\u0e17\\u0e38\\u0e01\\u0e04\\u0e27\\u0e32\\u0e21\\u0e17\\u0e23\\u0e07\\u0e08\\u0e33\\u0e40\\u0e23\\u0e34\\u0e48\\u0e21\\u0e15\\u0e49\\u0e19\\u0e17\\u0e35\\u0e48\\u0e19\\u0e35\\u0e48\\n\\nC\\u1ea3m \\u01a1n https:\\/\\/t.co\\/xgC26r7h6T\\u1ec7t nam corporation\\u2026 https:\\/\\/t.co\\/ZDOQTJYkJ0\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/669967083178868736\\/ToOGXdCh_normal.jpg\",\"created_at\":\"Wed Dec 02 04:44:29 +0000 2015\",\"lat\":14.26191693,\"long\":109.18209734},{\"desc\":\"@Love_Sy_3a https:\\/\\/t.co\\/n8sdPfrT8l\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/492860918649192448\\/n7ozBv3u_normal.jpeg\",\"created_at\":\"Mon Nov 30 07:16:59 +0000 2015\",\"lat\":13.9558119,\"long\":108.0415556},{\"desc\":\"Nemenin ksygan\\u2026 https:\\/\\/t.co\\/LdD0WwOyNq\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/588163754296270849\\/CIwAMHeJ_normal.jpg\",\"created_at\":\"Sat Nov 28 15:47:59 +0000 2015\",\"lat\":13.97456231,\"long\":107.99843337},{\"desc\":\"Do I Love Music?\\nhttps:\\/\\/t.co\\/P0t4FlROrS\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/492860918649192448\\/n7ozBv3u_normal.jpeg\",\"created_at\":\"Sat Nov 28 15:29:36 +0000 2015\",\"lat\":13.9540865,\"long\":108.0415878},{\"desc\":\"#7535\\nTa Veaeng Kraom, Cambodia\\nmap: https:\\/\\/t.co\\/cogw9t3PbA https:\\/\\/t.co\\/srKe1AwaCt\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/488395739467231233\\/B0hzao35_normal.jpeg\",\"created_at\":\"Fri Nov 27 21:29:10 +0000 2015\",\"lat\":14.01030589,\"long\":107.09274107},{\"desc\":\"@tomtomorrow @Snowden Wow! A web server eating the ass of American propaganda new @wikileaks  logo? https:\\/\\/t.co\\/7n9tryvHyR\\\"\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/650711334129025024\\/DJntrbF__normal.jpg\",\"created_at\":\"Fri Nov 27 05:15:08 +0000 2015\",\"lat\":13.9770098,\"long\":108.0019426},{\"desc\":\"Chuy\\u1ec3n b\\u1ea5t k\\u1ef3 ch\\u1eef g\\u00ec th\\u00e0nh M\\u00e3 Mo\\u00f3c b\\u1eb1ng \\u1ee8ng D\\u1ee5ng Chuy\\u1ec3n M\\u00e3 Mo\\u00f3c n\\u00e0yp - http:\\/\\/https:\\/\\/t.co\\/Kxl2rfftYf\",\"avatar\":\"http:\\/\\/abs.twimg.com\\/sticky\\/default_profile_images\\/default_profile_1_normal.png\",\"created_at\":\"Thu Nov 26 21:44:39 +0000 2015\",\"lat\":13.952912,\"long\":108.661296},{\"desc\":\"#ModernTimes @ Pleiku https:\\/\\/t.co\\/1dceDU02iV\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/650711334129025024\\/DJntrbF__normal.jpg\",\"created_at\":\"Thu Nov 26 14:08:52 +0000 2015\",\"lat\":13.98333333,\"long\":108},{\"desc\":\"Happy Thanksgiving @ Pleiku https:\\/\\/t.co\\/qmr326vHmg\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/650711334129025024\\/DJntrbF__normal.jpg\",\"created_at\":\"Thu Nov 26 14:05:54 +0000 2015\",\"lat\":13.98333333,\"long\":108},{\"desc\":\"Just posted a photo @ Life\'s A Beach https:\\/\\/t.co\\/JnPKsmQkyO\",\"avatar\":\"http:\\/\\/pbs.twimg.com\\/profile_images\\/3390593944\\/410cd97e1517b00e5b3631fb2a2ee4f4_normal.jpeg\",\"created_at\":\"Thu Nov 26 08:53:16 +0000 2015\",\"lat\":13.6854361,\"long\":109.23100679}]','2015-12-03 11:35:59');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `auth_key` varchar(32) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`auth_key`,`password_hash`,`password_reset_token`,`email`,`status`,`created_at`,`updated_at`) values (1,'demo','u4qnlunMrSWqcyitTV06gH5C8ZlAaWar','$2y$13$dN9ipH0Pc2zLBsDGfIkLOuZDvG0Lv5YACMWCAUIYeCHqNKfw3VbDa',NULL,'demo@localhost.com',10,1428424049,1428424049);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
