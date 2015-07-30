/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.1.55-community : Database - mis
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mis` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mis`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

insert  into `auth_group`(`id`,`name`) values (2,'人事'),(1,'职员');

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

insert  into `auth_group_permissions`(`id`,`group_id`,`permission_id`) values (96,1,11),(97,1,37),(98,1,38),(99,1,39),(100,1,43),(101,1,44),(102,1,45),(103,1,55),(104,1,56),(105,1,57),(106,1,89),(107,1,91),(108,1,92),(109,1,93),(110,1,94),(111,1,95),(112,1,96),(113,1,97),(114,1,98),(115,1,99),(116,1,113),(117,1,114),(118,1,119),(119,1,120),(120,1,121),(121,1,122),(122,1,123),(123,1,124),(124,1,125),(125,1,126),(126,1,127),(87,1,128),(88,1,129),(89,1,130),(90,1,131),(91,1,132),(92,1,133),(93,1,134),(94,1,135),(95,1,136),(45,2,115);

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add Site',7,'add_site'),(20,'Can change Site',7,'change_site'),(21,'Can delete Site',7,'delete_site'),(22,'Can add module',8,'add_module'),(23,'Can change module',8,'change_module'),(24,'Can delete module',8,'delete_module'),(25,'Can add menu',9,'add_menu'),(26,'Can change menu',9,'change_menu'),(27,'Can delete menu',9,'delete_menu'),(28,'Can add role',10,'add_role'),(29,'Can change role',10,'change_role'),(30,'Can delete role',10,'delete_role'),(31,'Can add value list',11,'add_valuelist'),(32,'Can change value list',11,'change_valuelist'),(33,'Can delete value list',11,'delete_valuelist'),(34,'Can add list item',12,'add_valuelistitem'),(35,'Can change list item',12,'change_valuelistitem'),(36,'Can delete list item',12,'delete_valuelistitem'),(37,'Can add address',13,'add_address'),(38,'Can change address',13,'change_address'),(39,'Can delete address',13,'delete_address'),(40,'Can add partner',14,'add_partner'),(41,'Can change partner',14,'change_partner'),(42,'Can delete partner',14,'delete_partner'),(43,'Can add bank account',15,'add_bankaccount'),(44,'Can change bank account',15,'change_bankaccount'),(45,'Can delete bank account',15,'delete_bankaccount'),(46,'Can add organization',16,'add_organization'),(47,'Can change organization',16,'change_organization'),(48,'Can delete organization',16,'delete_organization'),(49,'Can add org unit',17,'add_orgunit'),(50,'Can change org unit',17,'change_orgunit'),(51,'Can delete org unit',17,'delete_orgunit'),(52,'Can add position',18,'add_position'),(53,'Can change position',18,'change_position'),(54,'Can delete position',18,'delete_position'),(55,'Can add project',19,'add_project'),(56,'Can change project',19,'change_project'),(57,'Can delete project',19,'delete_project'),(58,'Can add warehouse',20,'add_warehouse'),(59,'Can change warehouse',20,'change_warehouse'),(60,'Can delete warehouse',20,'delete_warehouse'),(61,'Can add measure',21,'add_measure'),(62,'Can change measure',21,'change_measure'),(63,'Can delete measure',21,'delete_measure'),(64,'Can add trade',22,'add_trade'),(65,'Can change trade',22,'change_trade'),(66,'Can delete trade',22,'delete_trade'),(67,'Can add brand',23,'add_brand'),(68,'Can change brand',23,'change_brand'),(69,'Can delete brand',23,'delete_brand'),(70,'Can add category',24,'add_category'),(71,'Can change category',24,'change_category'),(72,'Can delete category',24,'delete_category'),(73,'Can add technical parameter',25,'add_technicalparametername'),(74,'Can change technical parameter',25,'change_technicalparametername'),(75,'Can delete technical parameter',25,'delete_technicalparametername'),(76,'Can add technical value',26,'add_technicalparametervalue'),(77,'Can change technical value',26,'change_technicalparametervalue'),(78,'Can delete technical value',26,'delete_technicalparametervalue'),(79,'Can add material',27,'add_material'),(80,'Can change material',27,'change_material'),(81,'Can delete material',27,'delete_material'),(82,'Can add material parameter',28,'add_materialparam'),(83,'Can change material parameter',28,'change_materialparam'),(84,'Can delete material parameter',28,'delete_materialparam'),(85,'Can add expenses account',29,'add_expenseaccount'),(86,'Can change expenses account',29,'change_expenseaccount'),(87,'Can delete expenses account',29,'delete_expenseaccount'),(88,'Can add employee',30,'add_employee'),(89,'Can change employee',30,'change_employee'),(90,'Can delete employee',30,'delete_employee'),(91,'Can add family member',31,'add_family'),(92,'Can change family member',31,'change_family'),(93,'Can delete family member',31,'delete_family'),(94,'Can add education experience',32,'add_education'),(95,'Can change education experience',32,'change_education'),(96,'Can delete education experience',32,'delete_education'),(97,'Can add work experience',33,'add_workexperience'),(98,'Can change work experience',33,'change_workexperience'),(99,'Can delete work experience',33,'delete_workexperience'),(100,'Can add workflow model',34,'add_modal'),(101,'Can change workflow model',34,'change_modal'),(102,'Can delete workflow model',34,'delete_modal'),(103,'Can add workflow node',35,'add_node'),(104,'Can change workflow node',35,'change_node'),(105,'Can delete workflow node',35,'delete_node'),(106,'Can add workflow instance',36,'add_instance'),(107,'Can change workflow instance',36,'change_instance'),(108,'Can delete workflow instance',36,'delete_instance'),(109,'Can add workflow history',37,'add_history'),(110,'Can change workflow history',37,'change_history'),(111,'Can delete workflow history',37,'delete_history'),(112,'Can add workflow todo',38,'add_todolist'),(113,'Can change workflow todo',38,'change_todolist'),(114,'Can delete workflow todo',38,'delete_todolist'),(115,'view all employee',30,'view_all_employee'),(116,'Can add extra param',39,'add_extraparam'),(117,'Can change extra param',39,'change_extraparam'),(118,'Can delete extra param',39,'delete_extraparam'),(119,'Can add work order',40,'add_workorder'),(120,'Can change work order',40,'change_workorder'),(121,'Can delete work order',40,'delete_workorder'),(122,'Can add wo extra value',41,'add_woextravalue'),(123,'Can change wo extra value',41,'change_woextravalue'),(124,'Can delete wo extra value',41,'delete_woextravalue'),(125,'Can add wo item',42,'add_woitem'),(126,'Can change wo item',42,'change_woitem'),(127,'Can delete wo item',42,'delete_woitem'),(128,'Can add loan',43,'add_loan'),(129,'Can change loan',43,'change_loan'),(130,'Can delete loan',43,'delete_loan'),(131,'Can add reimbursement',44,'add_reimbursement'),(132,'Can change reimbursement',44,'change_reimbursement'),(133,'Can delete reimbursement',44,'delete_reimbursement'),(134,'Can add fee item ',45,'add_reimbursementitem'),(135,'Can change fee item ',45,'change_reimbursementitem'),(136,'Can delete fee item ',45,'delete_reimbursementitem'),(137,'Can add salary item',46,'add_salaryitem'),(138,'Can change salary item',46,'change_salaryitem'),(139,'Can delete salary item',46,'delete_salaryitem'),(140,'Can add employee entry',47,'add_entry'),(141,'Can change employee entry',47,'change_entry'),(142,'Can delete employee entry',47,'delete_entry'),(143,'Can add salary item',48,'add_employeesalaryitem'),(144,'Can change salary item',48,'change_employeesalaryitem'),(145,'Can delete salary item',48,'delete_employeesalaryitem'),(146,'Can add employee transfer',49,'add_transfer'),(147,'Can change employee transfer',49,'change_transfer'),(148,'Can delete employee transfer',49,'delete_transfer'),(149,'Can add employee departure',50,'add_departure'),(150,'Can change employee departure',50,'change_departure'),(151,'Can delete employee departure',50,'delete_departure'),(152,'modify salary item',47,'modify_salary_item');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (1,'pbkdf2_sha256$20000$Cr1ZLAvD7UNR$rtQpXM9iVLITGsqlNuckLmxew/te4/wFkuAt5A8hr8c=','2015-05-24 08:33:50',1,'zhugl','国良','朱','zhuinfo@126.com',1,1,'2015-05-01 07:28:00'),(2,'pbkdf2_sha256$20000$yHALLf8oZTHr$vAIEBzQtknyeyBhEnFKXRyqoBplytPGLjQPkWZyN42c=','2015-05-24 08:04:02',0,'luy','阳','陆','luy@126.com',1,1,'2015-05-10 16:36:00'),(3,'pbkdf2_sha256$20000$cC4dja4Kouje$m4brdyu6sT2FtmWuUf8oJtfvUki5lCf0ol/3h4uVqRs=','2015-05-24 08:01:56',0,'zhangliangjun','良君','张','zhanglj@qiteng.com',1,1,'2015-05-24 08:00:00');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_30a071c9_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_30a071c9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_24702650_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

insert  into `auth_user_groups`(`id`,`user_id`,`group_id`) values (2,2,1),(3,2,2),(5,3,1);

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_user_permissions_user_id_7cd7acb6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_user_perm_permission_id_3d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `basedata_address` */

DROP TABLE IF EXISTS `basedata_address`;

CREATE TABLE `basedata_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `zipcode` varchar(8) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `contacts` varchar(40) DEFAULT NULL,
  `address_type` varchar(2),
  `content_type_id` int(11),
  `object_id` int(10) unsigned,
  PRIMARY KEY (`id`),
  KEY `basedata_address_417f1b1c` (`content_type_id`),
  CONSTRAINT `basedata_addr_content_type_id_17983026_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_address` */

/*Table structure for table `basedata_bankaccount` */

DROP TABLE IF EXISTS `basedata_bankaccount`;

CREATE TABLE `basedata_bankaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `account` varchar(40) NOT NULL,
  `title` varchar(40) NOT NULL,
  `memo` varchar(20) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_bankaccount_partner_id_561018ee_fk_basedata_partner_id` (`partner_id`),
  CONSTRAINT `basedata_bankaccount_partner_id_561018ee_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_bankaccount` */

/*Table structure for table `basedata_brand` */

DROP TABLE IF EXISTS `basedata_brand`;

CREATE TABLE `basedata_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(120) NOT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `trade_id` int(11),
  `weight` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_brand_09249466` (`trade_id`),
  CONSTRAINT `basedata_brand_trade_id_bdcfb86_fk_basedata_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `basedata_trade` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_brand` */

insert  into `basedata_brand`(`id`,`name`,`pinyin`,`trade_id`,`weight`) values (1,'LENOVO-联想','',NULL,99),(2,'DELL','',3,99);

/*Table structure for table `basedata_category` */

DROP TABLE IF EXISTS `basedata_category`;

CREATE TABLE `basedata_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `path` varchar(200) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `trade_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_category_parent_id_43280ad5_fk_basedata_category_id` (`parent_id`),
  KEY `basedata_category_09249466` (`trade_id`),
  CONSTRAINT `basedata_category_parent_id_43280ad5_fk_basedata_category_id` FOREIGN KEY (`parent_id`) REFERENCES `basedata_category` (`id`),
  CONSTRAINT `basedata_category_trade_id_7d069922_fk_basedata_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `basedata_trade` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_category` */

insert  into `basedata_category`(`id`,`code`,`name`,`path`,`parent_id`,`trade_id`) values (1,'F01','内部服务','',NULL,NULL),(2,'F02','办公设备','',NULL,NULL),(3,'F03','笔记本电脑','办公设备',2,NULL);

/*Table structure for table `basedata_education` */

DROP TABLE IF EXISTS `basedata_education`;

CREATE TABLE `basedata_education` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `edu_type` varchar(2) NOT NULL,
  `school` varchar(120) NOT NULL,
  `major` varchar(120) DEFAULT NULL,
  `degree` varchar(2) DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_education_employee_id_54096a10_fk_basedata_employee_id` (`employee_id`),
  CONSTRAINT `basedata_education_employee_id_54096a10_fk_basedata_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `basedata_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_education` */

insert  into `basedata_education`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`edu_type`,`school`,`major`,`degree`,`employee_id`) values (1,'2004-09-01','2008-07-01',NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','20','南京中医药大学','计算机科学与技术','4',1),(2,'2003-09-01','2004-07-01',NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','60','山西省运城中学','','9',1),(3,'2000-09-01','2003-07-01',NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','60','山西省闻喜中学','','9',1),(5,'2005-09-10','2009-09-10',NULL,NULL,'2015-05-10 16:45:33','2015-05-10 16:45:33','20','江苏教育学院','英语','4',3);

/*Table structure for table `basedata_employee` */

DROP TABLE IF EXISTS `basedata_employee`;

CREATE TABLE `basedata_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(2) NOT NULL,
  `idcard` varchar(20) NOT NULL,
  `country` varchar(2) DEFAULT NULL,
  `hometown` varchar(40) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `banknum` varchar(40) DEFAULT NULL,
  `bankname` varchar(80) DEFAULT NULL,
  `emergency` varchar(40) DEFAULT NULL,
  `rank` varchar(2) NOT NULL,
  `workday` date DEFAULT NULL,
  `startday` date DEFAULT NULL,
  `religion` varchar(2) DEFAULT NULL,
  `marital` varchar(2),
  `party` varchar(2),
  `nation` varchar(2),
  `ygxs` varchar(2),
  `status` varchar(2),
  `category` varchar(2),
  `literacy` varchar(2) DEFAULT NULL,
  `major` varchar(2),
  `degree` varchar(2),
  `tag1` varchar(2),
  `tag2` varchar(2),
  `tag3` varchar(2),
  `tag4` varchar(2),
  `organization_id` int(11) DEFAULT NULL,
  `position_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(20),
  `office` varchar(20),
  `phone` varchar(20),
  `health` varchar(2),
  `spjob` varchar(2),
  PRIMARY KEY (`id`),
  KEY `basedata_emplo_organization_id_3b46dfdc_fk_organ_organization_id` (`organization_id`),
  KEY `basedata_employee_position_id_3d7368b4_fk_organ_position_id` (`position_id`),
  KEY `basedata_employee_user_id_6883fc78_fk_auth_user_id` (`user_id`),
  CONSTRAINT `basedata_employee_position_id_3d7368b4_fk_organ_position_id` FOREIGN KEY (`position_id`) REFERENCES `organ_position` (`id`),
  CONSTRAINT `basedata_employee_user_id_6883fc78_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `basedata_emplo_organization_id_3b46dfdc_fk_organ_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organ_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_employee` */

insert  into `basedata_employee`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`pinyin`,`birthday`,`gender`,`idcard`,`country`,`hometown`,`address`,`banknum`,`bankname`,`emergency`,`rank`,`workday`,`startday`,`religion`,`marital`,`party`,`nation`,`ygxs`,`status`,`category`,`literacy`,`major`,`degree`,`tag1`,`tag2`,`tag3`,`tag4`,`organization_id`,`position_id`,`user_id`,`email`,`office`,`phone`,`health`,`spjob`) values (1,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 15:38:58','2015-05-24 19:02:34','22538','朱国良','zhuguoliang','1985-05-03','1','142729198502052119','CN','山西闻喜','南京市浦口区珍珠南路2号明发城市广场','6225102450982716','招商银行','陆阳 13814050418','23','2008-09-01','2014-01-13','10','20','03','01','2','10','30','10','08','4','99','9','00','0',NULL,3,1,'zhugl@asiainfo.com','','13851668514','1','00'),(3,'2015-05-10','9999-12-31','zhugl','luy','2015-05-10 16:45:33','2015-05-10 17:04:41','10003','陆阳','luyang','1988-11-12','2','32102919881112574X','CN','','','','','','10','2009-09-10','2015-05-10','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,2,2,'zhuinfo@126.com','','13814050418','1','00'),(4,'2015-05-16','9999-12-31','zhugl','zhugl','2015-05-16 22:54:31','2015-05-16 22:56:39','60059','刘三姐','liusanjie','1988-11-12','2','412328198811128742','CN','','','','','','12','1978-09-01','2015-05-16','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,3,NULL,'sanjie.liu@126.com','','13913931587','1','00'),(5,'2015-05-17','9999-12-31','zhugl',NULL,'2015-05-17 09:44:58','2015-05-17 09:44:58','60060','郑三炮','zhengsanpao','1956-08-09','1','320123195608092321','CN','','','','','','15','1976-09-01','2015-05-17','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,2,NULL,'sanpao.z@126.com','','13212341234','1','00');

/*Table structure for table `basedata_expenseaccount` */

DROP TABLE IF EXISTS `basedata_expenseaccount`;

CREATE TABLE `basedata_expenseaccount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `category` varchar(4) NOT NULL,
  `description` longtext,
  `status` tinyint(1) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_expens_parent_id_61334aac_fk_basedata_expenseaccount_id` (`parent_id`),
  CONSTRAINT `basedata_expens_parent_id_61334aac_fk_basedata_expenseaccount_id` FOREIGN KEY (`parent_id`) REFERENCES `basedata_expenseaccount` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_expenseaccount` */

insert  into `basedata_expenseaccount`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`category`,`description`,`status`,`parent_id`) values (1,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:03:23','2015-05-02 21:03:23','FC0001','差旅补助','PU','',1,NULL),(2,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:03:28','2015-05-02 21:03:28','FC0002','住宿费','PU','',1,NULL),(3,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:03:45','2015-05-02 21:03:45','FC0003','市内交通费','PU','',1,NULL),(4,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:00','2015-05-02 21:04:00','FC0004','长途交通（大巴）费','PU','',1,NULL),(5,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:11','2015-05-02 21:04:11','FC0005','长途交通（火车）费','PU','',1,NULL),(6,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:22','2015-05-02 21:04:22','FC0006','机票费','PU','',1,NULL),(7,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:31','2015-05-02 21:04:31','FC0007','业务咨询费','PU','',1,NULL),(8,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:05:09','2015-05-02 21:05:09','FC0008','赞助费','PU','',1,NULL),(9,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:05:32','2015-05-02 21:05:32','FC0009','教育培训费','HR','',1,NULL),(10,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:05:55','2015-05-02 21:05:55','FC0010','集体活动费','HR','',1,NULL),(11,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:16','2015-05-02 21:06:16','FC0011','劳务外包费','HR','',1,NULL),(12,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:33','2015-05-02 21:06:33','FC0012','结婚礼金','HR','',1,NULL),(13,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:43','2015-05-02 21:06:43','FC0013','生育礼金','HR','',1,NULL),(14,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:54','2015-05-02 21:06:54','FC0014','丧葬抚恤','HR','',1,NULL),(15,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:07:08','2015-05-02 21:07:08','FC0015','独生子女费','HR','',1,NULL),(16,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:09:31','2015-05-02 21:09:31','FC0016','IT设备及服务费用','OF','',1,NULL),(17,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:09:48','2015-05-02 21:09:48','FC0017','通信及网络费用','OF','',1,NULL),(18,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:10:06','2015-05-02 21:10:06','FC0018','印刷品费用','OF','',1,NULL),(19,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:10:30','2015-05-02 21:10:30','FC0019','劳保用品费用','OF','',1,NULL),(20,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:10:58','2015-05-02 21:10:58','FC0020','办公用品费用','OF','',1,NULL),(21,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:11:32','2015-05-02 21:11:32','FC0021','车辆维修营运保养费','OF','',1,NULL),(22,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:12:00','2015-05-02 21:12:00','FC0022','固定资产购置修缮费','OF','',1,NULL),(23,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:13:39','2015-05-02 21:13:39','FC0023','运输费','MU','',1,NULL),(24,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:13:49','2015-05-02 21:13:49','FC0024','包装费','MU','',1,NULL),(25,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:14:08','2015-05-02 21:14:08','FC0025','设备维修费','MU','',1,NULL),(26,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:14:33','2015-05-02 21:14:33','FC0026','技术咨询费','MU','',1,NULL),(27,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:14:58','2015-05-02 21:14:58','FC0027','礼品费','BU','',1,NULL),(28,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:15:10','2015-05-02 21:15:10','FC0028','业务招待费','BU','',1,NULL),(29,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:15:25','2015-05-02 21:15:25','FC0029','广告费','BU','',1,NULL),(30,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:19:28','2015-05-02 21:19:28','FC0030','土地房屋设备租赁费','OF','',1,NULL),(31,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:20:46','2015-05-02 21:20:46','FC0031','诉讼费','PU','',1,NULL),(32,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:21:07','2015-05-02 21:21:07','FC0032','审计费','PU','',1,NULL),(33,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:22:52','2015-05-02 21:22:52','FC0033','商业保险费','PU','',1,NULL),(34,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:23:31','2015-05-02 21:23:31','FC0034','代理服务费','PU','',1,NULL),(35,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:26:27','2015-05-02 21:26:27','FC0035','其他不便归类的费用','OT','',1,NULL);

/*Table structure for table `basedata_extraparam` */

DROP TABLE IF EXISTS `basedata_extraparam`;

CREATE TABLE `basedata_extraparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `data_type` varchar(6) NOT NULL,
  `data_source` varchar(40) DEFAULT NULL,
  `material_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_extraparam_material_id_615a14c3_fk_basedata_material_id` (`material_id`),
  CONSTRAINT `basedata_extraparam_material_id_615a14c3_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_extraparam` */

insert  into `basedata_extraparam`(`id`,`name`,`data_type`,`data_source`,`material_id`) values (1,'出发日期','DATE','',1),(2,'预计返回日期','DATE','',1),(3,'目的地','CHAR','',1),(4,'起始地','CHAR','',3),(5,'目的地','CHAR','',3),(6,'里程','NUM','',3),(7,'出发时间','CHAR','',3);

/*Table structure for table `basedata_family` */

DROP TABLE IF EXISTS `basedata_family`;

CREATE TABLE `basedata_family` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `relation` varchar(2) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `name` varchar(60) NOT NULL,
  `birthday` date DEFAULT NULL,
  `organization` varchar(120) DEFAULT NULL,
  `phone` varchar(120) DEFAULT NULL,
  `emergency` tinyint(1) NOT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_family_employee_id_2c56437d_fk_basedata_employee_id` (`employee_id`),
  CONSTRAINT `basedata_family_employee_id_2c56437d_fk_basedata_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `basedata_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_family` */

insert  into `basedata_family`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`relation`,`status`,`name`,`birthday`,`organization`,`phone`,`emergency`,`employee_id`) values (1,NULL,NULL,NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','12','17','陆阳','1988-05-04','南京朗坤软件有限公司','13814050418',1,1),(2,NULL,NULL,NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','51','27','朱元泽','1957-05-04','务农','15035409224',0,1),(3,NULL,NULL,NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','52','27','张艮平','1959-05-04','务农','15035409224',0,1),(4,NULL,NULL,NULL,NULL,'2015-05-10 16:51:24','2015-05-10 16:51:24','11','13','朱国良','1985-02-05','亚信科技有限公司','13851668514',1,3);

/*Table structure for table `basedata_material` */

DROP TABLE IF EXISTS `basedata_material`;

CREATE TABLE `basedata_material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `barcode` varchar(40) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `spec` varchar(120) DEFAULT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `is_equip` tinyint(1) NOT NULL,
  `can_sale` tinyint(1) NOT NULL,
  `is_virtual` tinyint(1) NOT NULL,
  `stock_price` decimal(14,4) DEFAULT NULL,
  `purchase_price` decimal(14,4) DEFAULT NULL,
  `sale_price` decimal(14,4) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_material_brand_id_70cca220_fk_basedata_brand_id` (`brand_id`),
  KEY `basedata_material_category_id_7ca5506e_fk_basedata_category_id` (`category_id`),
  KEY `basedata_material_9744817e` (`warehouse_id`),
  CONSTRAINT `basedata_material_brand_id_70cca220_fk_basedata_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `basedata_brand` (`id`),
  CONSTRAINT `basedata_material_category_id_7ca5506e_fk_basedata_category_id` FOREIGN KEY (`category_id`) REFERENCES `basedata_category` (`id`),
  CONSTRAINT `basedata_material_warehouse_id_1e7533f6_fk_basedata_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `basedata_warehouse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_material` */

insert  into `basedata_material`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`barcode`,`name`,`spec`,`pinyin`,`status`,`is_equip`,`can_sale`,`is_virtual`,`stock_price`,`purchase_price`,`sale_price`,`brand_id`,`category_id`,`warehouse_id`) values (1,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 22:03:36','2015-05-22 22:10:34','IT00001','','出差申请','',NULL,1,0,0,1,NULL,NULL,NULL,NULL,1,2),(2,'2015-05-23','9999-12-31','zhugl',NULL,'2015-05-23 07:47:02','2015-05-23 07:47:02','IT00002','','戴尔（DELL）Inspiron 3455-R1248 灵越23.8英寸一体电脑 ','E2-7110 4G 500G WIFI 蓝牙 WIN8.1 3年上门',NULL,1,1,0,0,NULL,NULL,NULL,2,3,3),(3,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 15:13:47','2015-05-24 15:14:11','IT00003','','用车申请','',NULL,1,0,0,1,NULL,NULL,NULL,NULL,1,NULL);

/*Table structure for table `basedata_material_measure` */

DROP TABLE IF EXISTS `basedata_material_measure`;

CREATE TABLE `basedata_material_measure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `material_id` int(11) NOT NULL,
  `measure_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `material_id` (`material_id`,`measure_id`),
  KEY `basedata_material_mea_measure_id_5c0d90fc_fk_basedata_measure_id` (`measure_id`),
  CONSTRAINT `basedata_material_mea_measure_id_5c0d90fc_fk_basedata_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `basedata_measure` (`id`),
  CONSTRAINT `basedata_material_me_material_id_572f4c8_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_material_measure` */

insert  into `basedata_material_measure`(`id`,`material_id`,`measure_id`) values (4,1,8),(5,2,9),(7,3,8);

/*Table structure for table `basedata_materialparam` */

DROP TABLE IF EXISTS `basedata_materialparam`;

CREATE TABLE `basedata_materialparam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creation` date NOT NULL,
  `material_id` int(11) NOT NULL,
  `param_name_id` int(11),
  `param_value_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_materialpa_material_id_666e08d1_fk_basedata_material_id` (`material_id`),
  KEY `basedata_materialparam_996e5113` (`param_name_id`),
  KEY `basedata_materialparam_2f9b9c2f` (`param_value_id`),
  CONSTRAINT `basedata_materialpa_material_id_666e08d1_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `bas_param_name_id_3c50302d_fk_basedata_technicalparametername_id` FOREIGN KEY (`param_name_id`) REFERENCES `basedata_technicalparametername` (`id`),
  CONSTRAINT `b_param_value_id_18882fba_fk_basedata_technicalparametervalue_id` FOREIGN KEY (`param_value_id`) REFERENCES `basedata_technicalparametervalue` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_materialparam` */

/*Table structure for table `basedata_measure` */

DROP TABLE IF EXISTS `basedata_measure`;

CREATE TABLE `basedata_measure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_measure` */

insert  into `basedata_measure`(`id`,`code`,`name`,`status`) values (1,'ge','个',1),(2,'zhi','只',1),(3,'kg','千克',1),(4,'t','吨',1),(5,'g','克',1),(6,'gen','根',1),(7,'xi','箱',1),(8,'CI','次',1),(9,'TAI','台',1);

/*Table structure for table `basedata_partner` */

DROP TABLE IF EXISTS `basedata_partner`;

CREATE TABLE `basedata_partner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `short` varchar(20) DEFAULT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `partner_type` varchar(2) NOT NULL,
  `level` varchar(2) NOT NULL,
  `tax_num` varchar(40) DEFAULT NULL,
  `tax_address` varchar(40) DEFAULT NULL,
  `tax_account` varchar(80) DEFAULT NULL,
  `contacts` varchar(40),
  `memo` longtext,
  `phone` varchar(40),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_partner` */

insert  into `basedata_partner`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`partner_type`,`level`,`tax_num`,`tax_address`,`tax_account`,`contacts`,`memo`,`phone`) values (1,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 15:21:46','2015-05-01 15:21:46','90001','中国移动通信集团','','','C','A','','','',NULL,NULL,NULL);

/*Table structure for table `basedata_project` */

DROP TABLE IF EXISTS `basedata_project`;

CREATE TABLE `basedata_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `short` varchar(20) DEFAULT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `prj_type` varchar(2),
  `description` longtext,
  `budget` decimal(10,2) DEFAULT NULL,
  `income` decimal(10,2) DEFAULT NULL,
  `expand` decimal(10,2) DEFAULT NULL,
  `blueprint` varchar(100) DEFAULT NULL,
  `offer` varchar(100) DEFAULT NULL,
  `business` varchar(100) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_project_partner_id_36721156_fk_basedata_partner_id` (`partner_id`),
  CONSTRAINT `basedata_project_partner_id_36721156_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_project` */

insert  into `basedata_project`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`status`,`prj_type`,`description`,`budget`,`income`,`expand`,`blueprint`,`offer`,`business`,`partner_id`) values (1,'2015-05-02','9999-12-31','zhugl','zhugl','2015-05-02 09:48:49','2015-05-02 17:53:46','PJ0001','浦东机场2015年建设修补项目','','','00','10','',NULL,NULL,NULL,'','','',1),(2,'2015-05-23','9999-12-31','zhugl',NULL,'2015-05-23 20:47:55','2015-05-23 20:47:55','PJ0002','2015年设备维修项目','','','00','20','',NULL,NULL,NULL,'','','',NULL),(3,'2015-05-23','9999-12-31','zhugl',NULL,'2015-05-23 21:38:56','2015-05-23 21:38:56','PJ0003','2015年人事行政费用项目','','','00','00','',NULL,NULL,NULL,'','','',NULL);

/*Table structure for table `basedata_project_users` */

DROP TABLE IF EXISTS `basedata_project_users`;

CREATE TABLE `basedata_project_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `project_id` (`project_id`,`user_id`),
  KEY `basedata_project_users_user_id_2b10e1a1_fk_auth_user_id` (`user_id`),
  CONSTRAINT `basedata_project_users_project_id_1560ad8_fk_basedata_project_id` FOREIGN KEY (`project_id`) REFERENCES `basedata_project` (`id`),
  CONSTRAINT `basedata_project_users_user_id_2b10e1a1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_project_users` */

insert  into `basedata_project_users`(`id`,`project_id`,`user_id`) values (5,1,1);

/*Table structure for table `basedata_technicalparametername` */

DROP TABLE IF EXISTS `basedata_technicalparametername`;

CREATE TABLE `basedata_technicalparametername` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_technicalpa_category_id_8e419b4_fk_basedata_category_id` (`category_id`),
  CONSTRAINT `basedata_technicalpa_category_id_8e419b4_fk_basedata_category_id` FOREIGN KEY (`category_id`) REFERENCES `basedata_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_technicalparametername` */

/*Table structure for table `basedata_technicalparametervalue` */

DROP TABLE IF EXISTS `basedata_technicalparametervalue`;

CREATE TABLE `basedata_technicalparametervalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(80) NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `tech_name_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `base_tech_name_id_401b4baa_fk_basedata_technicalparametername_id` (`tech_name_id`),
  CONSTRAINT `base_tech_name_id_401b4baa_fk_basedata_technicalparametername_id` FOREIGN KEY (`tech_name_id`) REFERENCES `basedata_technicalparametername` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_technicalparametervalue` */

/*Table structure for table `basedata_trade` */

DROP TABLE IF EXISTS `basedata_trade`;

CREATE TABLE `basedata_trade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) NOT NULL,
  `name` varchar(120) NOT NULL,
  `memo` varchar(120) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_trade_parent_id_40eb4a8a_fk_basedata_trade_id` (`parent_id`),
  CONSTRAINT `basedata_trade_parent_id_40eb4a8a_fk_basedata_trade_id` FOREIGN KEY (`parent_id`) REFERENCES `basedata_trade` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_trade` */

insert  into `basedata_trade`(`id`,`code`,`name`,`memo`,`parent_id`) values (1,'A','农、林、牧、渔业','',NULL),(2,'B','采矿业','',NULL),(3,'C','制造业','',NULL),(4,'D','电力、燃气及水的生产和供应业','',NULL),(5,'E','建筑业','',NULL),(6,'F','交通运输、仓储和邮政业','',NULL),(7,'G','信息传输、计算机服务和软件业','',NULL),(8,'H','批发和零售业','',NULL),(9,'I','住宿和餐饮业','',NULL),(10,'J','金融业','',NULL),(11,'K','房地产业','',NULL),(12,'L','租赁和商务服务业','',NULL),(13,'M','科学研究、技术服务和地质勘查业','',NULL),(14,'N','水利、环境和公共设施管理业','',NULL),(15,'O','居民服务和其他服务业','',NULL),(16,'P','教育','',NULL),(17,'Q','卫生、社会保障和社会福利业','',NULL),(18,'R','文化、体育和娱乐业','',NULL),(19,'S','公共管理和社会组织','',NULL),(20,'T','国际组织','',NULL);

/*Table structure for table `basedata_valuelist` */

DROP TABLE IF EXISTS `basedata_valuelist`;

CREATE TABLE `basedata_valuelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `init` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `lock_time` datetime DEFAULT NULL,
  `locked_by_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_valuelist_module_id_249f4ef9_fk_syscfg_module_id` (`module_id`),
  KEY `basedata_valuelist_locked_by_id_3ddaefa_fk_auth_user_id` (`locked_by_id`),
  CONSTRAINT `basedata_valuelist_locked_by_id_3ddaefa_fk_auth_user_id` FOREIGN KEY (`locked_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `basedata_valuelist_module_id_249f4ef9_fk_syscfg_module_id` FOREIGN KEY (`module_id`) REFERENCES `syscfg_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_valuelist` */

insert  into `basedata_valuelist`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`status`,`init`,`locked`,`lock_time`,`locked_by_id`,`module_id`) values (10,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 09:58:32','2015-05-03 08:16:48','gender','性别',1,0,0,NULL,NULL,2),(11,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 10:31:10','2015-05-03 07:08:51','S011','地址类型',1,0,0,NULL,NULL,2),(12,'2015-05-02','9999-12-31','zhugl','zhugl','2015-05-02 10:00:30','2015-05-03 07:08:44','S012','项目状态',1,0,0,NULL,NULL,2),(13,'2015-05-02','9999-12-31','zhugl','zhugl','2015-05-02 10:03:27','2015-05-03 07:08:28','S013','项目类别',1,0,0,NULL,NULL,2),(14,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 06:49:41','2015-05-03 06:49:41','S014','岗位序列',1,0,0,NULL,NULL,2),(15,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 06:56:08','2015-05-09 15:41:55','S015','岗位级别',1,0,0,NULL,NULL,2),(16,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:13:31','2015-05-03 07:13:31','S016','人员状态',1,0,0,NULL,NULL,2),(17,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 07:19:43','2015-05-03 07:19:50','S017','职员级别',1,0,0,NULL,NULL,2),(18,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:22:10','2015-05-03 07:22:10','S018','人员类别',1,0,0,NULL,NULL,2),(19,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 07:24:00','2015-05-03 15:12:54','S019','用工形式',1,0,0,NULL,NULL,2),(20,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:33:41','2015-05-03 07:33:41','S020','宗教信仰',1,0,0,NULL,NULL,2),(21,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 07:42:12','2015-05-03 08:32:32','S021','民族',1,0,0,NULL,NULL,2),(22,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:54:20','2015-05-03 07:54:20','S022','国家',1,0,0,NULL,NULL,2),(23,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:00:47','2015-05-03 08:33:02','S023','婚姻状况',1,0,0,NULL,NULL,2),(24,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:11:20','2015-05-03 08:32:51','S024','文化程度',1,0,0,NULL,NULL,2),(25,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:26:49','2015-05-03 08:32:42','S025','家庭关系',1,0,0,NULL,NULL,2),(26,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:39:02','2015-05-03 08:43:11','S026','政治面貌',1,0,0,NULL,NULL,2),(27,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:41:44','2015-05-03 08:41:44','S027','兵役状况',1,0,0,NULL,NULL,2),(28,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:44:29','2015-05-03 08:44:29','S028','血型',1,0,0,NULL,NULL,2),(29,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:51:03','2015-05-03 08:51:03','S029','人员身份',1,0,0,NULL,NULL,2),(30,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:52:49','2015-05-03 08:52:49','S030','合同类型',1,0,0,NULL,NULL,2),(31,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:54:11','2015-05-03 08:54:19','S031','合同期限类型',1,0,0,NULL,NULL,2),(32,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:55:13','2015-05-03 08:56:32','S032','合同密级',1,0,0,NULL,NULL,2),(33,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:56:17','2015-05-03 08:56:17','S033','合同变动类型',1,0,0,NULL,NULL,2),(34,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:58:32','2015-05-03 08:58:32','S034','工时制度',1,0,0,NULL,NULL,2),(35,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 09:56:24','2015-05-03 09:56:24','S035','教育类型',1,0,0,NULL,NULL,2),(36,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 10:02:20','2015-05-03 10:02:38','S036','从学单位类别',1,0,0,NULL,NULL,2),(37,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 10:13:32','2015-05-03 10:16:48','S037','学位',1,0,0,NULL,NULL,2),(38,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 10:16:17','2015-05-03 10:17:06','S038','专业类别',1,0,0,NULL,NULL,2),(39,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 13:41:51','2015-05-03 13:41:51','S039','复转军人标识',1,0,0,NULL,NULL,2),(40,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 14:04:26','2015-05-03 14:07:50','S040','党委负责人标识',1,0,0,NULL,NULL,2),(41,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 14:07:37','2015-05-03 14:08:16','S041','董事监事标识',1,0,0,NULL,NULL,2),(42,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 14:14:35','2015-05-03 14:18:08','S042','特殊工种',1,0,0,NULL,NULL,2),(43,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 14:21:31','2015-05-03 14:21:31','S043','身体状况',1,0,0,NULL,NULL,2),(44,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 22:38:58','2015-05-25 20:58:34','S044','工单类型',1,0,0,NULL,NULL,2),(45,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 22:41:19','2015-05-25 20:26:41','S045','业务域',1,0,0,NULL,NULL,4),(46,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 22:44:49','2015-05-24 20:07:18','S046','工单状态',1,0,0,NULL,NULL,4),(47,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 20:04:37','2015-05-24 20:06:09','S047','试用期',1,1,1,NULL,NULL,3),(48,'2015-05-24','9999-12-31','zhugl',NULL,'2015-05-24 20:11:06','2015-05-24 20:11:06','S048','工资项类别',1,0,0,NULL,NULL,3),(49,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 20:13:08','2015-05-24 20:13:15','S049','增减属性',1,0,0,NULL,NULL,3),(50,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 20:20:10','2015-05-24 20:37:22','S050','计算方式',1,0,0,NULL,NULL,3),(51,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 21:32:21','2015-05-24 21:32:31','S051','离职类别',1,0,0,NULL,NULL,3);

/*Table structure for table `basedata_valuelistitem` */

DROP TABLE IF EXISTS `basedata_valuelistitem`;

CREATE TABLE `basedata_valuelistitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_code` varchar(6) DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `weight` int(11) DEFAULT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_valuelistitem_group_id_13b9f5f2_idx` (`group_id`,`group_code`),
  CONSTRAINT `basedata_valuelistite_group_id_435c66f8_fk_basedata_valuelist_id` FOREIGN KEY (`group_id`) REFERENCES `basedata_valuelist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_valuelistitem` */

insert  into `basedata_valuelistitem`(`id`,`group_code`,`code`,`name`,`status`,`weight`,`group_id`) values (13,'S011','01','送货地址',1,9,11),(14,'S011','02','发票地址',1,9,11),(15,'S011','03','临时地址',1,9,11),(16,'S011','04','家庭地址',0,9,11),(17,'S012','00','跟踪/新建',1,1,12),(18,'S012','01','投标/报价',1,2,12),(19,'S012','02','签订合同',1,3,12),(20,'S012','03','生产/交付',1,4,12),(21,'S012','04','验收/回款',1,5,12),(22,'S012','99','关闭',1,6,12),(23,'S013','00','产品/服务交付类',1,9,13),(24,'S013','10','技术/设备改造类',1,9,13),(25,'S013','20','内部运营类',1,9,13),(26,'S013','40','其他临时项目',1,9,13),(27,'S014','A','管理/行政类',1,9,14),(28,'S014','S','营销/市场类',1,9,14),(29,'S014','T','技术/研发类',1,9,14),(30,'S014','P','生产/操作类',1,9,14),(31,'S015','01','员级',1,9,15),(32,'S015','02','初级',1,9,15),(33,'S015','03','中级',1,9,15),(34,'S015','04','高级',1,9,15),(35,'S015','05','专家',1,9,15),(36,'S016','10','在岗工作',1,9,16),(37,'S016','11','见习期（试用）',1,9,16),(38,'S016','12','待岗',1,9,16),(39,'S016','20','离职',1,9,16),(40,'S016','21','退休',1,9,16),(41,'S016','22','终止劳动合同',1,9,16),(42,'S016','23','协商解除劳动合同',1,9,16),(43,'S016','24','劳动者主张解除劳动合同',1,9,16),(44,'S016','25','用人单位主张解除劳动合同',1,9,16),(45,'S016','30','死亡',1,9,16),(46,'S017','10','领导班子',1,9,17),(47,'S017','11','副总师（助理）',1,9,17),(48,'S017','12','部门负责人（正职）',1,9,17),(49,'S017','13','部门负责人（副职）',1,9,17),(50,'S017','14','部门内设机构负责人（正职）',1,9,17),(51,'S017','15','部门内设机构负责人（副职）',1,9,17),(52,'S017','20','一级职员',1,9,17),(53,'S017','21','二级职员',1,9,17),(54,'S017','22','三级职员',1,9,17),(55,'S017','23','四级职员',1,9,17),(56,'S017','24','五级职员',1,9,17),(57,'S017','25','六级职员',1,9,17),(58,'S017','26','七级职员',1,9,17),(59,'S017','27','八级职员',1,9,17),(60,'S018','10','经营者',1,9,18),(61,'S018','20','中层管理人员',1,9,18),(62,'S018','21','一般管理人员',1,9,18),(63,'S018','30','专业技术人员',1,9,18),(64,'S018','40','技能人员',1,9,18),(65,'S018','50','服务人员',1,9,18),(66,'S018','90','其他人员',1,9,18),(67,'S019','1','劳动合同制（长期）',1,9,19),(68,'S019','2','劳动合同制（短期）',1,9,19),(69,'S019','3','人事代理制',1,9,19),(70,'S019','4','劳务派遣制',1,9,19),(71,'S019','5','非全日制',1,9,19),(72,'S019','6','业务外包',1,9,19),(73,'S019','9','其他',1,9,19),(74,'S020','00','无宗教信仰',1,9,20),(75,'S020','10','佛教',1,9,20),(76,'S020','20','喇嘛教',1,9,20),(77,'S020','30','道教',1,9,20),(78,'S020','40','天主教',1,9,20),(79,'S020','50','基督教',1,9,20),(80,'S020','70','东正教',1,9,20),(81,'S020','80','伊斯兰教',1,9,20),(82,'S020','99','其他',1,9,20),(83,'S021','01','汉族',1,9,21),(84,'S021','02','蒙古族',1,9,21),(85,'S021','03','回族',1,9,21),(86,'S021','04','藏族',1,9,21),(87,'S021','05','维吾尔族',1,9,21),(88,'S021','06','苗族',1,9,21),(89,'S021','07','彝族',1,9,21),(90,'S021','08','壮族',1,9,21),(91,'S021','09','布依族',1,9,21),(92,'S021','10','朝鲜族',1,9,21),(93,'S021','11','满族',1,9,21),(94,'S022','CN','中国',1,9,22),(95,'S022','EG','埃及',1,9,22),(96,'S022','AT','奥地利',1,9,22),(97,'S022','AU','澳大利亚',1,9,22),(98,'S022','PK','巴基斯坦',1,9,22),(99,'S022','BR','巴西',1,9,22),(100,'S022','KP','北朝鲜',1,9,22),(101,'S022','BE','比利时',1,9,22),(102,'S022','IS','冰岛',1,9,22),(103,'S022','PL','波兰',1,9,22),(104,'S022','DK','丹麦',1,9,22),(105,'S022','DE','德国',1,9,22),(106,'S022','FR','法国',1,9,22),(107,'S022','KR','韩国',1,9,22),(108,'S022','NL','荷兰',1,9,22),(109,'S022','CA','加拿大',1,9,22),(110,'S022','US','美国',1,9,22),(111,'S022','JP','日本',1,9,22),(112,'S022','TW','中国台湾',1,9,22),(113,'S022','HK','中国香港',1,9,22),(114,'S022','ES','西班牙',1,9,22),(115,'S022','GR','希腊',1,9,22),(116,'S022','SG','新加坡',1,9,22),(117,'S022','NZ','新西兰',1,9,22),(118,'S022','IT','意大利',1,9,22),(119,'S022','GB','英国',1,9,22),(120,'S022','MO','中国澳门',1,9,22),(121,'S022','IL','以色列',1,9,22),(122,'S023','10','未婚',1,9,23),(123,'S023','20','初婚',1,9,23),(124,'S023','21','再婚',1,9,23),(125,'S023','22','复婚',1,9,23),(126,'S023','30','丧偶',1,9,23),(127,'S023','40','离婚',1,9,23),(128,'S023','90','其他',1,9,23),(129,'S024','0','研究生',1,9,24),(132,'S024','10','大学本科',1,9,24),(136,'S024','20','大学专科和专科学校',1,9,24),(144,'S024','40','技工学校',1,9,24),(146,'S024','50','高中',1,9,24),(147,'S024','60','初中',1,9,24),(148,'S024','70','小学',1,9,24),(149,'S024','80','文盲或半文盲',1,9,24),(150,'gender','0','未知的性别',1,9,10),(151,'gender','1','男性',1,9,10),(152,'gender','2','女性',1,9,10),(153,'gender','9','未说明的性别',1,9,10),(154,'S025','11','丈夫',1,9,25),(155,'S025','12','妻子',1,9,25),(156,'S025','21','独生子',1,9,25),(157,'S025','22','长子',1,9,25),(158,'S025','23','次子',1,9,25),(159,'S025','24','三子',1,9,25),(160,'S025','25','四子',1,9,25),(161,'S025','26','五子',1,9,25),(162,'S025','27','养子或继子',1,9,25),(163,'S025','28','女婿',1,9,25),(164,'S025','31','独生女',1,9,25),(165,'S025','32','长女',1,9,25),(166,'S025','33','次女',1,9,25),(167,'S025','34','三女',1,9,25),(168,'S025','35','四女',1,9,25),(169,'S025','36','五女',1,9,25),(170,'S025','37','养女或继女',1,9,25),(171,'S025','51','父亲',1,9,25),(172,'S025','52','母亲',1,9,25),(173,'S025','53','公公',1,9,25),(174,'S025','54','婆婆',1,9,25),(175,'S025','55','岳父',1,9,25),(176,'S025','56','岳母',1,9,25),(177,'S025','57','继父或养父',1,9,25),(178,'S025','58','继母或养母',1,9,25),(179,'S025','71','兄',1,9,25),(180,'S025','72','嫂',1,9,25),(181,'S025','73','弟',1,9,25),(182,'S025','74','弟媳',1,9,25),(183,'S025','75','姐姐',1,9,25),(184,'S025','76','姐夫',1,9,25),(185,'S025','77','妹妹',1,9,25),(186,'S025','78','妹夫',1,9,25),(187,'S026','01','中国共产党党员',1,9,26),(188,'S026','02','中国共产党预备党员',1,9,26),(189,'S026','03','中国共产主义青年团团员',1,9,26),(190,'S026','04','中国国民党革命委员会会员',1,9,26),(191,'S026','05','中国民主同盟盟员',1,9,26),(192,'S026','06','中国民主建国会会员',1,9,26),(193,'S026','07','中国民主促进会会员',1,9,26),(194,'S026','08','中国农工民主党党员',1,9,26),(195,'S026','09','中国致公党党员',1,9,26),(196,'S026','10','九三学社社员',1,9,26),(197,'S026','11','台湾民主自治同盟盟员',1,9,26),(198,'S026','12','无党派民主人士',1,9,26),(199,'S026','13','群众',1,9,26),(200,'S027','0','未服兵役',1,9,27),(201,'S027','1','退出现役',1,9,27),(202,'S027','2','士兵预备役',1,9,27),(203,'S027','3','军官预备役',1,9,27),(204,'S027','4','服现役',1,9,27),(205,'S027','9','其他',1,9,27),(206,'S028','0','不明',1,9,28),(207,'S028','1','A型',1,9,28),(208,'S028','2','B型',1,9,28),(209,'S028','3','O型',1,9,28),(210,'S028','4','AB型',1,9,28),(211,'S028','9','其他',1,9,28),(212,'S029','11','国家公务员',1,9,29),(213,'S029','13','专业技术人员',1,9,29),(214,'S029','17','职员',1,9,29),(215,'S029','21','企业管理人员',1,9,29),(216,'S029','24','工人',1,9,29),(217,'S029','27','农民',1,9,29),(218,'S029','31','学生',1,9,29),(219,'S029','37','现役军人',1,9,29),(220,'S029','51','自由职业者',1,9,29),(221,'S029','54','个人经营者',1,9,29),(222,'S029','70','无业人员',1,9,29),(223,'S029','80','退（离）休人员',1,9,29),(224,'S029','90','其他',1,9,29),(225,'S030','1','劳动合同',1,9,30),(226,'S030','2','岗位聘用合同',1,9,30),(227,'S030','3','聘任合同',1,9,30),(228,'S030','9','其他',1,9,30),(229,'S031','1','有固定期限',1,9,31),(230,'S031','2','无固定期限',1,9,31),(231,'S031','3','以任务为限',1,9,31),(232,'S031','9','其他',1,9,31),(233,'S032','1','严格保密',1,9,32),(234,'S032','2','需要保密',1,9,32),(235,'S032','3','无需保密',1,9,32),(236,'S033','01','初定',1,9,33),(237,'S033','02','续订',1,9,33),(238,'S033','03','变更',1,9,33),(239,'S033','04','终止',1,9,33),(240,'S033','05','解除',1,9,33),(241,'S034','1','定时',1,9,34),(242,'S034','2','不定时',1,9,34),(243,'S034','3','综合计算工时',1,9,34),(244,'S035','10','研究生教育',1,9,35),(245,'S035','20','大学本科教育',1,9,35),(246,'S035','30','大学专科教育',1,9,35),(247,'S035','40','中等职业教育',1,9,35),(248,'S035','60','普通高级中学教育',1,9,35),(249,'S035','70','初级中学教育',1,9,35),(250,'S035','80','小学教育',1,9,35),(251,'S035','90','其他',1,9,35),(252,'S035','99','非学历教育',1,9,35),(254,'S036','11','全日制小学',1,9,36),(255,'S036','12','全日制中学',1,9,36),(256,'S036','13','全日制中专',1,9,36),(257,'S036','14','全日制高等学校',1,9,36),(259,'S036','41','国家行政学院',1,9,36),(260,'S036','42','省行政学院',1,9,36),(261,'S036','49','其他行政学院（校）',1,9,36),(262,'S036','71','中央党校',1,9,36),(263,'S036','72','省委党校',1,9,36),(264,'S036','73','地、市委党校',1,9,36),(265,'S036','81','军队（武警）高等院校',1,9,36),(266,'S036','82','军队（武警）中等专科学校',1,9,36),(267,'S036','83','军队（武警）党校',1,9,36),(268,'S036','84','军队（武警）科研机构',1,9,36),(269,'S036','85','军队（武警）医院',1,9,36),(270,'S037','1','名誉博士 ',1,9,37),(271,'S037','2','博士',1,9,37),(272,'S037','3','硕士',1,9,37),(273,'S037','4','学士',1,9,37),(274,'S037','5','双学士',1,9,37),(275,'S038','01','哲学',1,9,38),(276,'S038','02','经济学',1,9,38),(277,'S038','03','法学',1,9,38),(278,'S038','04','教育学',1,9,38),(279,'S038','05','文学',1,9,38),(280,'S038','06','历史学',1,9,38),(281,'S038','07','理学',1,9,38),(282,'S038','08','工学',1,9,38),(283,'S038','09','农学',1,9,38),(284,'S038','10','医学',1,9,38),(285,'S038','11','军事学',1,9,38),(286,'S038','12','管理学',1,9,38),(287,'S038','14','建筑学',1,9,38),(288,'S037','9','其他',1,9,37),(289,'S038','99','其他',1,9,38),(290,'S039','15','复员干部',1,9,39),(291,'S039','10','军转干部',1,9,39),(292,'S039','20','转业士官',1,9,39),(293,'S039','30','复员士官',1,9,39),(294,'S039','40','退役士兵',1,9,39),(295,'S039','99','非复转军人',1,9,39),(296,'S040','1','党委（党组）书记',1,9,40),(297,'S040','2','党委（党组）副书记',1,9,40),(298,'S040','3','党委常委（党组成员）',1,9,40),(299,'S040','4','纪委书记（纪检组组长）',1,9,40),(300,'S040','6','工会主席',1,9,40),(301,'S040','8','其他党委（党组）负责人',1,9,40),(302,'S040','9','非党委负责人',1,9,40),(303,'S041','010101','董事长',1,9,41),(304,'S041','010102','副董事长',1,9,41),(305,'S041','010103','董事',1,9,41),(306,'S041','010104','职工董事',1,9,41),(307,'S041','0201','监事会主席',1,9,41),(308,'S041','0202','监事会副主席',1,9,41),(309,'S041','0203','监事',1,9,41),(310,'S041','0204','国资委派出监事',1,9,41),(311,'S041','0205','职工监事',1,9,41),(312,'S041','00','非董事监事',1,9,41),(313,'S042','00','非特殊工种',1,9,42),(314,'S042','11','汽机运行值班工',1,9,42),(315,'S042','12','锅炉运行值班工',1,9,42),(316,'S042','13','燃料运行值班工',1,9,42),(317,'S042','14','锅炉本体检修工',1,9,42),(318,'S042','15','保温工',1,9,42),(319,'S042','16','钢球磨煤机及制粉系统检修工',1,9,42),(320,'S042','17','水轮机检修工',1,9,42),(321,'S042','6','其他（由地方社会保障部门认可的特殊工种）',1,9,42),(322,'S042','21','锅炉本体安装工',1,9,42),(323,'S042','22','管道安装工',1,9,42),(324,'S042','23','筑炉瓦工',1,9,42),(325,'S042','24','装模工',1,9,42),(326,'S042','31','水轮机安装工',1,9,42),(327,'S042','32','采石工',1,9,42),(328,'S042','33','爆破',1,9,42),(329,'S042','34','石料粉碎工',1,9,42),(330,'S042','35','潜水员',1,9,42),(331,'S042','35','轮机工',1,9,42),(332,'S042','37','水手',1,9,42),(333,'S042','41','翻砂铸造工',1,9,42),(334,'S042','42','喷砂工',1,9,42),(335,'S042','43','镀锌工',1,9,42),(336,'S042','44','电镀工',1,9,42),(337,'S042','45','印刷线路制板工',1,9,42),(338,'S042','46','浸漆工',1,9,42),(339,'S042','47','电焊条制作工',1,9,42),(340,'S042','48','注塑工',1,9,42),(341,'S042','49','铆工',1,9,42),(342,'S042','51','混凝土工',1,9,42),(343,'S042','52','钢筋工',1,9,42),(344,'S042','53','架子工',1,9,42),(345,'S042','54','推土机司机',1,9,42),(346,'S042','55','挖土机司机',1,9,42),(347,'S042','56','重型载重汽车司机',1,9,42),(348,'S042','57','野外勘测工',1,9,42),(349,'S042','58','沥青工',1,9,42),(350,'S042','59','环氧树脂工',1,9,42),(351,'S043','1','健康或良好',1,9,43),(352,'S043','2','一般或较弱',1,9,43),(353,'S043','3','有慢性病（一）',1,9,43),(354,'S043','4','有慢性病（二）',1,9,43),(355,'S043','6','残疾',1,9,43),(356,'S043','7','军残',1,9,43),(357,'S044','S','内部服务',1,9,44),(358,'S044','R','设备维修',1,9,44),(359,'S044','Q','问题咨询',1,9,44),(360,'S045','HR','人事',1,1,45),(361,'S045','FI','财务',1,2,45),(362,'S045','AD','行政',1,4,45),(363,'S045','MA','市场',1,4,45),(364,'S045','BU','商务',1,5,45),(365,'S045','CS','客服',1,6,45),(366,'S045','OT','其他',1,7,45),(367,'S046','NEW','新建',1,9,46),(368,'S046','SCHE','调度',1,9,46),(369,'S046','PROC','处理',1,9,46),(370,'S046','CLOSE','关闭',1,9,46),(371,'S044','D','采购申请',1,9,44),(372,'S047','0','无试用期',1,1,47),(373,'S047','1','1个月',1,2,47),(374,'S047','2','2个月',1,2,47),(375,'S047','3','3个月',1,3,47),(376,'S047','4','4个月',1,4,47),(377,'S047','5','5个月',1,5,47),(378,'S047','6','6个月',1,6,47),(379,'S047','12','1年',1,12,47),(380,'S048','10','工资',1,9,48),(381,'S048','20','社保',1,9,48),(382,'S048','30','奖金',1,9,48),(383,'S048','40','福利',1,9,48),(384,'S048','99','其他',1,9,48),(385,'S049','+','增加',1,9,49),(386,'S049','-','扣款',1,9,49),(387,'S050','10','固定值',1,9,50),(388,'S050','20','比例值',1,9,50),(390,'S050','30','计算值',1,9,50),(391,'S051','10','个人辞职',1,9,51),(392,'S051','20','合同到期',1,9,51),(393,'S051','30','公司辞退',1,9,51),(394,'S051','40','人员死亡',1,9,51),(395,'S051','50','法定退休',1,9,51),(396,'S051','60','其他',1,9,51),(397,'S045','PO','采购',1,3,45);

/*Table structure for table `basedata_warehouse` */

DROP TABLE IF EXISTS `basedata_warehouse`;

CREATE TABLE `basedata_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `location` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_warehouse` */

insert  into `basedata_warehouse`(`id`,`code`,`name`,`status`,`location`) values (1,'A01','电力信息一号库',1,''),(2,'A02','内部运营服务',1,''),(3,'A03','办公用品仓库',1,'');

/*Table structure for table `basedata_warehouse_users` */

DROP TABLE IF EXISTS `basedata_warehouse_users`;

CREATE TABLE `basedata_warehouse_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `warehouse_id` (`warehouse_id`,`user_id`),
  KEY `basedata_warehouse_users_user_id_c95aacd_fk_auth_user_id` (`user_id`),
  CONSTRAINT `basedata_warehouse_users_user_id_c95aacd_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `basedata_warehous_warehouse_id_2b476168_fk_basedata_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `basedata_warehouse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_warehouse_users` */

/*Table structure for table `basedata_workexperience` */

DROP TABLE IF EXISTS `basedata_workexperience`;

CREATE TABLE `basedata_workexperience` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `organization` varchar(120) NOT NULL,
  `position` varchar(120) NOT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_workexperi_employee_id_1ccfb6d0_fk_basedata_employee_id` (`employee_id`),
  CONSTRAINT `basedata_workexperi_employee_id_1ccfb6d0_fk_basedata_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `basedata_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_workexperience` */

insert  into `basedata_workexperience`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`organization`,`position`,`employee_id`) values (1,'2008-07-01','2010-09-28',NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','南京朗坤软件有限公司','项目经理',1),(2,'2010-10-10','2012-01-10',NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','上海启腾电气股份有限公司','信息主管',1),(3,'2012-09-20','2014-01-13',NULL,NULL,'2015-05-04 22:22:18','2015-05-04 22:22:18','江苏电力信息技术有限公司','需求分析',1);

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin__content_type_id_5151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_1c5f563_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_1c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin__content_type_id_5151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=420 DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (1,'2015-05-01 07:30:01','1','系统管理',1,'',8,1),(2,'2015-05-01 07:30:19','1','模块管理',1,'',9,1),(3,'2015-05-01 07:30:32','2','菜单管理',1,'',9,1),(4,'2015-05-01 07:31:17','1','启腾控股集团',1,'',7,1),(5,'2015-05-01 07:31:46','1','职员',1,'',10,1),(6,'2015-05-01 07:31:55','1','职员',2,'已修改 status 。',10,1),(7,'2015-05-01 07:51:45','2','基础数据',1,'',8,1),(8,'2015-05-01 07:52:20','3','角色管理',1,'',9,1),(9,'2015-05-01 09:31:25','1','性别',1,'',11,1),(10,'2015-05-01 09:31:59','1','性别',2,'已添加 list item \"ValueListItem object\". 已添加 list item \"ValueListItem object\".',11,1),(11,'2015-05-01 09:42:07','6','test',1,'',11,1),(12,'2015-05-01 09:43:45','6','test',3,'',11,1),(13,'2015-05-01 09:43:55','7','test',1,'',11,1),(14,'2015-05-01 09:44:34','7','test',3,'',11,1),(15,'2015-05-01 09:44:45','8','test',1,'',11,1),(16,'2015-05-01 09:51:55','8','test2',2,'已修改 name 。',11,1),(17,'2015-05-01 09:57:13','8','test2',3,'',11,1),(18,'2015-05-01 09:57:21','9','test',1,'',11,1),(19,'2015-05-01 09:57:43','1','性别',2,'已修改 init 。',11,1),(20,'2015-05-01 09:58:03','9','test',3,'',11,1),(21,'2015-05-01 09:58:03','1','性别',3,'',11,1),(22,'2015-05-01 09:58:32','10','性别',1,'',11,1),(23,'2015-05-01 10:00:45','10','性别2',2,'已修改 name 。',11,1),(24,'2015-05-01 10:03:06','10','性别3',2,'已修改 name 。',11,1),(25,'2015-05-01 10:03:14','10','性别4',2,'已修改 name 。',11,1),(26,'2015-05-01 10:03:37','10','性别4',2,'已修改 code 。',11,1),(27,'2015-05-01 10:15:20','10','性别',2,'已修改 code 和 name 。',11,1),(28,'2015-05-01 10:31:10','11','地址类型',1,'',11,1),(29,'2015-05-01 10:55:26','1',' ',1,'',13,1),(30,'2015-05-01 15:21:46','1','中国移动通信集团',1,'',14,1),(31,'2015-05-01 20:26:05','1','启腾控股集团',1,'',16,1),(32,'2015-05-01 20:26:20','1','启腾控股集团',2,'已修改 represent 。',16,1),(33,'2015-05-01 20:27:41','1','董事会',1,'',17,1),(34,'2015-05-01 20:27:55','2','集团财务部',1,'',17,1),(35,'2015-05-01 20:28:12','3','人事行政部',1,'',17,1),(36,'2015-05-01 20:29:49','4','人事部',1,'',17,1),(37,'2015-05-01 20:33:18','5','行政部',1,'',17,1),(38,'2015-05-01 20:34:06','5','行政部',2,'已修改 unit_type 。',17,1),(39,'2015-05-01 20:37:19','1','董事长',1,'',18,1),(40,'2015-05-01 20:38:26','1','董事长',2,'已修改 grade 。',18,1),(41,'2015-05-01 20:39:12','1','董事长',2,'已修改 unit 。',18,1),(42,'2015-05-01 20:47:51','2','董事长',1,'',18,1),(43,'2015-05-01 20:48:05','2','董事长',2,'已修改 grade 。',18,1),(44,'2015-05-01 21:06:40','1','上海机场（集团）有限公司',2,'已修改 name，short，pinyin，tax_num，tax_account，tax_address，represent，email，address，zipcode，contacts，phone，fax，website，lic_code 和 cer_code 。',16,1),(45,'2015-05-02 08:52:25','11','地址类型',2,'已变更 status for 列表项 \"04-家庭地址\".',11,1),(46,'2015-05-02 09:48:49','1','浦东机场2015年建设修补项目',1,'',19,1),(47,'2015-05-02 09:49:01','1','浦东机场2015年建设修补项目',2,'已修改 users 。',19,1),(48,'2015-05-02 10:00:30','12','项目状态',1,'',11,1),(49,'2015-05-02 10:03:27','13','项目类别',1,'',11,1),(50,'2015-05-02 10:05:06','1','浦东机场2015年建设修补项目',2,'已修改 prj_type 。',19,1),(51,'2015-05-02 10:06:24','1','浦东机场2015年建设修补项目',2,'已修改 partner 。',19,1),(52,'2015-05-02 13:32:00','1','Measure object',1,'',21,1),(53,'2015-05-02 13:32:11','2','Measure object',1,'',21,1),(54,'2015-05-02 13:32:18','3','Measure object',1,'',21,1),(55,'2015-05-02 13:32:23','4','Measure object',1,'',21,1),(56,'2015-05-02 13:32:31','5','Measure object',1,'',21,1),(57,'2015-05-02 13:32:39','6','Measure object',1,'',21,1),(58,'2015-05-02 13:32:59','7','Measure object',1,'',21,1),(59,'2015-05-02 14:01:22','1','LENOVO-联想',1,'',23,1),(60,'2015-05-02 17:16:53','1','电力信息一号库',1,'',20,1),(61,'2015-05-02 17:17:20','1','物料分类',1,'',24,1),(62,'2015-05-02 17:17:54','2','生产物资',1,'',24,1),(63,'2015-05-02 17:18:11','3','办公物资',1,'',24,1),(64,'2015-05-02 17:23:10','3','办公物资',3,'',24,1),(65,'2015-05-02 17:23:11','2','生产物资',3,'',24,1),(66,'2015-05-02 17:23:41','4','生产物资',1,'',24,1),(67,'2015-05-02 17:24:11','5','元器件',1,'',24,1),(68,'2015-05-02 17:24:23','6','开关设备',1,'',24,1),(69,'2015-05-02 17:25:55','7','IT物资',1,'',24,1),(70,'2015-05-02 17:26:08','8','办公物资',1,'',24,1),(71,'2015-05-02 17:26:30','9','路由器',1,'',24,1),(72,'2015-05-02 17:26:39','10','交换机',1,'',24,1),(73,'2015-05-02 17:26:58','11','信息安全设备',1,'',24,1),(74,'2015-05-02 17:27:33','12','台式机',1,'',24,1),(75,'2015-05-02 17:27:40','13','笔记本',1,'',24,1),(76,'2015-05-02 17:33:19','1','显示器尺寸',1,'',25,1),(77,'2015-05-02 17:50:04','1','浦东机场2015年建设修补项目',2,'已修改 blueprint，offer 和 business 。',19,1),(78,'2015-05-02 17:53:46','1','浦东机场2015年建设修补项目',2,'已修改 blueprint，offer 和 business 。',19,1),(79,'2015-05-02 17:59:37','1','农、林、牧、渔业',1,'',22,1),(80,'2015-05-02 17:59:51','2','采矿业',1,'',22,1),(81,'2015-05-02 18:00:06','3','制造业',1,'',22,1),(82,'2015-05-02 18:00:55','4','电力、燃气及水的生产和供应业',1,'',22,1),(83,'2015-05-02 18:01:10','5','建筑业',1,'',22,1),(84,'2015-05-02 18:01:21','6','交通运输、仓储和邮政业',1,'',22,1),(85,'2015-05-02 18:01:35','7','信息传输、计算机服务和软件业',1,'',22,1),(86,'2015-05-02 18:01:49','8','批发和零售业',1,'',22,1),(87,'2015-05-02 18:02:09','9','住宿和餐饮业',1,'',22,1),(88,'2015-05-02 18:02:22','10','金融业',1,'',22,1),(89,'2015-05-02 18:02:39','11','房地产业',1,'',22,1),(90,'2015-05-02 18:02:50','12','租赁和商务服务业',1,'',22,1),(91,'2015-05-02 18:03:11','13','科学研究、技术服务和地质勘查业',1,'',22,1),(92,'2015-05-02 18:03:29','14','水利、环境和公共设施管理业',1,'',22,1),(93,'2015-05-02 18:03:40','15','居民服务和其他服务业',1,'',22,1),(94,'2015-05-02 18:03:56','16','教育',1,'',22,1),(95,'2015-05-02 18:04:14','17','卫生、社会保障和社会福利业',1,'',22,1),(96,'2015-05-02 18:04:27','18','文化、体育和娱乐业',1,'',22,1),(97,'2015-05-02 18:04:48','19','公共管理和社会组织',1,'',22,1),(98,'2015-05-02 18:06:14','20','国际组织',1,'',22,1),(99,'2015-05-02 18:09:37','1','DELL 笔记本',1,'',27,1),(100,'2015-05-02 18:10:07','1','DELL 笔记本',2,'已修改 category 。',27,1),(101,'2015-05-02 18:10:39','2','DELL',1,'',23,1),(102,'2015-05-02 18:10:43','1','DELL 笔记本',2,'已修改 brand 。',27,1),(103,'2015-05-02 18:12:24','2','联想（Lenovo）小新V2000 Bigger版 ',1,'',27,1),(104,'2015-05-02 21:03:23','1','差旅补助',1,'',29,1),(105,'2015-05-02 21:03:28','2','住宿费',1,'',29,1),(106,'2015-05-02 21:03:45','3','市内交通费',1,'',29,1),(107,'2015-05-02 21:04:00','4','长途交通（大巴）费',1,'',29,1),(108,'2015-05-02 21:04:11','5','长途交通（火车）费',1,'',29,1),(109,'2015-05-02 21:04:22','6','机票费',1,'',29,1),(110,'2015-05-02 21:04:31','7','业务咨询费',1,'',29,1),(111,'2015-05-02 21:05:09','8','赞助费',1,'',29,1),(112,'2015-05-02 21:05:32','9','教育培训费',1,'',29,1),(113,'2015-05-02 21:05:55','10','集体活动费',1,'',29,1),(114,'2015-05-02 21:06:16','11','劳务外包费',1,'',29,1),(115,'2015-05-02 21:06:33','12','结婚礼金',1,'',29,1),(116,'2015-05-02 21:06:43','13','生育礼金',1,'',29,1),(117,'2015-05-02 21:06:54','14','丧葬抚恤',1,'',29,1),(118,'2015-05-02 21:07:08','15','独生子女费',1,'',29,1),(119,'2015-05-02 21:09:31','16','IT设备及服务费用',1,'',29,1),(120,'2015-05-02 21:09:48','17','通信及网络费用',1,'',29,1),(121,'2015-05-02 21:10:06','18','印刷品费用',1,'',29,1),(122,'2015-05-02 21:10:30','19','劳保用品费用',1,'',29,1),(123,'2015-05-02 21:10:58','20','办公用品费用',1,'',29,1),(124,'2015-05-02 21:11:32','21','车辆维修营运保养费',1,'',29,1),(125,'2015-05-02 21:12:00','22','固定资产购置修缮费',1,'',29,1),(126,'2015-05-02 21:13:39','23','运输费',1,'',29,1),(127,'2015-05-02 21:13:49','24','包装费',1,'',29,1),(128,'2015-05-02 21:14:08','25','设备维修费',1,'',29,1),(129,'2015-05-02 21:14:33','26','技术咨询费',1,'',29,1),(130,'2015-05-02 21:14:58','27','礼品费',1,'',29,1),(131,'2015-05-02 21:15:10','28','业务招待费',1,'',29,1),(132,'2015-05-02 21:15:25','29','广告费',1,'',29,1),(133,'2015-05-02 21:19:28','30','土地房屋设备租赁费',1,'',29,1),(134,'2015-05-02 21:20:46','31','诉讼费',1,'',29,1),(135,'2015-05-02 21:21:07','32','审计费',1,'',29,1),(136,'2015-05-02 21:22:52','33','商业保险费',1,'',29,1),(137,'2015-05-02 21:23:31','34','代理服务费',1,'',29,1),(138,'2015-05-02 21:26:27','35','其他不便归类的费用',1,'',29,1),(139,'2015-05-03 06:49:41','14','岗位序列',1,'',11,1),(140,'2015-05-03 06:56:08','15','岗位级别',1,'',11,1),(141,'2015-05-03 07:08:28','13','项目类别',2,'已修改 module 。',11,1),(142,'2015-05-03 07:08:36','15','岗位级别',2,'已修改 module 。',11,1),(143,'2015-05-03 07:08:44','12','项目状态',2,'已修改 module 。',11,1),(144,'2015-05-03 07:08:51','11','地址类型',2,'已修改 module 。',11,1),(145,'2015-05-03 07:08:59','10','性别',2,'已修改 module 。',11,1),(146,'2015-05-03 07:13:31','16','人员状态',1,'',11,1),(147,'2015-05-03 07:19:43','17','职员级别',1,'',11,1),(148,'2015-05-03 07:19:50','17','职员级别',2,'已修改 module 。',11,1),(149,'2015-05-03 07:22:10','18','人员类别',1,'',11,1),(150,'2015-05-03 07:24:00','19','用工形式',1,'',11,1),(151,'2015-05-03 07:33:41','20','宗教信仰',1,'',11,1),(152,'2015-05-03 07:42:12','21','民族',1,'',11,1),(153,'2015-05-03 07:43:22','21','民族',2,'已添加 列表项 \"09-布依族\". 已添加 列表项 \"10-朝鲜族\". 已添加 列表项 \"11-满族\".',11,1),(154,'2015-05-03 07:54:20','22','国家',1,'',11,1),(155,'2015-05-03 08:00:47','23','婚姻状况',1,'',11,1),(156,'2015-05-03 08:11:20','24','文化程度',1,'',11,1),(157,'2015-05-03 08:13:18','24','文化程度',2,'已添加 列表项 \"50-高中\". 已添加 列表项 \"60-初中\". 已添加 列表项 \"70-小学\". 已添加 列表项 \"80-文盲或半文盲\".',11,1),(158,'2015-05-03 08:14:10','24','文化程度',2,'已删除 列表项 \"1-研究生毕业\". 已删除 列表项 \"11-大学毕业\". 已删除 列表项 \"18-相当大学毕业\". 已删除 列表项 \"19-大学肄业\". 已删除 列表项 \"21-专科毕业\". 已删除 列表项 \"29-专科肄业\". 已删除 列表项 \"30-中等专业学校或中等技术学校\". 已删除 列表项 \"31-中专毕业\". 已删除 列表项 \"32-中技毕业\". 已删除 列表项 \"38-相当中专或中技毕业\". 已删除 列表项 \"39-中专或中技肄业\". 已删除 列表项 \"41-技工学校毕业\".',11,1),(159,'2015-05-03 08:14:20','24','文化程度',2,'已删除 列表项 \"9-研究生肄业\".',11,1),(160,'2015-05-03 08:16:00','10','性别',2,'已删除 列表项 \"F-女\". 已删除 列表项 \"M-男\".',11,1),(161,'2015-05-03 08:16:48','10','性别',2,'已添加 列表项 \"0-未知的性别\". 已添加 列表项 \"1-男性\". 已添加 列表项 \"2-女性\". 已添加 列表项 \"9-未说明的性别\".',11,1),(162,'2015-05-03 08:26:49','25','家庭关系',1,'',11,1),(163,'2015-05-03 08:31:20','25','家庭关系',2,'已添加 列表项 \"51-父亲\". 已添加 列表项 \"52-母亲\". 已添加 列表项 \"53-公公\". 已添加 列表项 \"54-婆婆\". 已添加 列表项 \"55-岳父\". 已添加 列表项 \"56-岳母\". 已添加 列表项 \"57-继父或养父\". 已添加 列表项 \"58-继母或养母\". 已添加 列表项 \"71-兄\". 已添加 列表项 \"72-嫂\". 已添加 列表项 \"73-弟\". 已添加 列表项 \"74-弟媳\". 已添加 列表项 \"75-姐姐\". 已添加 列表项 \"76-姐夫\". 已添加 列表项 \"77-妹妹\". 已添加 列表项 \"78-妹夫\".',11,1),(164,'2015-05-03 08:32:32','21','民族',2,'已修改 module 。',11,1),(165,'2015-05-03 08:32:42','25','家庭关系',2,'已修改 module 。',11,1),(166,'2015-05-03 08:32:51','24','文化程度',2,'已修改 module 。',11,1),(167,'2015-05-03 08:33:02','23','婚姻状况',2,'已修改 module 。',11,1),(168,'2015-05-03 08:39:02','26','政治面貌',1,'',11,1),(169,'2015-05-03 08:41:44','27','兵役状况',1,'',11,1),(170,'2015-05-03 08:43:11','26','政治面貌',2,'已修改 module 。',11,1),(171,'2015-05-03 08:44:29','28','血型',1,'',11,1),(172,'2015-05-03 08:51:03','29','人员身份',1,'',11,1),(173,'2015-05-03 08:52:49','30','合同类型',1,'',11,1),(174,'2015-05-03 08:54:11','31','合同期限类型',1,'',11,1),(175,'2015-05-03 08:54:19','31','合同期限类型',2,'已修改 module 。',11,1),(176,'2015-05-03 08:55:13','32','合同密级',1,'',11,1),(177,'2015-05-03 08:56:17','33','合同变动类型',1,'',11,1),(178,'2015-05-03 08:56:32','32','合同密级',2,'已修改 module 。',11,1),(179,'2015-05-03 08:58:32','34','工时制度',1,'',11,1),(180,'2015-05-03 09:56:24','35','教育类型',1,'',11,1),(181,'2015-05-03 10:02:20','36','从学单位类别',1,'',11,1),(182,'2015-05-03 10:02:30','36','从学单位类别',2,'已删除 列表项 \"1-全日制学校\". 已删除 列表项 \"2-成人教育培训机构\".',11,1),(183,'2015-05-03 10:02:38','36','从学单位类别',2,'已修改 module 。',11,1),(184,'2015-05-03 10:13:32','37','学位',1,'',11,1),(185,'2015-05-03 10:16:17','38','专业类别',1,'',11,1),(186,'2015-05-03 10:16:48','37','学位',2,'已添加 列表项 \"9-其他\".',11,1),(187,'2015-05-03 10:17:06','38','专业类别',2,'已添加 列表项 \"99-其他\".',11,1),(188,'2015-05-03 13:41:51','39','复转军人标识',1,'',11,1),(189,'2015-05-03 14:04:26','40','党委负责人标识',1,'',11,1),(190,'2015-05-03 14:07:37','41','董事监事标识',1,'',11,1),(191,'2015-05-03 14:07:50','40','党委负责人标识',2,'已修改 module 。',11,1),(192,'2015-05-03 14:08:16','41','董事监事标识',2,'已添加 列表项 \"00-非董事监事\".',11,1),(193,'2015-05-03 14:14:35','42','特殊工种',1,'',11,1),(194,'2015-05-03 14:18:08','42','特殊工种',2,'已添加 列表项 \"41-翻砂铸造工\". 已添加 列表项 \"42-喷砂工\". 已添加 列表项 \"43-镀锌工\". 已添加 列表项 \"44-电镀工\". 已添加 列表项 \"45-印刷线路制板工\". 已添加 列表项 \"46-浸漆工\". 已添加 列表项 \"47-电焊条制作工\". 已添加 列表项 \"48-注塑工\". 已添加 列表项 \"49-铆工\". 已添加 列表项 \"51-混凝土工\". 已添加 列表项 \"52-钢筋工\". 已添加 列表项 \"53-架子工\". 已添加 列表项 \"54-推土机司机\". 已添加 列表项 \"55-挖土机司机\". 已添加 列表项 \"56-重型载重汽车司机\". 已添加 列表项 \"57-野外勘测工\". 已添加 列表项 \"58-沥青工\". 已添加 列表项 \"59-环氧树脂工\".',11,1),(195,'2015-05-03 14:21:31','43','身体状况',1,'',11,1),(196,'2015-05-03 15:12:54','19','用工形式',2,'已变更 name for 列表项 \"2-劳动合同制（短期）\".',11,1),(197,'2015-05-03 15:38:58','1','朱国良',1,'',30,1),(198,'2015-05-03 15:46:16','1','朱国良',2,'已修改 startday 。',30,1),(199,'2015-05-03 15:50:00','3','人事经理',1,'',18,1),(200,'2015-05-03 15:50:13','1','朱国良',2,'已修改 position 。',30,1),(201,'2015-05-04 22:22:18','1','朱国良',2,'已添加 家庭成员 \"陆阳\". 已添加 家庭成员 \"朱元泽\". 已添加 家庭成员 \"张艮平\". 已添加 教育履历 \" \". 已添加 教育履历 \" \". 已添加 教育履历 \" \". 已添加 工作履历 \" \". 已添加 工作履历 \" \". 已添加 工作履历 \" \".',30,1),(202,'2015-05-09 08:52:57','3','新员工入职',1,'',34,1),(203,'2015-05-09 08:58:16','1','N01-人事专员',2,'已修改 next 。',35,1),(204,'2015-05-09 08:58:53','3','N03-薪酬专员',2,'已修改 next 。',35,1),(205,'2015-05-09 08:59:07','4','N04-人事经理',2,'已修改 next 。',35,1),(206,'2015-05-09 09:00:44','1','N01-人事专员',2,'已修改 next 。',35,1),(207,'2015-05-09 09:00:53','3','N03-薪酬专员',2,'已修改 next 。',35,1),(208,'2015-05-09 09:01:02','4','N04-人事经理',2,'已修改 next 。',35,1),(209,'2015-05-09 09:01:14','4','N04-人事经理',2,'已修改 next 。',35,1),(210,'2015-05-09 09:01:21','3','N03-薪酬专员',2,'已修改 next 。',35,1),(211,'2015-05-09 09:01:30','2','N02-合同专员',2,'已修改 next 。',35,1),(212,'2015-05-09 09:01:40','1','N01-人事专员',2,'已修改 next 。',35,1),(213,'2015-05-09 09:03:53','4','合作伙伴审批',1,'',34,1),(214,'2015-05-09 09:12:50','2','N02-合同专员',2,'已修改 next 。',35,1),(215,'2015-05-09 09:12:55','5','N05-总经理',2,'已修改 next 。',35,1),(216,'2015-05-09 09:13:05','3','N03-薪酬专员',2,'已修改 next 。',35,1),(217,'2015-05-09 09:13:21','1','N01-人事专员',2,'已修改 next 。',35,1),(218,'2015-05-09 09:32:42','1','N01-人事专员',2,'已修改 next 。',35,1),(219,'2015-05-09 09:32:56','2','N02-合同专员',2,'已修改 next 。',35,1),(220,'2015-05-09 09:33:07','3','N03-薪酬专员',2,'已修改 next 。',35,1),(221,'2015-05-09 09:33:12','4','N04-人事经理',2,'已修改 next 。',35,1),(222,'2015-05-09 09:33:29','6','N01-商务主管审批',2,'已修改 next 。',35,1),(223,'2015-05-09 09:33:54','7','N02-营销总监审批',2,'已修改 next 。',35,1),(224,'2015-05-09 09:34:06','8','N03-总经理审批',2,'已修改 next 。',35,1),(225,'2015-05-09 09:57:21','4','合作伙伴审批',2,'已修改 description 。',34,1),(226,'2015-05-09 09:58:36','4','合作伙伴审批',2,'已修改 description 。',34,1),(227,'2015-05-09 10:00:03','3','新员工入职',2,'已修改 description 。',34,1),(228,'2015-05-09 15:41:55','15','岗位级别',2,'已变更 name for 列表项 \"01-员级\". 已变更 name for 列表项 \"02-初级\". 已变更 name for 列表项 \"03-中级\". 已变更 name for 列表项 \"04-高级\". 已变更 name for 列表项 \"05-专家\".',11,1),(229,'2015-05-10 07:05:46','1','合伙伙伴备案审批',1,'',34,1),(230,'2015-05-10 07:18:55','2','新员工入职流程',1,'',34,1),(231,'2015-05-10 07:19:07','1','合伙伙伴审批流程',2,'已修改 name 。',34,1),(232,'2015-05-10 07:19:25','2','新员工入职流程',2,'已修改 end 。',34,1),(233,'2015-05-10 07:32:46','2','新员工入职流程',2,'已添加 工作流节点 \"N01-合同专员\". 已添加 工作流节点 \"N02-薪酬专员\". 已添加 工作流节点 \"N03-人事经理\". 已添加 工作流节点 \"N04-总经理\".',34,1),(234,'2015-05-10 07:33:37','1','合伙伙伴审批流程',2,'已添加 工作流节点 \"N01-商务主管审批\". 已添加 工作流节点 \"N02-营销总监审批\". 已添加 工作流节点 \"N03-总经理审批\". 已添加 工作流节点 \"N04-客服部备案\".',34,1),(235,'2015-05-10 07:33:51','1','合伙伙伴审批流程',2,'已修改 end 。',34,1),(236,'2015-05-10 07:34:38','1','N01-合同专员',2,'已修改 next 。',35,1),(237,'2015-05-10 07:34:49','4','N04-总经理',2,'已修改 stop 和 approve_node 。',35,1),(238,'2015-05-10 07:35:02','3','N03-人事经理',2,'已修改 next 。',35,1),(239,'2015-05-10 07:35:11','2','N02-薪酬专员',2,'已修改 next 。',35,1),(240,'2015-05-10 08:33:44','1','合伙伙伴审批流程',2,'已修改 begin 和 end 。',34,1),(241,'2015-05-10 08:44:42','1','合伙伙伴审批流程',2,'已修改 end 。',34,1),(242,'2015-05-10 09:22:03','5','N01-商务主管审批',2,'已修改 handler 。',35,1),(243,'2015-05-10 11:50:32','4','N04-总经理',2,'没有字段被修改。',35,1),(244,'2015-05-10 12:19:39','1','新员工入职流程',1,'',34,1),(245,'2015-05-10 16:36:06','2','luy',1,'',4,1),(246,'2015-05-10 16:36:33','2','luy',2,'已修改 first_name，last_name 和 is_staff 。',4,1),(247,'2015-05-10 16:36:48','1','zhugl',2,'已修改 first_name，last_name 和 last_login 。',4,1),(248,'2015-05-10 16:37:06','2','luy',2,'已修改 email 。',4,1),(249,'2015-05-10 16:38:30','1','职员',2,'已修改 users 。',10,1),(250,'2015-05-10 16:45:01','2','陆阳',1,'',30,1),(251,'2015-05-10 16:45:33','3','陆阳',1,'',30,1),(252,'2015-05-10 16:47:38','2','陆阳',3,'',30,1),(253,'2015-05-10 16:49:49','3','陆阳',2,'已修改 phone 。',30,1),(254,'2015-05-10 16:51:24','3','陆阳',2,'已添加 家庭成员 \"朱国良\".',30,1),(255,'2015-05-10 16:51:55','3','人事经理',2,'已修改 parent 。',18,1),(256,'2015-05-10 16:53:23','1','职员',2,'已修改 status 。',10,1),(257,'2015-05-10 17:00:39','1','朱国良',2,'已修改 user 。',30,1),(258,'2015-05-10 17:00:47','3','陆阳',2,'已修改 rank 和 user 。',30,1),(259,'2015-05-10 17:02:09','1','职员',1,'',3,1),(260,'2015-05-10 17:02:25','2','luy',2,'已修改 groups 。',4,1),(261,'2015-05-10 17:04:41','3','陆阳',2,'已修改 email 。',30,2),(262,'2015-05-10 17:16:23','1','N01-合同专员',2,'已修改 next，users，positions 和 roles 。',35,1),(263,'2015-05-10 17:16:45','1','N01-合同专员',2,'已修改 departments 。',35,1),(264,'2015-05-10 20:23:14','2','ceshi',1,'',20,1),(265,'2015-05-10 20:23:30','2','ceshi',3,'',20,1),(266,'2015-05-10 20:27:50','3','test',1,'',20,1),(267,'2015-05-10 20:27:55','3','test',3,'',20,1),(268,'2015-05-13 21:10:09','13','笔记本',3,'',24,1),(269,'2015-05-13 21:10:09','12','台式机',3,'',24,1),(270,'2015-05-13 21:10:09','11','信息安全设备',3,'',24,1),(271,'2015-05-13 21:10:09','10','交换机',3,'',24,1),(272,'2015-05-13 21:10:09','9','路由器',3,'',24,1),(273,'2015-05-13 21:10:09','8','办公物资',3,'',24,1),(274,'2015-05-13 21:10:09','7','IT物资',3,'',24,1),(275,'2015-05-13 21:10:09','6','开关设备',3,'',24,1),(276,'2015-05-13 21:10:09','5','元器件',3,'',24,1),(277,'2015-05-13 21:10:09','4','生产物资',3,'',24,1),(278,'2015-05-13 21:10:09','1','物料分类',3,'',24,1),(279,'2015-05-13 21:26:12','3','TodoList object',2,'没有字段被修改。',38,1),(280,'2015-05-13 21:26:16','1','TodoList object',2,'没有字段被修改。',38,1),(281,'2015-05-13 21:26:20','4','TodoList object',2,'没有字段被修改。',38,1),(282,'2015-05-13 21:26:22','2','TodoList object',2,'没有字段被修改。',38,1),(283,'2015-05-16 17:57:31','1','职员',2,'已修改 permissions 。',3,1),(284,'2015-05-16 18:31:01','2','人事',1,'',3,1),(285,'2015-05-16 18:31:16','2','luy',2,'已修改 groups 和 last_login 。',4,1),(286,'2015-05-16 22:54:31','4','刘三姐',1,'',30,1),(287,'2015-05-16 22:56:02','4','刘三姐',2,'已修改 workday 和 startday 。',30,1),(288,'2015-05-16 22:56:39','4','刘三姐',2,'已修改 email 。',30,1),(289,'2015-05-17 09:44:58','5','郑三炮',1,'',30,1),(290,'2015-05-17 14:28:23','2','N02-薪酬专员',2,'已修改 users 。',35,1),(291,'2015-05-17 16:21:02','2','N02-薪酬专员',2,'已修改 users 。',35,1),(292,'2015-05-17 16:36:09','2','N02-薪酬专员',2,'已修改 users 。',35,1),(293,'2015-05-18 18:55:53','1','新员工入职流程',2,'已删除 工作流节点 \"N02-薪酬专员\".',34,1),(294,'2015-05-18 18:56:41','1','新员工入职流程',2,'已添加 工作流节点 \"N01-薪酬专员审批\". 已添加 工作流节点 \"N02-合同专员审批\".',34,1),(295,'2015-05-18 18:57:12','3','N01-薪酬专员审批',2,'已修改 next 和 users 。',35,1),(296,'2015-05-18 18:57:32','4','N02-合同专员审批',2,'已修改 users 。',35,1),(297,'2015-05-19 20:34:24','10','S00010',3,'',36,1),(298,'2015-05-19 20:34:42','11','S00011',3,'',36,1),(299,'2015-05-19 20:34:59','9','S00009',3,'',36,1),(300,'2015-05-19 20:35:27','8','S00008',3,'',36,1),(301,'2015-05-19 22:36:09','13','S00013',3,'',36,1),(302,'2015-05-19 22:36:23','12','S00012',3,'',36,1),(303,'2015-05-19 22:39:38','14','S00014',3,'',36,1),(304,'2015-05-19 22:45:02','16','S00016',3,'',36,1),(305,'2015-05-19 22:45:02','15','S00015',3,'',36,1),(306,'2015-05-20 05:16:49','19','S00019',3,'',36,1),(307,'2015-05-20 05:16:49','18','S00018',3,'',36,1),(308,'2015-05-20 05:16:49','17','S00017',3,'',36,1),(309,'2015-05-22 22:03:15','2','内部运营服务',1,'',20,1),(310,'2015-05-22 22:03:29','8','次',1,'',21,1),(311,'2015-05-22 22:03:36','1','出差申请',1,'',27,1),(312,'2015-05-22 22:04:57','1','出差申请',2,'已添加 extra param \"ExtraParam object\". 已添加 extra param \"ExtraParam object\". 已添加 extra param \"ExtraParam object\".',27,1),(313,'2015-05-22 22:10:07','1','出差申请',2,'已修改 can_sale 。',27,1),(314,'2015-05-22 22:10:23','1','内部服务',1,'',24,1),(315,'2015-05-22 22:10:34','1','出差申请',2,'已修改 category 。',27,1),(316,'2015-05-22 22:38:58','44','工单类型',1,'',11,1),(317,'2015-05-22 22:41:19','45','业务域',1,'',11,1),(318,'2015-05-22 22:44:49','46','工单状态',1,'',11,1),(319,'2015-05-22 22:56:20','44','工单类型',2,'已添加 列表项 \"D-采购申请\".',11,1),(320,'2015-05-22 23:58:53','1','采购一批物资',1,'',40,1),(321,'2015-05-23 00:18:58','1','采购一批物资',2,'已添加 wo item \"WOItem object\".',40,1),(322,'2015-05-23 06:23:01','1','采购一批物资',2,'没有字段被修改。',40,1),(323,'2015-05-23 06:47:06','2','WO00002-出差申请（重庆）',1,'',40,1),(324,'2015-05-23 07:13:44','2','WO00002-出差申请（重庆）',2,'已修改 description 。',40,1),(325,'2015-05-23 07:45:43','2','办公设备',1,'',24,1),(326,'2015-05-23 07:45:58','3','笔记本电脑',1,'',24,1),(327,'2015-05-23 07:46:20','9','台',1,'',21,1),(328,'2015-05-23 07:46:40','3','办公用品仓库',1,'',20,1),(329,'2015-05-23 07:47:02','2','IT00002 戴尔（DELL）Inspiron 3455-R1248 灵越23.8英寸一体电脑 ',1,'',27,1),(330,'2015-05-23 08:14:53','3','WO00003-请问如何办理公积金取款',1,'',40,1),(331,'2015-05-23 08:16:25','4','WO00004-报修：7号楼2楼男厕小便池堵塞',1,'',40,1),(332,'2015-05-23 08:16:40','3','WO00003-咨询：如何办理公积金取款',2,'已修改 title 。',40,1),(333,'2015-05-23 20:47:55','2','2015年设备维修项目',1,'',19,1),(334,'2015-05-23 20:52:29','2','小便池维修费用',1,'',44,1),(335,'2015-05-23 21:07:11','1','WO00001-采购一批物资',2,'已删除 workorder item \"WOItem object\".',40,1),(336,'2015-05-23 21:07:43','1','WO00001-采购一批物资',2,'已添加 workorder item \"WOItem object\".',40,1),(337,'2015-05-23 21:33:34','3','礼金费用',1,'',44,1),(338,'2015-05-23 21:37:11','3','礼金费用',2,'已修改 wo 和 org 。',44,1),(339,'2015-05-23 21:37:28','3','礼金费用',2,'已添加 费用明细 \"ReimbursementItem object\".',44,1),(340,'2015-05-23 21:38:25','3','礼金费用',2,'没有字段被修改。',44,1),(341,'2015-05-23 21:38:56','3','2015年人事行政费用项目',1,'',19,1),(342,'2015-05-23 21:40:02','4','独生子女费',1,'',44,1),(343,'2015-05-23 21:41:31','4','独生子女费',2,'没有字段被修改。',44,1),(344,'2015-05-23 22:19:38','7','测试',1,'',44,1),(345,'2015-05-23 22:24:29','8','测试2',1,'',44,1),(346,'2015-05-23 22:26:00','7','测试',3,'',44,1),(347,'2015-05-23 22:31:18','8','测试2',2,'已修改 description 。',44,1),(348,'2015-05-23 22:31:54','8','测试2',2,'已修改 description 。',44,1),(349,'2015-05-23 22:34:53','8','测试2',2,'已修改 description 。',44,1),(350,'2015-05-23 22:39:04','8','测试2',2,'已修改 description 。',44,1),(351,'2015-05-23 22:44:42','9','xxx测试',1,'',44,1),(352,'2015-05-24 08:00:01','3','zhangliangjun',1,'',4,1),(353,'2015-05-24 08:00:36','3','zhangliangjun',2,'已修改 first_name，last_name，is_staff 和 groups 。',4,1),(354,'2015-05-24 08:00:54','3','zhangliangjun',2,'已修改 email 。',4,1),(355,'2015-05-24 08:01:40','1','职员',2,'已修改 permissions 。',3,1),(356,'2015-05-24 08:03:53','1','职员',2,'已修改 permissions 。',3,1),(357,'2015-05-24 15:13:47','3','IT00003 用车申请',1,'',27,1),(358,'2015-05-24 15:14:11','3','IT00003 用车申请',2,'已修改 category 。',27,1),(359,'2015-05-24 15:15:09','5','WO00005-接送X集团客户',1,'',40,1),(360,'2015-05-24 19:02:34','1','朱国良',2,'已修改 banknum 和 bankname 。',30,1),(361,'2015-05-24 20:02:43','3','人力资源',1,'',8,1),(362,'2015-05-24 20:04:37','47','试用期',1,'',11,1),(363,'2015-05-24 20:05:21','47','试用期',2,'已变更 weight for 列表项 \"0-无试用期\". 已变更 weight for 列表项 \"1-1个月\". 已变更 weight for 列表项 \"12-1年\". 已变更 weight for 列表项 \"2-2个月\". 已变更 weight for 列表项 \"3-3个月\". 已变更 weight for 列表项 \"4-4个月\". 已变更 weight for 列表项 \"5-5个月\". 已变更 weight for 列表项 \"6-6个月\".',11,1),(364,'2015-05-24 20:06:09','47','试用期',2,'已修改 init 和 locked 。',11,1),(365,'2015-05-24 20:07:15','4','个人自助',1,'',8,1),(366,'2015-05-24 20:07:18','46','工单状态',2,'已修改 module 。',11,1),(367,'2015-05-24 20:07:28','45','业务域',2,'已修改 module 。',11,1),(368,'2015-05-24 20:11:06','48','工资项类别',1,'',11,1),(369,'2015-05-24 20:13:08','49','增减属性',1,'',11,1),(370,'2015-05-24 20:13:15','49','增减属性',2,'已修改 module 。',11,1),(371,'2015-05-24 20:20:10','50','计算方式',1,'',11,1),(372,'2015-05-24 20:20:18','50','计算方式',2,'已修改 module 。',11,1),(373,'2015-05-24 20:25:36','50','计算方式',2,'已删除 列表项 \"30-计算值\".',11,1),(374,'2015-05-24 20:37:22','50','计算方式',2,'已添加 列表项 \"30-计算值\".',11,1),(375,'2015-05-24 21:32:21','51','离职类别',1,'',11,1),(376,'2015-05-24 21:32:31','51','离职类别',2,'已修改 module 。',11,1),(377,'2015-05-24 22:55:18','1','SalaryItem object',1,'',46,1),(378,'2015-05-24 22:57:49','2','1002 岗位工资',1,'',46,1),(379,'2015-05-24 22:57:57','3','1003 学历工资',1,'',46,1),(380,'2015-05-24 23:01:31','4','1004 工龄工资',1,'',46,1),(381,'2015-05-24 23:02:31','5','2001 养老保险',1,'',46,1),(382,'2015-05-24 23:02:48','6','2002 医疗保险',1,'',46,1),(383,'2015-05-24 23:03:06','7','2003 失业保险',1,'',46,1),(384,'2015-05-24 23:03:23','8','2004 工伤保险',1,'',46,1),(385,'2015-05-24 23:03:41','9','2005 生育保险',1,'',46,1),(386,'2015-05-24 23:03:57','10','2006 住房公积金',1,'',46,1),(387,'2015-05-24 23:05:06','11','3001 年终奖',1,'',46,1),(388,'2015-05-24 23:05:17','12','3002 销售佣金',1,'',46,1),(389,'2015-05-24 23:05:53','13','3003 人才推荐奖金',1,'',46,1),(390,'2015-05-24 23:06:48','14','4001 住房补贴',1,'',46,1),(391,'2015-05-24 23:07:12','15','4002 交通补贴',1,'',46,1),(392,'2015-05-24 23:07:33','16','4003 取暖补贴',1,'',46,1),(393,'2015-05-24 23:07:45','17','4004 高温费',1,'',46,1),(394,'2015-05-24 23:09:58','16','4003 暖气费',2,'已修改 name 。',46,1),(395,'2015-05-24 23:14:14','18','9001 考勤扣款',1,'',46,1),(396,'2015-05-24 23:14:51','19','9002 请假扣款',1,'',46,1),(397,'2015-05-24 23:16:05','20','9003 个人所得税',1,'',46,1),(398,'2015-05-24 23:16:40','21','9004 违规罚款',1,'',46,1),(399,'2015-05-24 23:17:53','13','3003 伯乐奖',2,'已修改 name 。',46,1),(400,'2015-05-25 20:10:20','1','1001 基本工资',2,'已修改 required 。',46,1),(401,'2015-05-25 20:10:26','2','1002 岗位工资',2,'已修改 required 。',46,1),(402,'2015-05-25 20:10:30','3','1003 学历工资',2,'已修改 required 。',46,1),(403,'2015-05-25 20:10:36','4','1004 工龄工资',2,'已修改 required 。',46,1),(404,'2015-05-25 20:10:42','5','2001 养老保险',2,'已修改 required 。',46,1),(405,'2015-05-25 20:10:47','6','2002 医疗保险',2,'已修改 required 。',46,1),(406,'2015-05-25 20:11:00','7','2003 失业保险',2,'已修改 required 。',46,1),(407,'2015-05-25 20:11:08','8','2004 工伤保险',2,'已修改 required 。',46,1),(408,'2015-05-25 20:11:54','9','2005 生育保险',2,'已修改 required 。',46,1),(409,'2015-05-25 20:11:58','10','2006 住房公积金',2,'已修改 required 。',46,1),(410,'2015-05-25 20:26:31','45','业务域',2,'已添加 列表项 \"PO-采购\".',11,1),(411,'2015-05-25 20:26:41','45','业务域',2,'已变更 weight for 列表项 \"AD-行政\".',11,1),(412,'2015-05-25 20:58:34','44','工单类型',2,'已变更 name for 列表项 \"S-内部服务\".',11,1),(413,'2015-05-25 21:02:27','5','WO00005-接送X集团客户',2,'已修改 refer 。',40,1),(414,'2015-05-25 21:04:38','5','WO00005-接送X集团客户',2,'已删除 扩展信息 \"WOExtraValue object\". 已删除 扩展信息 \"WOExtraValue object\". 已删除 扩展信息 \"WOExtraValue object\". 已删除 扩展信息 \"WOExtraValue object\".',40,1),(415,'2015-05-25 21:06:11','5','WO00005-接送X集团客户',2,'已删除 扩展信息 \"WOExtraValue object\". 已删除 扩展信息 \"WOExtraValue object\". 已删除 扩展信息 \"WOExtraValue object\". 已删除 扩展信息 \"WOExtraValue object\".',40,1),(416,'2015-05-25 21:10:10','9','xxx测试',2,'已修改 wo 。',44,1),(417,'2015-05-25 21:52:22','4','IT主管',1,'',18,1),(418,'2015-05-25 21:55:27','1','周树锋',1,'',47,1),(419,'2015-05-25 21:56:11','1','周树锋',2,'已添加 工资项 \"EmployeeSalaryItem object\".',47,1);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(13,'basedata','address'),(15,'basedata','bankaccount'),(23,'basedata','brand'),(24,'basedata','category'),(32,'basedata','education'),(30,'basedata','employee'),(29,'basedata','expenseaccount'),(39,'basedata','extraparam'),(31,'basedata','family'),(27,'basedata','material'),(28,'basedata','materialparam'),(21,'basedata','measure'),(14,'basedata','partner'),(19,'basedata','project'),(25,'basedata','technicalparametername'),(26,'basedata','technicalparametervalue'),(22,'basedata','trade'),(11,'basedata','valuelist'),(12,'basedata','valuelistitem'),(20,'basedata','warehouse'),(33,'basedata','workexperience'),(5,'contenttypes','contenttype'),(50,'hr','departure'),(48,'hr','employeesalaryitem'),(47,'hr','entry'),(46,'hr','salaryitem'),(49,'hr','transfer'),(16,'organ','organization'),(17,'organ','orgunit'),(18,'organ','position'),(43,'selfhelp','loan'),(44,'selfhelp','reimbursement'),(45,'selfhelp','reimbursementitem'),(41,'selfhelp','woextravalue'),(42,'selfhelp','woitem'),(40,'selfhelp','workorder'),(6,'sessions','session'),(9,'syscfg','menu'),(8,'syscfg','module'),(10,'syscfg','role'),(7,'syscfg','site'),(37,'workflow','history'),(36,'workflow','instance'),(34,'workflow','modal'),(35,'workflow','node'),(38,'workflow','todolist');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2015-05-01 07:28:26'),(2,'auth','0001_initial','2015-05-01 07:28:26'),(3,'admin','0001_initial','2015-05-01 07:28:26'),(4,'contenttypes','0002_remove_content_type_name','2015-05-01 07:28:26'),(5,'auth','0002_alter_permission_name_max_length','2015-05-01 07:28:26'),(6,'auth','0003_alter_user_email_max_length','2015-05-01 07:28:26'),(7,'auth','0004_alter_user_username_opts','2015-05-01 07:28:26'),(8,'auth','0005_alter_user_last_login_null','2015-05-01 07:28:26'),(9,'auth','0006_require_contenttypes_0002','2015-05-01 07:28:26'),(10,'sessions','0001_initial','2015-05-01 07:28:26'),(11,'syscfg','0001_initial','2015-05-01 07:28:27'),(12,'basedata','0001_initial','2015-05-01 09:25:30'),(13,'basedata','0002_auto_20150501_0929','2015-05-01 09:30:01'),(14,'basedata','0003_auto_20150501_0931','2015-05-01 09:31:07'),(15,'basedata','0004_address','2015-05-01 10:52:00'),(16,'basedata','0005_auto_20150501_1121','2015-05-01 11:21:30'),(17,'basedata','0006_partner','2015-05-01 12:02:16'),(18,'basedata','0007_bankaccount','2015-05-01 15:35:20'),(19,'basedata','0008_auto_20150501_1547','2015-05-01 15:48:03'),(20,'organ','0001_initial','2015-05-01 19:14:41'),(21,'organ','0002_auto_20150501_2036','2015-05-01 20:36:43'),(22,'organ','0003_auto_20150501_2045','2015-05-01 20:46:03'),(23,'basedata','0009_auto_20150502_0817','2015-05-02 08:17:55'),(24,'basedata','0010_auto_20150502_0851','2015-05-02 08:51:53'),(25,'basedata','0011_auto_20150502_0934','2015-05-02 09:34:17'),(26,'basedata','0012_auto_20150502_0946','2015-05-02 09:46:24'),(27,'basedata','0013_auto_20150502_1311','2015-05-02 13:11:33'),(28,'basedata','0014_auto_20150502_1314','2015-05-02 13:14:16'),(29,'basedata','0015_brand_weight','2015-05-02 13:21:10'),(30,'basedata','0016_auto_20150502_1402','2015-05-02 14:04:33'),(31,'basedata','0017_auto_20150502_1731','2015-05-02 17:31:10'),(32,'basedata','0018_auto_20150502_2100','2015-05-02 21:00:06'),(33,'organ','0004_auto_20150503_1445','2015-05-03 14:46:12'),(34,'basedata','0019_auto_20150503_1445','2015-05-03 14:46:12'),(35,'basedata','0020_auto_20150503_1501','2015-05-03 15:01:41'),(36,'basedata','0021_auto_20150503_1518','2015-05-03 15:18:14'),(37,'basedata','0022_auto_20150503_1538','2015-05-03 15:38:24'),(38,'basedata','0023_auto_20150504_2120','2015-05-04 21:20:32'),(39,'basedata','0024_education_family_workexperience','2015-05-04 21:59:53'),(44,'organ','0005_auto_20150510_1141','2015-05-10 11:41:46'),(49,'workflow','0001_initial','2015-05-10 12:18:40'),(50,'workflow','0002_auto_20150513_2124','2015-05-13 21:24:50'),(51,'basedata','0025_auto_20150516_1829','2015-05-16 18:30:12'),(52,'basedata','0026_extraparam','2015-05-22 22:01:36'),(53,'selfhelp','0001_initial','2015-05-22 23:06:19'),(54,'selfhelp','0002_auto_20150522_2330','2015-05-22 23:30:14'),(55,'selfhelp','0003_auto_20150523_0621','2015-05-23 06:21:46'),(56,'basedata','0027_auto_20150523_2007','2015-05-23 20:07:34'),(57,'selfhelp','0004_auto_20150523_2007','2015-05-23 20:07:35'),(58,'selfhelp','0005_auto_20150523_2031','2015-05-23 20:31:54'),(59,'selfhelp','0006_auto_20150523_2050','2015-05-23 20:50:08'),(60,'selfhelp','0007_auto_20150523_2052','2015-05-23 20:52:17'),(61,'selfhelp','0008_auto_20150523_2133','2015-05-23 21:33:23'),(62,'selfhelp','0009_auto_20150523_2146','2015-05-23 21:46:15'),(65,'workflow','0003_auto_20150524_2208','2015-05-24 22:23:11'),(67,'hr','0001_initial','2015-05-25 22:12:43'),(68,'selfhelp','0010_auto_20150525_2255','2015-05-25 22:55:20');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('2rdw4agh630yjfqhy14jie3dgzhi8v8i','OGEyMjM1MDM3YmU1ZmE4NjYxNmIzOWE5MTY3NjYzZjhhNDUyMWQxMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjUzODFkNDg2MjM0YTlmMTQ0YjBkM2Y4ZWY4NWNmMDZlMmRkYjE1MWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-05-16 08:18:20'),('bffad131mfdzd3ti0eat4ixwbaedqqfn','OGEyMjM1MDM3YmU1ZmE4NjYxNmIzOWE5MTY3NjYzZjhhNDUyMWQxMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjUzODFkNDg2MjM0YTlmMTQ0YjBkM2Y4ZWY4NWNmMDZlMmRkYjE1MWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-05-15 07:39:11'),('nwfmn1dz9wc0p72yy5h8p1xs289a43e3','OGEyMjM1MDM3YmU1ZmE4NjYxNmIzOWE5MTY3NjYzZjhhNDUyMWQxMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjUzODFkNDg2MjM0YTlmMTQ0YjBkM2Y4ZWY4NWNmMDZlMmRkYjE1MWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-06-07 08:33:50');

/*Table structure for table `hr_departure` */

DROP TABLE IF EXISTS `hr_departure`;

CREATE TABLE `hr_departure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_departure_employee_id_cd15087_fk_basedata_employee_id` (`employee_id`),
  CONSTRAINT `hr_departure_employee_id_cd15087_fk_basedata_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `basedata_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hr_departure` */

/*Table structure for table `hr_employeesalaryitem` */

DROP TABLE IF EXISTS `hr_employeesalaryitem`;

CREATE TABLE `hr_employeesalaryitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `calculate_way` varchar(2) NOT NULL,
  `fixed_value` decimal(10,2) DEFAULT NULL,
  `base_value` decimal(10,2) DEFAULT NULL,
  `org_percent` decimal(4,2) DEFAULT NULL,
  `employee_percent` decimal(4,2) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `entry_id` int(11) NOT NULL,
  `salary_item_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hr_employeesalaryitem_entry_id_3a7aa921_uniq` (`entry_id`,`salary_item_id`),
  KEY `hr_employeesalaryit_employee_id_3ca63cb3_fk_basedata_employee_id` (`employee_id`),
  KEY `hr_employeesalaryitem_b64a62ea` (`entry_id`),
  KEY `hr_employeesalaryitem_dc6d0554` (`salary_item_id`),
  CONSTRAINT `hr_employeesalaryitem_entry_id_24d5804c_fk_hr_entry_id` FOREIGN KEY (`entry_id`) REFERENCES `hr_entry` (`id`),
  CONSTRAINT `hr_employeesalaryite_salary_item_id_308f4922_fk_hr_salaryitem_id` FOREIGN KEY (`salary_item_id`) REFERENCES `hr_salaryitem` (`id`),
  CONSTRAINT `hr_employeesalaryit_employee_id_3ca63cb3_fk_basedata_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `basedata_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hr_employeesalaryitem` */

/*Table structure for table `hr_entry` */

DROP TABLE IF EXISTS `hr_entry`;

CREATE TABLE `hr_entry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(2) NOT NULL,
  `idcard` varchar(20) NOT NULL,
  `address` varchar(120) DEFAULT NULL,
  `zipcode` varchar(8) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `rank` varchar(2) NOT NULL,
  `ygxs` varchar(2) DEFAULT NULL,
  `category` varchar(2) DEFAULT NULL,
  `probation_months` varchar(2) NOT NULL,
  `probation_begin` date NOT NULL,
  `probation_end` date DEFAULT NULL,
  `memo` longtext,
  `profile` varchar(100) DEFAULT NULL,
  `guider_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_entry_guider_id_677409a1_fk_basedata_employee_id` (`guider_id`),
  KEY `hr_entry_position_id_70f8683c_fk_organ_position_id` (`position_id`),
  CONSTRAINT `hr_entry_guider_id_677409a1_fk_basedata_employee_id` FOREIGN KEY (`guider_id`) REFERENCES `basedata_employee` (`id`),
  CONSTRAINT `hr_entry_position_id_70f8683c_fk_organ_position_id` FOREIGN KEY (`position_id`) REFERENCES `organ_position` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hr_entry` */

/*Table structure for table `hr_salaryitem` */

DROP TABLE IF EXISTS `hr_salaryitem`;

CREATE TABLE `hr_salaryitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `classification` varchar(2) NOT NULL,
  `plus_or_minus` varchar(2) NOT NULL,
  `required` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hr_salaryitem` */

/*Table structure for table `hr_transfer` */

DROP TABLE IF EXISTS `hr_transfer`;

CREATE TABLE `hr_transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_transfer_employee_id_58f1c915_fk_basedata_employee_id` (`employee_id`),
  CONSTRAINT `hr_transfer_employee_id_58f1c915_fk_basedata_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `basedata_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `hr_transfer` */

/*Table structure for table `organ_organization` */

DROP TABLE IF EXISTS `organ_organization`;

CREATE TABLE `organ_organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `short` varchar(20) DEFAULT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `tax_num` varchar(40) DEFAULT NULL,
  `tax_address` varchar(40) DEFAULT NULL,
  `tax_account` varchar(80) DEFAULT NULL,
  `represent` varchar(40) DEFAULT NULL,
  `address` varchar(120) DEFAULT NULL,
  `zipcode` varchar(8) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `contacts` varchar(40) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `website` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `lic_code` varchar(40) DEFAULT NULL,
  `cer_code` varchar(40) DEFAULT NULL,
  `license` varchar(100) DEFAULT NULL,
  `certificate` varchar(100) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `organ_organization` */

insert  into `organ_organization`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`status`,`tax_num`,`tax_address`,`tax_account`,`represent`,`address`,`zipcode`,`fax`,`contacts`,`phone`,`website`,`email`,`lic_code`,`cer_code`,`license`,`certificate`,`weight`) values (1,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 20:26:05','2015-05-01 21:06:40','O01','上海机场（集团）有限公司','上海机场','Shanghai Airport',1,'310120000001357','上海市浦东机场启航路900号','交通银行上海分行浦东支行','李德润','上海市肇嘉浜路301号','200032','021-58698201','王勇','021-58698202','www.shairport.com','webadmin@sgs.gov.cn','310120000001357','20120620102952945','','',9);

/*Table structure for table `organ_orgunit` */

DROP TABLE IF EXISTS `organ_orgunit`;

CREATE TABLE `organ_orgunit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(8) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `short` varchar(20) DEFAULT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `unit_type` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `virtual` tinyint(1) NOT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `phone` varchar(40) DEFAULT NULL,
  `contacts` varchar(40) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  `organization_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `organ_orgunit_organization_id_56741454_fk_organ_organization_id` (`organization_id`),
  KEY `organ_orgunit_parent_id_20b497af_fk_organ_orgunit_id` (`parent_id`),
  CONSTRAINT `organ_orgunit_organization_id_56741454_fk_organ_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `organ_orgunit_parent_id_20b497af_fk_organ_orgunit_id` FOREIGN KEY (`parent_id`) REFERENCES `organ_orgunit` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `organ_orgunit` */

insert  into `organ_orgunit`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`unit_type`,`status`,`virtual`,`fax`,`phone`,`contacts`,`email`,`weight`,`organization_id`,`parent_id`) values (1,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 20:27:41','2015-05-01 20:27:41','S001','董事会','','',2,1,1,'','','','',99,1,NULL),(2,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 20:27:55','2015-05-01 20:27:55','S002','集团财务部','','',2,1,0,'','','','',99,1,NULL),(3,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 20:28:12','2015-05-01 20:28:12','S003','人事行政部','','',2,1,0,'','','','',99,1,NULL),(4,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 20:29:49','2015-05-01 20:29:49','S004','人事部','','',3,1,0,'','','','',99,1,3),(5,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 20:33:18','2015-05-01 20:34:06','S005','行政部','','',3,1,0,'','','','',99,1,3);

/*Table structure for table `organ_position` */

DROP TABLE IF EXISTS `organ_position`;

CREATE TABLE `organ_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(8) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `short` varchar(20) DEFAULT NULL,
  `pinyin` varchar(120) DEFAULT NULL,
  `series` varchar(1) NOT NULL,
  `grade` varchar(2) DEFAULT NULL,
  `virtual` tinyint(1) NOT NULL,
  `description` longtext,
  `qualification` longtext,
  `document` varchar(100) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `unit_id` int(11) NOT NULL,
  `organization_id` int(11),
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `organ_position_parent_id_1d9e732d_fk_organ_position_id` (`parent_id`),
  KEY `organ_position_unit_id_411e3ee9_fk_organ_orgunit_id` (`unit_id`),
  KEY `organ_position_26b2345e` (`organization_id`),
  CONSTRAINT `organ_position_organization_id_3435c72a_fk_organ_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `organ_position_parent_id_1d9e732d_fk_organ_position_id` FOREIGN KEY (`parent_id`) REFERENCES `organ_position` (`id`),
  CONSTRAINT `organ_position_unit_id_411e3ee9_fk_organ_orgunit_id` FOREIGN KEY (`unit_id`) REFERENCES `organ_orgunit` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `organ_position` */

insert  into `organ_position`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`series`,`grade`,`virtual`,`description`,`qualification`,`document`,`weight`,`parent_id`,`unit_id`,`organization_id`,`status`) values (2,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 20:47:51','2015-05-01 20:48:05','P0002','董事长','','','A','05',0,'','','',99,NULL,1,1,1),(3,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 15:50:00','2015-05-10 16:51:55','P0003','人事经理','','','A','02',0,'','','',99,2,4,1,1),(4,'2015-05-25','9999-12-31','zhugl',NULL,'2015-05-25 21:52:22','2015-05-25 21:52:22','P0004','IT主管','','','A','02',0,'','','',99,NULL,5,1,1);

/*Table structure for table `selfhelp_loan` */

DROP TABLE IF EXISTS `selfhelp_loan`;

CREATE TABLE `selfhelp_loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `title` varchar(120) NOT NULL,
  `status` varchar(2) DEFAULT NULL,
  `logout_time` datetime DEFAULT NULL,
  `loan_amount` decimal(10,2) NOT NULL,
  `logout_amount` decimal(10,2) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `selfhelp_loan_project_id_7b541607_fk_basedata_project_id` (`project_id`),
  KEY `selfhelp_loan_user_id_1d36464e_fk_auth_user_id` (`user_id`),
  CONSTRAINT `selfhelp_loan_project_id_7b541607_fk_basedata_project_id` FOREIGN KEY (`project_id`) REFERENCES `basedata_project` (`id`),
  CONSTRAINT `selfhelp_loan_user_id_1d36464e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_loan` */

/*Table structure for table `selfhelp_reimbursement` */

DROP TABLE IF EXISTS `selfhelp_reimbursement`;

CREATE TABLE `selfhelp_reimbursement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  `title` varchar(120) NOT NULL,
  `bank_account` varchar(120) DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `loan_amount` decimal(10,2) DEFAULT NULL,
  `logout_amount` decimal(10,2) DEFAULT NULL,
  `pay_amount` decimal(10,2) DEFAULT NULL,
  `pay_time` datetime DEFAULT NULL,
  `loan_id` int(11) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `wo_id` int(11) DEFAULT NULL,
  `description` longtext,
  PRIMARY KEY (`id`),
  KEY `selfhelp_reimbursement_org_id_1e6a35f_fk_organ_orgunit_id` (`org_id`),
  KEY `selfhelp_reimbursement_project_id_ed3db4e_fk_basedata_project_id` (`project_id`),
  KEY `selfhelp_reimbursement_user_id_5d122f07_fk_auth_user_id` (`user_id`),
  KEY `selfhelp_reimbursement_wo_id_ac8ed7a_fk_selfhelp_workorder_id` (`wo_id`),
  KEY `selfhelp_reimbursement_loan_id_44fd1f10_fk_selfhelp_loan_id` (`loan_id`),
  CONSTRAINT `selfhelp_reimbursement_loan_id_44fd1f10_fk_selfhelp_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `selfhelp_loan` (`id`),
  CONSTRAINT `selfhelp_reimbursement_org_id_1e6a35f_fk_organ_orgunit_id` FOREIGN KEY (`org_id`) REFERENCES `organ_orgunit` (`id`),
  CONSTRAINT `selfhelp_reimbursement_project_id_ed3db4e_fk_basedata_project_id` FOREIGN KEY (`project_id`) REFERENCES `basedata_project` (`id`),
  CONSTRAINT `selfhelp_reimbursement_user_id_5d122f07_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `selfhelp_reimbursement_wo_id_ac8ed7a_fk_selfhelp_workorder_id` FOREIGN KEY (`wo_id`) REFERENCES `selfhelp_workorder` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_reimbursement` */

insert  into `selfhelp_reimbursement`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`bank_account`,`status`,`amount`,`loan_amount`,`logout_amount`,`pay_amount`,`pay_time`,`loan_id`,`org_id`,`project_id`,`user_id`,`wo_id`,`description`) values (2,'2015-05-23','9999-12-31','zhugl',NULL,'2015-05-23 20:52:29','2015-05-23 20:52:29','BX00002','小便池维修费用','','N','32.00',NULL,NULL,NULL,NULL,NULL,5,2,NULL,4,NULL),(3,'2015-05-23','9999-12-31','zhugl','zhugl','2015-05-23 21:33:34','2015-05-23 21:38:25','BX00003','礼金费用','','N','1000.00',NULL,NULL,NULL,NULL,NULL,3,2,NULL,3,NULL),(4,'2015-05-23','9999-12-31','zhugl','zhugl','2015-05-23 21:40:02','2015-05-23 21:41:31','BX00004','独生子女费','','N','4200.00',NULL,NULL,NULL,NULL,NULL,3,3,NULL,NULL,NULL),(8,'2015-05-23','9999-12-31','zhugl','zhugl','2015-05-23 22:24:29','2015-05-23 22:39:04','BX00008','测试2',NULL,'N','35.00',NULL,NULL,NULL,NULL,NULL,4,1,NULL,NULL,'234567'),(9,'2015-05-23','9999-12-31','zhugl','zhugl','2015-05-23 22:44:42','2015-05-25 21:10:10','BX00009','xxx测试',NULL,'N','1965.00',NULL,NULL,NULL,NULL,NULL,4,3,NULL,2,'');

/*Table structure for table `selfhelp_reimbursementitem` */

DROP TABLE IF EXISTS `selfhelp_reimbursementitem`;

CREATE TABLE `selfhelp_reimbursementitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `memo` varchar(40) DEFAULT NULL,
  `expense_account_id` int(11) NOT NULL,
  `reimbursement_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selfhelp__reimbursement_id_37efbf0e_fk_selfhelp_reimbursement_id` (`reimbursement_id`),
  KEY `selfhe_expense_account_id_65c44030_fk_basedata_expenseaccount_id` (`expense_account_id`),
  CONSTRAINT `selfhelp__reimbursement_id_37efbf0e_fk_selfhelp_reimbursement_id` FOREIGN KEY (`reimbursement_id`) REFERENCES `selfhelp_reimbursement` (`id`),
  CONSTRAINT `selfhe_expense_account_id_65c44030_fk_basedata_expenseaccount_id` FOREIGN KEY (`expense_account_id`) REFERENCES `basedata_expenseaccount` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_reimbursementitem` */

insert  into `selfhelp_reimbursementitem`(`id`,`begin`,`amount`,`memo`,`expense_account_id`,`reimbursement_id`) values (1,'2015-05-23','32.00','',22,2),(2,'2015-05-23','500.00','',12,3),(3,'2015-05-23','500.00','',13,3),(4,'2015-05-23','3200.00','100元每人，合计32人',15,4),(5,'2015-05-23','1000.00','2人亲属去世，合计1000元',14,4),(6,'2015-05-23','12.00','',23,8),(7,'2015-05-23','23.00','',24,8),(8,'2015-05-23','320.00','',29,9),(9,'2015-05-23','126.00','',11,9),(10,'2015-05-23','123.00','',10,9),(11,'2015-05-23','521.00','',28,9),(12,'2015-05-23','875.00','',27,9);

/*Table structure for table `selfhelp_woextravalue` */

DROP TABLE IF EXISTS `selfhelp_woextravalue`;

CREATE TABLE `selfhelp_woextravalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `param_value` varchar(40) DEFAULT NULL,
  `param_name_id` int(11) NOT NULL,
  `workorder_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selfhelp_woextr_param_name_id_34779449_fk_basedata_extraparam_id` (`param_name_id`),
  KEY `selfhelp_woextravalue_be2c0a1b` (`workorder_id`),
  CONSTRAINT `selfhelp_woextrav_workorder_id_781e29d2_fk_selfhelp_workorder_id` FOREIGN KEY (`workorder_id`) REFERENCES `selfhelp_workorder` (`id`),
  CONSTRAINT `selfhelp_woextr_param_name_id_34779449_fk_basedata_extraparam_id` FOREIGN KEY (`param_name_id`) REFERENCES `basedata_extraparam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_woextravalue` */

insert  into `selfhelp_woextravalue`(`id`,`param_value`,`param_name_id`,`workorder_id`) values (1,NULL,1,2),(2,NULL,2,2),(3,NULL,3,2),(4,NULL,4,5),(5,NULL,5,5),(6,NULL,6,5),(7,NULL,7,5);

/*Table structure for table `selfhelp_woitem` */

DROP TABLE IF EXISTS `selfhelp_woitem`;

CREATE TABLE `selfhelp_woitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,4) DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL,
  `material_id` int(11) DEFAULT NULL,
  `workorder_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selfhelp_woitem_material_id_34e897bf_fk_basedata_material_id` (`material_id`),
  KEY `selfhelp_woitem_be2c0a1b` (`workorder_id`),
  CONSTRAINT `selfhelp_woitem_material_id_34e897bf_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `selfhelp_woitem_workorder_id_6a435420_fk_selfhelp_workorder_id` FOREIGN KEY (`workorder_id`) REFERENCES `selfhelp_workorder` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_woitem` */

insert  into `selfhelp_woitem`(`id`,`amount`,`price`,`material_id`,`workorder_id`) values (2,'1.0000',NULL,2,1);

/*Table structure for table `selfhelp_workorder` */

DROP TABLE IF EXISTS `selfhelp_workorder`;

CREATE TABLE `selfhelp_workorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `title` varchar(120) NOT NULL,
  `description` longtext,
  `business_domain` varchar(4) NOT NULL,
  `classification` varchar(4) NOT NULL,
  `status` varchar(6) DEFAULT NULL,
  `answer` longtext,
  `service_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `project_id` int(11),
  `code` varchar(10),
  `refer_id` int(11),
  PRIMARY KEY (`id`),
  KEY `selfhelp_workorder_service_id_17a66979_fk_basedata_material_id` (`service_id`),
  KEY `selfhelp_workorder_user_id_72d939fa_fk_auth_user_id` (`user_id`),
  KEY `selfhelp_workorder_b098ad43` (`project_id`),
  KEY `selfhelp_workorder_12b2c0fd` (`refer_id`),
  CONSTRAINT `selfhelp_workorder_project_id_66ab927f_fk_basedata_project_id` FOREIGN KEY (`project_id`) REFERENCES `basedata_project` (`id`),
  CONSTRAINT `selfhelp_workorder_refer_id_212bc854_fk_selfhelp_workorder_id` FOREIGN KEY (`refer_id`) REFERENCES `selfhelp_workorder` (`id`),
  CONSTRAINT `selfhelp_workorder_service_id_17a66979_fk_basedata_material_id` FOREIGN KEY (`service_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `selfhelp_workorder_user_id_72d939fa_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_workorder` */

insert  into `selfhelp_workorder`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`title`,`description`,`business_domain`,`classification`,`status`,`answer`,`service_id`,`user_id`,`project_id`,`code`,`refer_id`) values (1,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 23:58:53','2015-05-23 21:07:43','采购一批物资','','FI','D','NEW',NULL,NULL,1,1,'WO00001',NULL),(2,'2015-05-23','9999-12-31','zhugl','zhugl','2015-05-23 06:47:06','2015-05-23 07:13:44','出差申请（重庆）','123','HR','S','NEW',NULL,1,1,1,'WO00002',NULL),(3,'2015-05-23','9999-12-31','zhugl','zhugl','2015-05-23 08:14:53','2015-05-23 08:16:40','咨询：如何办理公积金取款','您好，我现准备在xx购买新房，请问如何办理公积金取款，谢谢。','HR','Q','NEW',NULL,NULL,1,NULL,'WO00003',NULL),(4,'2015-05-23','9999-12-31','zhugl',NULL,'2015-05-23 08:16:25','2015-05-23 08:16:25','报修：7号楼2楼男厕小便池堵塞','内有烟头，请安排人员处理','AD','R','NEW',NULL,NULL,1,NULL,'WO00004',NULL),(5,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 15:15:09','2015-05-25 21:06:11','接送X集团客户','','OT','S','NEW',NULL,3,1,NULL,'WO00005',2);

/*Table structure for table `syscfg_menu` */

DROP TABLE IF EXISTS `syscfg_menu`;

CREATE TABLE `syscfg_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `url` varchar(80) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `icon` varchar(40) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `syscfg_menu_c9799665` (`module_id`),
  CONSTRAINT `syscfg_menu_module_id_14fa2e70_fk_syscfg_module_id` FOREIGN KEY (`module_id`) REFERENCES `syscfg_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_menu` */

insert  into `syscfg_menu`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`url`,`weight`,`icon`,`status`,`module_id`) values (1,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 07:30:19','2015-05-01 07:30:19','M001','模块管理','',99,'',1,1),(2,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 07:30:32','2015-05-01 07:30:32','M002','菜单管理','',99,'',1,1),(3,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 07:52:20','2015-05-01 07:52:20','M003','角色管理','',99,'',1,1);

/*Table structure for table `syscfg_module` */

DROP TABLE IF EXISTS `syscfg_module`;

CREATE TABLE `syscfg_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `url` varchar(80) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `icon` varchar(40) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `syscfg_module_parent_id_350dc54d_fk_syscfg_module_id` (`parent_id`),
  CONSTRAINT `syscfg_module_parent_id_350dc54d_fk_syscfg_module_id` FOREIGN KEY (`parent_id`) REFERENCES `syscfg_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_module` */

insert  into `syscfg_module`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`url`,`weight`,`icon`,`status`,`parent_id`) values (1,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 07:30:01','2015-05-01 07:30:01','U001','系统管理','',99,'',1,NULL),(2,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 07:51:45','2015-05-01 07:51:45','U002','基础数据','',99,'',1,NULL),(3,'2015-05-24','9999-12-31','zhugl',NULL,'2015-05-24 20:02:43','2015-05-24 20:02:43','HR','人力资源','',99,'',1,NULL),(4,'2015-05-24','9999-12-31','zhugl',NULL,'2015-05-24 20:07:15','2015-05-24 20:07:15','U004','个人自助','',99,'',1,NULL);

/*Table structure for table `syscfg_role` */

DROP TABLE IF EXISTS `syscfg_role`;

CREATE TABLE `syscfg_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `syscfg_role_parent_id_161850bd_fk_syscfg_role_id` (`parent_id`),
  CONSTRAINT `syscfg_role_parent_id_161850bd_fk_syscfg_role_id` FOREIGN KEY (`parent_id`) REFERENCES `syscfg_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_role` */

insert  into `syscfg_role`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`description`,`status`,`parent_id`) values (1,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 07:31:46','2015-05-10 16:53:23','R001','职员','',1,NULL);

/*Table structure for table `syscfg_role_menus` */

DROP TABLE IF EXISTS `syscfg_role_menus`;

CREATE TABLE `syscfg_role_menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`menu_id`),
  KEY `syscfg_role_menus_menu_id_4fb81053_fk_syscfg_menu_id` (`menu_id`),
  CONSTRAINT `syscfg_role_menus_menu_id_4fb81053_fk_syscfg_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `syscfg_menu` (`id`),
  CONSTRAINT `syscfg_role_menus_role_id_2c83ed04_fk_syscfg_role_id` FOREIGN KEY (`role_id`) REFERENCES `syscfg_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_role_menus` */

/*Table structure for table `syscfg_role_users` */

DROP TABLE IF EXISTS `syscfg_role_users`;

CREATE TABLE `syscfg_role_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`user_id`),
  KEY `syscfg_role_users_user_id_3ede60c3_fk_auth_user_id` (`user_id`),
  CONSTRAINT `syscfg_role_users_role_id_50b58548_fk_syscfg_role_id` FOREIGN KEY (`role_id`) REFERENCES `syscfg_role` (`id`),
  CONSTRAINT `syscfg_role_users_user_id_3ede60c3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_role_users` */

insert  into `syscfg_role_users`(`id`,`role_id`,`user_id`) values (3,1,1),(4,1,2);

/*Table structure for table `syscfg_site` */

DROP TABLE IF EXISTS `syscfg_site`;

CREATE TABLE `syscfg_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `description` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_site` */

insert  into `syscfg_site`(`id`,`begin`,`end`,`name`,`description`) values (1,'2015-05-01','9999-05-01','启腾控股集团','');

/*Table structure for table `syscfg_site_user` */

DROP TABLE IF EXISTS `syscfg_site_user`;

CREATE TABLE `syscfg_site_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_id` (`site_id`,`user_id`),
  KEY `syscfg_site_user_user_id_31f8aecc_fk_auth_user_id` (`user_id`),
  CONSTRAINT `syscfg_site_user_site_id_e6ec06c_fk_syscfg_site_id` FOREIGN KEY (`site_id`) REFERENCES `syscfg_site` (`id`),
  CONSTRAINT `syscfg_site_user_user_id_31f8aecc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_site_user` */

insert  into `syscfg_site_user`(`id`,`site_id`,`user_id`) values (1,1,1);

/*Table structure for table `workflow_history` */

DROP TABLE IF EXISTS `workflow_history`;

CREATE TABLE `workflow_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_time` datetime NOT NULL,
  `pro_type` int(11) NOT NULL,
  `memo` varchar(40) DEFAULT NULL,
  `inst_id` int(11) NOT NULL,
  `node_id` int(11),
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_history_d2b1b1e1` (`inst_id`),
  KEY `workflow_history_c693ebc8` (`node_id`),
  KEY `workflow_history_e8701ad4` (`user_id`),
  CONSTRAINT `workflow_history_inst_id_2237d3b0_fk_workflow_instance_id` FOREIGN KEY (`inst_id`) REFERENCES `workflow_instance` (`id`),
  CONSTRAINT `workflow_history_node_id_54527354_fk_workflow_node_id` FOREIGN KEY (`node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_history_user_id_4dee98c5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_history` */

insert  into `workflow_history`(`id`,`pro_time`,`pro_type`,`memo`,`inst_id`,`node_id`,`user_id`) values (47,'2015-05-20 05:30:08',0,NULL,21,NULL,1),(48,'2015-05-20 06:04:31',3,'',21,3,1);

/*Table structure for table `workflow_instance` */

DROP TABLE IF EXISTS `workflow_instance`;

CREATE TABLE `workflow_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) DEFAULT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `start_time` datetime NOT NULL,
  `approved_time` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `modal_id` int(11) NOT NULL,
  `starter_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_instance_9b2b8663` (`modal_id`),
  KEY `workflow_instance_11d91f21` (`starter_id`),
  CONSTRAINT `workflow_instance_modal_id_3eb1d1ea_fk_workflow_modal_id` FOREIGN KEY (`modal_id`) REFERENCES `workflow_modal` (`id`),
  CONSTRAINT `workflow_instance_starter_id_3e0b14b6_fk_auth_user_id` FOREIGN KEY (`starter_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_instance` */

insert  into `workflow_instance`(`id`,`code`,`object_id`,`start_time`,`approved_time`,`status`,`modal_id`,`starter_id`) values (21,'S00021',4,'2015-05-20 05:30:08',NULL,3,1,1);

/*Table structure for table `workflow_instance_current_nodes` */

DROP TABLE IF EXISTS `workflow_instance_current_nodes`;

CREATE TABLE `workflow_instance_current_nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instance_id` int(11) NOT NULL,
  `node_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `instance_id` (`instance_id`,`node_id`),
  KEY `workflow_instance_current_n_node_id_54bc8d3a_fk_workflow_node_id` (`node_id`),
  CONSTRAINT `workflow_instance_current_n_node_id_54bc8d3a_fk_workflow_node_id` FOREIGN KEY (`node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_instance_cu_instance_id_556870f_fk_workflow_instance_id` FOREIGN KEY (`instance_id`) REFERENCES `workflow_instance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `workflow_instance_current_nodes` */

/*Table structure for table `workflow_modal` */

DROP TABLE IF EXISTS `workflow_modal`;

CREATE TABLE `workflow_modal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `description` longtext,
  `app_name` varchar(60) DEFAULT NULL,
  `model_name` varchar(60) DEFAULT NULL,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_moda_content_type_id_7646d9af_fk_django_content_type_id` (`content_type_id`),
  CONSTRAINT `workflow_moda_content_type_id_7646d9af_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_modal` */

insert  into `workflow_modal`(`id`,`code`,`name`,`description`,`app_name`,`model_name`,`begin`,`end`,`content_type_id`) values (1,'WF001','新员工入职流程','','basedata','employee','2015-05-10','9999-12-31',30);

/*Table structure for table `workflow_node` */

DROP TABLE IF EXISTS `workflow_node`;

CREATE TABLE `workflow_node` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(4) DEFAULT NULL,
  `name` varchar(80) NOT NULL,
  `tooltip` varchar(120) DEFAULT NULL,
  `start` tinyint(1) NOT NULL,
  `stop` tinyint(1) NOT NULL,
  `can_terminate` tinyint(1) NOT NULL,
  `can_deny` tinyint(1) NOT NULL,
  `email_notice` tinyint(1) NOT NULL,
  `short_message_notice` tinyint(1) NOT NULL,
  `approve_node` tinyint(1) NOT NULL,
  `handler` longtext,
  `handler_type` int(11) NOT NULL,
  `modal_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_node_modal_id_3aa9d381_fk_workflow_modal_id` (`modal_id`),
  CONSTRAINT `workflow_node_modal_id_3aa9d381_fk_workflow_modal_id` FOREIGN KEY (`modal_id`) REFERENCES `workflow_modal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node` */

insert  into `workflow_node`(`id`,`code`,`name`,`tooltip`,`start`,`stop`,`can_terminate`,`can_deny`,`email_notice`,`short_message_notice`,`approve_node`,`handler`,`handler_type`,`modal_id`) values (3,'N01','薪酬专员审批','',0,0,0,1,1,0,0,'',1,1),(4,'N02','合同专员审批','',0,0,0,1,1,0,0,'',1,1);

/*Table structure for table `workflow_node_departments` */

DROP TABLE IF EXISTS `workflow_node_departments`;

CREATE TABLE `workflow_node_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `orgunit_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`,`orgunit_id`),
  KEY `workflow_node_department_orgunit_id_276f2bb6_fk_organ_orgunit_id` (`orgunit_id`),
  CONSTRAINT `workflow_node_departments_node_id_379e5725_fk_workflow_node_id` FOREIGN KEY (`node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_node_department_orgunit_id_276f2bb6_fk_organ_orgunit_id` FOREIGN KEY (`orgunit_id`) REFERENCES `organ_orgunit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node_departments` */

/*Table structure for table `workflow_node_next` */

DROP TABLE IF EXISTS `workflow_node_next`;

CREATE TABLE `workflow_node_next` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_node_id` int(11) NOT NULL,
  `to_node_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `from_node_id` (`from_node_id`,`to_node_id`),
  KEY `workflow_node_next_to_node_id_71e709f3_fk_workflow_node_id` (`to_node_id`),
  CONSTRAINT `workflow_node_next_from_node_id_78e6ce74_fk_workflow_node_id` FOREIGN KEY (`from_node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_node_next_to_node_id_71e709f3_fk_workflow_node_id` FOREIGN KEY (`to_node_id`) REFERENCES `workflow_node` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node_next` */

insert  into `workflow_node_next`(`id`,`from_node_id`,`to_node_id`) values (3,3,4);

/*Table structure for table `workflow_node_positions` */

DROP TABLE IF EXISTS `workflow_node_positions`;

CREATE TABLE `workflow_node_positions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `position_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`,`position_id`),
  KEY `workflow_node_position_position_id_187bce75_fk_organ_position_id` (`position_id`),
  CONSTRAINT `workflow_node_positions_node_id_64f898c6_fk_workflow_node_id` FOREIGN KEY (`node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_node_position_position_id_187bce75_fk_organ_position_id` FOREIGN KEY (`position_id`) REFERENCES `organ_position` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node_positions` */

/*Table structure for table `workflow_node_roles` */

DROP TABLE IF EXISTS `workflow_node_roles`;

CREATE TABLE `workflow_node_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`,`role_id`),
  KEY `workflow_node_roles_role_id_1b05e9ff_fk_syscfg_role_id` (`role_id`),
  CONSTRAINT `workflow_node_roles_node_id_c6ea3f5_fk_workflow_node_id` FOREIGN KEY (`node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_node_roles_role_id_1b05e9ff_fk_syscfg_role_id` FOREIGN KEY (`role_id`) REFERENCES `syscfg_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node_roles` */

/*Table structure for table `workflow_node_users` */

DROP TABLE IF EXISTS `workflow_node_users`;

CREATE TABLE `workflow_node_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `node_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `node_id` (`node_id`,`user_id`),
  KEY `workflow_node_users_user_id_36b0d3c5_fk_auth_user_id` (`user_id`),
  CONSTRAINT `workflow_node_users_node_id_4b2940ca_fk_workflow_node_id` FOREIGN KEY (`node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_node_users_user_id_36b0d3c5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node_users` */

insert  into `workflow_node_users`(`id`,`node_id`,`user_id`) values (7,3,1),(8,3,2),(9,4,2);

/*Table structure for table `workflow_todolist` */

DROP TABLE IF EXISTS `workflow_todolist`;

CREATE TABLE `workflow_todolist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(60) DEFAULT NULL,
  `model_name` varchar(60) DEFAULT NULL,
  `arrived_time` datetime NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `read_time` datetime DEFAULT NULL,
  `inst_id` int(11) NOT NULL,
  `node_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `code` varchar(10),
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_todolist_inst_id_5f7d95_fk_workflow_instance_id` (`inst_id`),
  KEY `workflow_todolist_user_id_5209b40_fk_auth_user_id` (`user_id`),
  KEY `workflow_todolist_node_id_6be79401_fk_workflow_node_id` (`node_id`),
  CONSTRAINT `workflow_todolist_inst_id_5f7d95_fk_workflow_instance_id` FOREIGN KEY (`inst_id`) REFERENCES `workflow_instance` (`id`),
  CONSTRAINT `workflow_todolist_node_id_6be79401_fk_workflow_node_id` FOREIGN KEY (`node_id`) REFERENCES `workflow_node` (`id`),
  CONSTRAINT `workflow_todolist_user_id_5209b40_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_todolist` */

insert  into `workflow_todolist`(`id`,`app_name`,`model_name`,`arrived_time`,`is_read`,`read_time`,`inst_id`,`node_id`,`user_id`,`code`,`status`) values (57,'basedata','employee','2015-05-20 05:30:08',1,'2015-05-20 05:30:08',21,3,1,'TD00057',1),(58,'basedata','employee','2015-05-20 05:30:08',0,NULL,21,3,2,'TD00058',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
