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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

insert  into `auth_group`(`id`,`name`) values (2,'人事'),(3,'库存'),(5,'经理'),(1,'职员'),(6,'财务'),(4,'采购');

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
) ENGINE=InnoDB AUTO_INCREMENT=823 DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

insert  into `auth_group_permissions`(`id`,`group_id`,`permission_id`) values (770,1,11),(776,1,37),(777,1,38),(778,1,39),(779,1,41),(780,1,43),(781,1,44),(782,1,45),(784,1,47),(786,1,50),(787,1,53),(788,1,55),(789,1,56),(790,1,57),(791,1,61),(792,1,62),(793,1,76),(794,1,77),(795,1,78),(796,1,80),(797,1,85),(798,1,86),(799,1,89),(800,1,91),(801,1,92),(802,1,93),(803,1,94),(804,1,95),(805,1,96),(806,1,97),(807,1,98),(808,1,99),(811,1,113),(812,1,114),(813,1,117),(814,1,119),(815,1,120),(816,1,121),(817,1,122),(818,1,123),(819,1,124),(820,1,125),(821,1,126),(822,1,127),(761,1,128),(762,1,129),(763,1,130),(764,1,131),(765,1,132),(766,1,133),(767,1,134),(768,1,135),(769,1,136),(771,1,154),(773,1,162),(774,1,163),(775,1,164),(783,1,174),(772,1,175),(785,1,176),(809,1,234),(810,1,235),(45,2,115),(355,3,58),(356,3,59),(357,3,60),(358,3,61),(359,3,62),(360,3,63),(361,3,79),(362,3,80),(363,3,81),(364,3,82),(365,3,83),(366,3,84),(335,3,156),(336,3,157),(337,3,158),(338,3,159),(339,3,160),(340,3,161),(341,3,162),(342,3,163),(343,3,164),(344,3,168),(345,3,169),(346,3,170),(347,3,171),(348,3,172),(349,3,173),(350,3,174),(351,3,175),(352,3,176),(353,3,178),(354,3,181),(525,4,40),(526,4,41),(527,4,177),(528,4,178),(529,4,179),(530,4,180),(531,4,181),(532,4,182),(533,4,186);

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
) ENGINE=InnoDB AUTO_INCREMENT=237 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add Site',7,'add_site'),(20,'Can change Site',7,'change_site'),(21,'Can delete Site',7,'delete_site'),(22,'Can add module',8,'add_module'),(23,'Can change module',8,'change_module'),(24,'Can delete module',8,'delete_module'),(25,'Can add menu',9,'add_menu'),(26,'Can change menu',9,'change_menu'),(27,'Can delete menu',9,'delete_menu'),(28,'Can add role',10,'add_role'),(29,'Can change role',10,'change_role'),(30,'Can delete role',10,'delete_role'),(31,'Can add value list',11,'add_valuelist'),(32,'Can change value list',11,'change_valuelist'),(33,'Can delete value list',11,'delete_valuelist'),(34,'Can add list item',12,'add_valuelistitem'),(35,'Can change list item',12,'change_valuelistitem'),(36,'Can delete list item',12,'delete_valuelistitem'),(37,'Can add address',13,'add_address'),(38,'Can change address',13,'change_address'),(39,'Can delete address',13,'delete_address'),(40,'Can add partner',14,'add_partner'),(41,'Can change partner',14,'change_partner'),(42,'Can delete partner',14,'delete_partner'),(43,'Can add bank account',15,'add_bankaccount'),(44,'Can change bank account',15,'change_bankaccount'),(45,'Can delete bank account',15,'delete_bankaccount'),(46,'Can add organization',16,'add_organization'),(47,'Can change organization',16,'change_organization'),(48,'Can delete organization',16,'delete_organization'),(49,'Can add org unit',17,'add_orgunit'),(50,'Can change org unit',17,'change_orgunit'),(51,'Can delete org unit',17,'delete_orgunit'),(52,'Can add position',18,'add_position'),(53,'Can change position',18,'change_position'),(54,'Can delete position',18,'delete_position'),(55,'Can add project',19,'add_project'),(56,'Can change project',19,'change_project'),(57,'Can delete project',19,'delete_project'),(58,'Can add warehouse',20,'add_warehouse'),(59,'Can change warehouse',20,'change_warehouse'),(60,'Can delete warehouse',20,'delete_warehouse'),(61,'Can add measure',21,'add_measure'),(62,'Can change measure',21,'change_measure'),(63,'Can delete measure',21,'delete_measure'),(64,'Can add trade',22,'add_trade'),(65,'Can change trade',22,'change_trade'),(66,'Can delete trade',22,'delete_trade'),(67,'Can add brand',23,'add_brand'),(68,'Can change brand',23,'change_brand'),(69,'Can delete brand',23,'delete_brand'),(70,'Can add category',24,'add_category'),(71,'Can change category',24,'change_category'),(72,'Can delete category',24,'delete_category'),(73,'Can add technical parameter',25,'add_technicalparametername'),(74,'Can change technical parameter',25,'change_technicalparametername'),(75,'Can delete technical parameter',25,'delete_technicalparametername'),(76,'Can add technical value',26,'add_technicalparametervalue'),(77,'Can change technical value',26,'change_technicalparametervalue'),(78,'Can delete technical value',26,'delete_technicalparametervalue'),(79,'Can add material',27,'add_material'),(80,'Can change material',27,'change_material'),(81,'Can delete material',27,'delete_material'),(82,'Can add material parameter',28,'add_materialparam'),(83,'Can change material parameter',28,'change_materialparam'),(84,'Can delete material parameter',28,'delete_materialparam'),(85,'Can add expenses account',29,'add_expenseaccount'),(86,'Can change expenses account',29,'change_expenseaccount'),(87,'Can delete expenses account',29,'delete_expenseaccount'),(88,'Can add employee',30,'add_employee'),(89,'Can change employee',30,'change_employee'),(90,'Can delete employee',30,'delete_employee'),(91,'Can add family member',31,'add_family'),(92,'Can change family member',31,'change_family'),(93,'Can delete family member',31,'delete_family'),(94,'Can add education experience',32,'add_education'),(95,'Can change education experience',32,'change_education'),(96,'Can delete education experience',32,'delete_education'),(97,'Can add work experience',33,'add_workexperience'),(98,'Can change work experience',33,'change_workexperience'),(99,'Can delete work experience',33,'delete_workexperience'),(100,'Can add workflow model',34,'add_modal'),(101,'Can change workflow model',34,'change_modal'),(102,'Can delete workflow model',34,'delete_modal'),(103,'Can add workflow node',35,'add_node'),(104,'Can change workflow node',35,'change_node'),(105,'Can delete workflow node',35,'delete_node'),(106,'Can add workflow instance',36,'add_instance'),(107,'Can change workflow instance',36,'change_instance'),(108,'Can delete workflow instance',36,'delete_instance'),(109,'Can add workflow history',37,'add_history'),(110,'Can change workflow history',37,'change_history'),(111,'Can delete workflow history',37,'delete_history'),(112,'Can add workflow todo',38,'add_todolist'),(113,'Can change workflow todo',38,'change_todolist'),(114,'Can delete workflow todo',38,'delete_todolist'),(115,'view all employee',30,'view_all_employee'),(116,'Can add extra param',39,'add_extraparam'),(117,'Can change extra param',39,'change_extraparam'),(118,'Can delete extra param',39,'delete_extraparam'),(119,'Can add work order',40,'add_workorder'),(120,'Can change work order',40,'change_workorder'),(121,'Can delete work order',40,'delete_workorder'),(122,'Can add wo extra value',41,'add_woextravalue'),(123,'Can change wo extra value',41,'change_woextravalue'),(124,'Can delete wo extra value',41,'delete_woextravalue'),(125,'Can add wo item',42,'add_woitem'),(126,'Can change wo item',42,'change_woitem'),(127,'Can delete wo item',42,'delete_woitem'),(128,'Can add loan',43,'add_loan'),(129,'Can change loan',43,'change_loan'),(130,'Can delete loan',43,'delete_loan'),(131,'Can add reimbursement',44,'add_reimbursement'),(132,'Can change reimbursement',44,'change_reimbursement'),(133,'Can delete reimbursement',44,'delete_reimbursement'),(134,'Can add fee item ',45,'add_reimbursementitem'),(135,'Can change fee item ',45,'change_reimbursementitem'),(136,'Can delete fee item ',45,'delete_reimbursementitem'),(137,'Can add salary item',46,'add_salaryitem'),(138,'Can change salary item',46,'change_salaryitem'),(139,'Can delete salary item',46,'delete_salaryitem'),(140,'Can add employee entry',47,'add_entry'),(141,'Can change employee entry',47,'change_entry'),(142,'Can delete employee entry',47,'delete_entry'),(143,'Can add salary item',48,'add_employeesalaryitem'),(144,'Can change salary item',48,'change_employeesalaryitem'),(145,'Can delete salary item',48,'delete_employeesalaryitem'),(146,'Can add employee transfer',49,'add_transfer'),(147,'Can change employee transfer',49,'change_transfer'),(148,'Can delete employee transfer',49,'delete_transfer'),(149,'Can add employee departure',50,'add_departure'),(150,'Can change employee departure',50,'change_departure'),(151,'Can delete employee departure',50,'delete_departure'),(152,'modify salary item',47,'modify_salary_item'),(153,'Can add Inventory',51,'add_inventory'),(154,'Can change Inventory',51,'change_inventory'),(155,'Can delete Inventory',51,'delete_inventory'),(156,'Can add Initial Inventory',52,'add_initialinventory'),(157,'Can change Initial Inventory',52,'change_initialinventory'),(158,'Can delete Initial Inventory',52,'delete_initialinventory'),(159,'Can add StockIn',53,'add_stockin'),(160,'Can change StockIn',53,'change_stockin'),(161,'Can delete StockIn',53,'delete_stockin'),(162,'Can add StockOut',54,'add_stockout'),(163,'Can change StockOut',54,'change_stockout'),(164,'Can delete StockOut',54,'delete_stockout'),(165,'Can add in out detail',55,'add_inoutdetail'),(166,'Can change in out detail',55,'change_inoutdetail'),(167,'Can delete in out detail',55,'delete_inoutdetail'),(168,'Can add init item',56,'add_inititem'),(169,'Can change init item',56,'change_inititem'),(170,'Can delete init item',56,'delete_inititem'),(171,'Can add in item',57,'add_initem'),(172,'Can change in item',57,'change_initem'),(173,'Can delete in item',57,'delete_initem'),(174,'Can add out item',58,'add_outitem'),(175,'Can change out item',58,'change_outitem'),(176,'Can delete out item',58,'delete_outitem'),(177,'Can add purchase order',59,'add_purchaseorder'),(178,'Can change purchase order',59,'change_purchaseorder'),(179,'Can delete purchase order',59,'delete_purchaseorder'),(180,'Can add po item',60,'add_poitem'),(181,'Can change po item',60,'change_poitem'),(182,'Can delete po item',60,'delete_poitem'),(183,'view all customer',15,'view_all_customer'),(184,'view all supplier',15,'view_all_supplier'),(185,'view all customer',14,'view_all_customer'),(186,'view all supplier',14,'view_all_supplier'),(187,'Can add Invoice',61,'add_invoice'),(188,'Can change Invoice',61,'change_invoice'),(189,'Can delete Invoice',61,'delete_invoice'),(190,'Can add Payment',62,'add_payment'),(191,'Can change Payment',62,'change_payment'),(192,'Can delete Payment',62,'delete_payment'),(193,'Can add activity',63,'add_activity'),(194,'Can change activity',63,'change_activity'),(195,'Can delete activity',63,'delete_activity'),(196,'Can add feedback',64,'add_feedback'),(197,'Can change feedback',64,'change_feedback'),(198,'Can delete feedback',64,'delete_feedback'),(199,'Can add enroll',65,'add_enroll'),(200,'Can change enroll',65,'change_enroll'),(201,'Can delete enroll',65,'delete_enroll'),(202,'Can add sale order',66,'add_saleorder'),(203,'Can change sale order',66,'change_saleorder'),(204,'Can delete sale order',66,'delete_saleorder'),(205,'Can add order detail',67,'add_saleitem'),(206,'Can change order detail',67,'change_saleitem'),(207,'Can delete order detail',67,'delete_saleitem'),(208,'Can add Payment Collection',68,'add_paymentcollection'),(209,'Can change Payment Collection',68,'change_paymentcollection'),(210,'Can delete Payment Collection',68,'delete_paymentcollection'),(211,'Can add offer sheet',69,'add_offersheet'),(212,'Can change offer sheet',69,'change_offersheet'),(213,'Can delete offer sheet',69,'delete_offersheet'),(214,'Can add offer detail',70,'add_offeritem'),(215,'Can change offer detail',70,'change_offeritem'),(216,'Can delete offer detail',70,'delete_offeritem'),(217,'Can add ware return',71,'add_warereturn'),(218,'Can change ware return',71,'change_warereturn'),(219,'Can delete ware return',71,'delete_warereturn'),(220,'Can add return item',72,'add_returnitem'),(221,'Can change return item',72,'change_returnitem'),(222,'Can delete return item',72,'delete_returnitem'),(223,'Can add ware adjust',73,'add_wareadjust'),(224,'Can change ware adjust',73,'change_wareadjust'),(225,'Can delete ware adjust',73,'delete_wareadjust'),(226,'Can add adjust item',74,'add_adjustitem'),(227,'Can change adjust item',74,'change_adjustitem'),(228,'Can delete adjust item',74,'delete_adjustitem'),(229,'Can add data import',75,'add_dataimport'),(230,'Can change data import',75,'change_dataimport'),(231,'Can delete data import',75,'delete_dataimport'),(232,'financial pay',43,'financial_pay'),(233,'financial pay',44,'financial_pay'),(234,'Can add document',76,'add_document'),(235,'Can change document',76,'change_document'),(236,'Can delete document',76,'delete_document');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values (11,'pbkdf2_sha256$20000$65muyWSOyY0I$AJfRNDE6kHRx5nC+mpIokzi8SbBxOgkHvhUSV9aEsPs=','2015-07-30 21:20:26',1,'chengcai','才','成','chengcai@abc.com',1,1,'2015-06-28 06:07:28'),(12,'pbkdf2_sha256$20000$Aa8BLynbsEpp$pI4WoKbMcC6aMUWt0CMCsG+n4pCd1hU3en6rLrHhh8s=','2015-06-28 06:21:54',0,'admin','管理员','系统','admin@abc.com',1,1,'2015-06-28 06:21:16'),(13,'pbkdf2_sha256$20000$PEAP6nZQMRCd$tZYq/lxTE8D4AfxuTvDp6SwhXzhjlti1Md21z0sM+CQ=','2015-07-30 21:24:15',0,'zhangsan','张三','','',1,1,'2015-07-02 05:16:00'),(14,'pbkdf2_sha256$20000$JHBOGao9PQ8B$fkSipKaxiKPc1wSDF+goL3CTq9Vn8FChVwECsedyGAw=','2015-07-30 21:23:39',0,'lisi','李四','','',1,1,'2015-07-02 05:17:00'),(15,'pbkdf2_sha256$20000$y5ll1rcvxVCD$aVtFs/PauFR3SkhQER87nD8fYMTI79ix1mTzt5qYMpU=',NULL,0,'wangwu','王五','','',1,1,'2015-07-02 05:17:00'),(16,'pbkdf2_sha256$20000$8x5VhF4ohGFd$YEBmAxWAb8xkIBcbzsLLAgCNCoMt7hMQlO4K2v80isM=','2015-07-30 21:22:33',0,'dongyong','董永','','',1,1,'2015-07-02 05:17:00'),(17,'pbkdf2_sha256$20000$NR4ED19mIltP$nBnvpsnPPDdQniXIq/H2TRZny9KDo4w/LdM9yRRrJmk=','2015-07-15 12:06:07',0,'9001','曹菊芳','','caojf@163.com',1,1,'2015-07-15 12:04:17');

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

insert  into `auth_user_groups`(`id`,`user_id`,`group_id`) values (15,12,1),(23,13,1),(21,14,1),(22,15,1),(20,16,1),(24,17,1);

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
  `org_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_bankaccount_partner_id_561018ee_fk_basedata_partner_id` (`partner_id`),
  KEY `basedata_bankaccount_9cf869aa` (`org_id`),
  CONSTRAINT `basedata_bankaccount_org_id_6017321e_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `basedata_bankaccount_partner_id_561018ee_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_bankaccount` */

insert  into `basedata_bankaccount`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`account`,`title`,`memo`,`partner_id`,`org_id`) values (2,NULL,NULL,NULL,NULL,'2015-06-14 18:08:21','2015-06-14 18:08:21','2335635412398092','杭州银行','',NULL,1);

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

/*Table structure for table `basedata_dataimport` */

DROP TABLE IF EXISTS `basedata_dataimport`;

CREATE TABLE `basedata_dataimport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `imp_date` date DEFAULT NULL,
  `title` varchar(40) NOT NULL,
  `description` longtext,
  `attach` varchar(100) DEFAULT NULL,
  `is_clear` tinyint(1) NOT NULL,
  `handler` varchar(80) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_data_content_type_id_2051ca2a_fk_django_content_type_id` (`content_type_id`),
  CONSTRAINT `basedata_data_content_type_id_2051ca2a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_dataimport` */

insert  into `basedata_dataimport`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`imp_date`,`title`,`description`,`attach`,`is_clear`,`handler`,`status`,`content_type_id`) values (20,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 09:03:59','2015-07-15 12:10:58','2015-06-28','【上线准备】-【部门|岗位|员工】第一步','====操作步骤====\r\n1）请从【文档】中下载模板文档【FD0001】；\r\n2）在您的电脑上用excel编辑文档，按照要求录入部门信息、岗位信息、员工信息；\r\n3）在您整理好的文档后，点击【选择文件】按钮，上传您的文档；\r\n4）点击【保存】按钮先保存您的文档到服务器；\r\n5）点击【导入】按钮将您的数据导入至系统中；\r\n====提示信息====\r\n1）请勿修改【处理类】中的【OPS】内容，本类数据的【处理类】为指定值；\r\n2）在组织机构重组时，您可批量导入重组后的数据，原先的旧组织机构将被设置为过期，仍然保留在系统中；','',0,'OPS','0',18),(21,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 09:09:24','2015-06-28 09:16:37','2015-06-28','【上线准备】-【用户信息】第二步','====操作步骤====\r\n1）请从【文档】中下载模板文档【FD0005】；\r\n2）在您的电脑上用excel编辑文档，按照要求录入用户信息；\r\n3）在您整理好的文档后，点击【选择文件】按钮，上传您的文档；\r\n4）点击【保存】按钮先保存您的文档到服务器；\r\n5）点击【导入】按钮将您的数据导入至系统中；\r\n====提示信息====\r\n1）请勿修改【处理类】中的【admin.user】内容，本类数据的【处理类】为指定值；','',0,'admin.user','0',4),(22,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 09:13:34','2015-06-28 09:20:20','2015-06-28','【上线准备】-【合作伙伴信息】第三步','====操作步骤====\r\n1）请从【文档】中下载模板文档【FD0003】；\r\n2）在您的电脑上用excel编辑文档，按照要求录入合作伙伴（客户|供应商）信息；\r\n3）在您整理好的文档后，点击【选择文件】按钮，上传您的文档；\r\n4）点击【保存】按钮先保存您的文档到服务器；\r\n5）点击【导入】按钮将您的数据导入至系统中；\r\n====提示信息====\r\n1）模板中的”C“代表客户，”S“代表供应商；','',0,'','0',14),(23,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 09:18:59','2015-06-28 09:20:48','2015-06-28','【上线准备】-【项目信息】第四步（可选）','====操作步骤====\r\n1）请从【文档】中下载模板文档【FD0004】；\r\n2）在您的电脑上用excel编辑文档，按照要求录入项目信息；\r\n3）在您整理好的文档后，点击【选择文件】按钮，上传您的文档；\r\n4）点击【保存】按钮先保存您的文档到服务器；\r\n5）点击【导入】按钮将您的数据导入至系统中；\r\n====提示信息====\r\n1）本项工作可选，非必需项；','',0,'','0',19);

/*Table structure for table `basedata_document` */

DROP TABLE IF EXISTS `basedata_document`;

CREATE TABLE `basedata_document` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `title` varchar(120) NOT NULL,
  `keywords` varchar(120) DEFAULT NULL,
  `description` longtext,
  `tp` varchar(2) NOT NULL,
  `business_domain` varchar(4) NOT NULL,
  `status` varchar(2) NOT NULL,
  `pub_date` datetime DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  `attach` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `basedata_document_user_id_105428c7_fk_auth_user_id` (`user_id`),
  CONSTRAINT `basedata_document_user_id_105428c7_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_document` */

insert  into `basedata_document`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`keywords`,`description`,`tp`,`business_domain`,`status`,`pub_date`,`size`,`attach`,`user_id`) values (1,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 07:27:18','2015-06-28 08:54:09','FD0001','【模板文档】-【基础数据】-1001部门岗位员工导入模板','导入模板 部门 岗位 员工','1）在系统上线的时候，用于大批量的导入部门、岗位、员工信息；\r\n2）操作路径为：【基础数据】>【导入】；\r\n3）在列表页面选择“增加 导入”按钮，打开表单页面；\r\n4）在表单页面，填写“处理类”字段的值为：OPS，选择本地文档上传；\r\n5）注意：先保存，后执行“导入”；\r\n6）提示：在组织机构重组时，可使用本模板进行大批量更改；','00','OT','1','2015-07-06 20:47:19',NULL,'doc/1001部门岗位员工导入模板.xls',11),(2,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 08:23:01','2015-06-28 08:32:43','FD0002','【模板文档】-【基础数据】-1002期初库存导入模板','导入模板 期初库存','1）在系统上线的时候，用于批量的导入期初库存信息；\r\n2）操作路径为：【库存管理】>【期初库存】；\r\n3）在列表页面，选择“增加 期初库存”按钮，进入表单页面；\r\n4）输入相关信息，从本地上传修改后的CSV文档；\r\n5）先保存，后执行“入库”操作；\r\n6）注意：本文档为csv格式，请使用excel编辑；\r\n','00','OT','1','2015-07-06 20:47:19',NULL,'doc/1002期初库存导入模板.csv',11),(3,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 08:30:17','2015-06-28 08:32:33','FD0003','【模板文档】-【基础数据】-1003合作伙伴导入模板','导入模板 合作伙伴','1）在系统上线的时候，用于大批量的导入合作伙伴（客户、供应商）信息；\r\n2）操作路径为：【基础数据】>【导入】；\r\n3）在列表页面选择“增加 导入”按钮，打开表单页面；\r\n4）在表单页面，选择本地文档上传；\r\n5）注意：先保存，后执行“导入”；','00','OT','1','2015-07-06 20:47:19',NULL,'doc/1003合作伙伴导入模板.xls',11),(4,'2015-06-28','9999-12-31','chengcai',NULL,'2015-06-28 08:32:25','2015-06-28 08:32:25','FD0004','【模板文档】-【基础数据】-1004项目信息导入模板','导入模板 项目信息','','00','OT','1','2015-07-06 20:47:19',NULL,'doc/1004项目导入模板.xls',11),(5,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 08:35:37','2015-06-28 08:35:59','FD0005','【模板文档】-【基础数据】-1005用户信息导入模板','导入模板 用户','1）在系统上线的时候，用于大批量的导入用户信息；\r\n2）操作路径为：【基础数据】>【导入】；\r\n3）在列表页面选择“增加 导入”按钮，打开表单页面；\r\n4）在表单页面，填写“处理类”字段的值为：admin.user，选择本地文档上传；\r\n5）注意：先保存，后执行“导入”；','00','OT','1','2015-07-06 20:47:19',NULL,'',11),(6,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 08:39:50','2015-06-28 08:45:56','FD0006','【模板文档】-【明细数据】-2001报价单明细导入模板','导入模板 报价单明细 ','1）在创建报价单的时候，若物料明细太多，可选择从excel批量导入；\r\n2）在保存报价单的时候，系统依据上传的文档自动加载物料；\r\n3）导入的物料遵循“没有即创建”原则，若系统中没有此物料则直接创建，检查的依据为【物料编号】，请慎重填写【物料编号】，避免造成重复导入；\r\n4）本模板有开关功能，当【B1】单元格为【0演示数据】时，不导入，为【1正式报价】时导入','00','BU','1','2015-07-06 20:47:19',NULL,'doc/2001报价单明细样例.xls',11),(7,'2015-06-28','9999-12-31','chengcai','chengcai','2015-06-28 08:47:41','2015-06-28 08:48:09','FD0007','【模板文档】-【明细数据】-2002需求单明细导入模板','导入模板 需求单明细 工单服务 ','1）在创建【工单服务】的时候，若需求物料明细太多，可选择从excel批量导入；\r\n2）在保存【工单服务】的时候，系统依据上传的文档自动加载物料；\r\n3）导入的物料遵循“没有即创建”原则，若系统中没有此物料则直接创建，检查的依据为【物料编号】，请慎重填写【物料编号】，避免造成重复导入；\r\n4）本模板有开关功能，当【B1】单元格为【0演示数据】时，不导入，为【1正式报价】时导入','00','OT','1','2015-07-06 20:47:19',NULL,'doc/2002需求计划明细样例.xls',11),(8,'2015-06-28','9999-12-31','chengcai',NULL,'2015-06-28 08:50:09','2015-06-28 08:50:09','FD0008','【模板文档】-【明细数据】-2003采购单明细导入模板','导入模板 采购单明细 ','1）在创建【采购单】的时候，若物料明细太多，可选择从excel批量导入；\r\n2）在保存【采购单】的时候，系统依据上传的文档自动加载物料；\r\n3）导入的物料遵循“没有即创建”原则，若系统中没有此物料则直接创建，检查的依据为【物料编号】，请慎重填写【物料编号】，避免造成重复导入；\r\n4）本模板有开关功能，当【B1】单元格为【0演示数据】时，不导入，为【1正式报价】时导入','00','PO','1','2015-07-06 20:47:19',NULL,'doc/2003采购单明细样例.xls',11),(9,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:28:30','2015-07-03 21:28:30','FD0009','【使用手册】-功能概述','maximus 功能概述','','00','OT','0',NULL,NULL,'',11),(10,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:28:58','2015-07-03 21:28:58','FD0010','【使用手册】-基本操作','maximus 基本操作','','00','OT','0',NULL,NULL,'',11),(11,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:29:29','2015-07-03 21:29:29','FD0011','【使用手册】-个人自助','maximus 个人自助','','00','OT','0',NULL,NULL,'',11),(12,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:29:58','2015-07-03 21:29:58','FD0012','【使用手册】-销售管理','maximus 销售管理','','00','OT','0',NULL,NULL,'',11),(13,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:30:39','2015-07-03 21:30:39','FD0013','【使用手册】-采购管理','maximus 采购管理','','00','OT','0',NULL,NULL,'',11),(14,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:31:19','2015-07-03 21:31:19','FD0014','【使用手册】-库存管理','maximus 库存管理','','00','OT','0',NULL,NULL,'',11),(15,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:31:41','2015-07-03 21:31:41','FD0015','【使用手册】-组织机构','maximus 组织机构','','00','OT','0',NULL,NULL,'',11),(16,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:32:03','2015-07-03 21:32:03','FD0016','【使用手册】-基础数据','maximus 基础数据','','00','OT','0',NULL,NULL,'',11),(17,'2015-07-03','9999-12-31','chengcai',NULL,'2015-07-03 21:32:26','2015-07-03 21:32:26','FD0017','【使用手册】-工作流管理','maximus 工作流','','00','OT','0',NULL,NULL,'',11);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_education` */

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

insert  into `basedata_employee`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`pinyin`,`birthday`,`gender`,`idcard`,`country`,`hometown`,`address`,`banknum`,`bankname`,`emergency`,`rank`,`workday`,`startday`,`religion`,`marital`,`party`,`nation`,`ygxs`,`status`,`category`,`literacy`,`major`,`degree`,`tag1`,`tag2`,`tag3`,`tag4`,`organization_id`,`position_id`,`user_id`,`email`,`office`,`phone`,`health`,`spjob`) values (1,NULL,NULL,NULL,'chengcai','2015-06-27 13:08:28','2015-07-02 05:24:41','1001','李四','lisi','1956-11-21','1','110112195611212118','CN','','','','','','10','1983-09-01','2001-10-21','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,99,14,'','','','1','00'),(2,'2015-07-02','9999-12-31','chengcai','chengcai','2015-07-02 05:22:26','2015-07-02 05:25:23','1002','张三','zhangsan','1988-12-02','1','321027198812021234','CN','','','','','','12','2008-07-02','2012-07-02','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,92,13,'','','','1','00'),(3,'2015-07-02','9999-12-31','chengcai',NULL,'2015-07-02 05:27:10','2015-07-02 05:27:10','1003','王五','wangwu','1973-12-03','1','310202197312038921','CN','','','','','','12','2015-07-02','2015-07-02','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,91,11,'','','','1','00'),(4,'2015-07-02','9999-12-31','chengcai','chengcai','2015-07-02 05:28:44','2015-07-02 06:07:37','1004','董永','dongyong','1981-02-13','1','1011123119810213892x','CN','','','','','','10','2015-07-02','2015-07-02','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,87,16,'','','','1','00'),(5,NULL,NULL,NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','9001','曹菊芳','caojufang','1972-09-12','2','31011019720912574x','CN',NULL,NULL,NULL,NULL,NULL,'00','1985-09-01','2000-10-01','00','10','13','01','2','10','21','10','99','4','99','9','00','0',NULL,96,17,NULL,NULL,NULL,'1','00');

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
  `org_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_expens_parent_id_61334aac_fk_basedata_expenseaccount_id` (`parent_id`),
  KEY `basedata_expenseaccount_9cf869aa` (`org_id`),
  CONSTRAINT `basedata_expenseaccount_org_id_5661eb95_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `basedata_expens_parent_id_61334aac_fk_basedata_expenseaccount_id` FOREIGN KEY (`parent_id`) REFERENCES `basedata_expenseaccount` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_expenseaccount` */

insert  into `basedata_expenseaccount`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`category`,`description`,`status`,`parent_id`,`org_id`) values (1,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:03:23','2015-05-02 21:03:23','FC0001','差旅补助','PU','',1,NULL,NULL),(2,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:03:28','2015-05-02 21:03:28','FC0002','住宿费','PU','',1,NULL,NULL),(3,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:03:45','2015-05-02 21:03:45','FC0003','市内交通费','PU','',1,NULL,NULL),(4,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:00','2015-05-02 21:04:00','FC0004','长途交通（大巴）费','PU','',1,NULL,NULL),(5,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:11','2015-05-02 21:04:11','FC0005','长途交通（火车）费','PU','',1,NULL,NULL),(6,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:22','2015-05-02 21:04:22','FC0006','机票费','PU','',1,NULL,NULL),(7,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:04:31','2015-05-02 21:04:31','FC0007','业务咨询费','PU','',1,NULL,NULL),(8,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:05:09','2015-05-02 21:05:09','FC0008','赞助费','PU','',1,NULL,NULL),(9,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:05:32','2015-05-02 21:05:32','FC0009','教育培训费','HR','',1,NULL,NULL),(10,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:05:55','2015-05-02 21:05:55','FC0010','集体活动费','HR','',1,NULL,NULL),(11,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:16','2015-05-02 21:06:16','FC0011','劳务外包费','HR','',1,NULL,NULL),(12,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:33','2015-05-02 21:06:33','FC0012','结婚礼金','HR','',1,NULL,NULL),(13,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:43','2015-05-02 21:06:43','FC0013','生育礼金','HR','',1,NULL,NULL),(14,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:06:54','2015-05-02 21:06:54','FC0014','丧葬抚恤','HR','',1,NULL,NULL),(15,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:07:08','2015-05-02 21:07:08','FC0015','独生子女费','HR','',1,NULL,NULL),(16,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:09:31','2015-05-02 21:09:31','FC0016','IT设备及服务费用','OF','',1,NULL,NULL),(17,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:09:48','2015-05-02 21:09:48','FC0017','通信及网络费用','OF','',1,NULL,NULL),(18,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:10:06','2015-05-02 21:10:06','FC0018','印刷品费用','OF','',1,NULL,NULL),(19,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:10:30','2015-05-02 21:10:30','FC0019','劳保用品费用','OF','',1,NULL,NULL),(20,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:10:58','2015-05-02 21:10:58','FC0020','办公用品费用','OF','',1,NULL,NULL),(21,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:11:32','2015-05-02 21:11:32','FC0021','车辆维修营运保养费','OF','',1,NULL,NULL),(22,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:12:00','2015-05-02 21:12:00','FC0022','固定资产购置修缮费','OF','',1,NULL,NULL),(23,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:13:39','2015-05-02 21:13:39','FC0023','运输费','MU','',1,NULL,NULL),(24,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:13:49','2015-05-02 21:13:49','FC0024','包装费','MU','',1,NULL,NULL),(25,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:14:08','2015-05-02 21:14:08','FC0025','设备维修费','MU','',1,NULL,NULL),(26,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:14:33','2015-05-02 21:14:33','FC0026','技术咨询费','MU','',1,NULL,NULL),(27,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:14:58','2015-05-02 21:14:58','FC0027','礼品费','BU','',1,NULL,NULL),(28,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:15:10','2015-05-02 21:15:10','FC0028','业务招待费','BU','',1,NULL,NULL),(29,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:15:25','2015-05-02 21:15:25','FC0029','广告费','BU','',1,NULL,NULL),(30,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:19:28','2015-05-02 21:19:28','FC0030','土地房屋设备租赁费','OF','',1,NULL,NULL),(31,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:20:46','2015-05-02 21:20:46','FC0031','诉讼费','PU','',1,NULL,NULL),(32,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:21:07','2015-05-02 21:21:07','FC0032','审计费','PU','',1,NULL,NULL),(33,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:22:52','2015-05-02 21:22:52','FC0033','商业保险费','PU','',1,NULL,NULL),(34,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:23:31','2015-05-02 21:23:31','FC0034','代理服务费','PU','',1,NULL,NULL),(35,'2015-05-02','9999-12-31','zhugl',NULL,'2015-05-02 21:26:27','2015-05-02 21:26:27','FC0035','其他不便归类的费用','OT','',1,NULL,NULL),(36,'2015-06-27','9999-12-31','zhangliangjun',NULL,'2015-06-27 08:15:17','2015-06-27 08:15:17','FC0036','食堂粮油','OF','',1,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_extraparam` */

insert  into `basedata_extraparam`(`id`,`name`,`data_type`,`data_source`,`material_id`) values (1,'出发日期','DATE','',1),(2,'预计返回日期','DATE','',1),(3,'目的地','CHAR','S043',1),(4,'起始里程','NUM','',3),(5,'结束里程','NUM','',3),(6,'所用里程','NUM','',3),(7,'目的地','CHAR','',3),(8,'加班时长（小时）','NUM','',57),(9,'调休时长（小时）','NUM','',58),(10,'休假时长（小时）','NUM','',59),(11,'工卡/饭卡/门禁卡','CHAR','',60),(12,'计算机编号/IP地址','CHAR','',60),(13,'员工手册/保密培训','CHAR','',60),(14,'办公用品','CHAR','',60),(15,'工位安排','CHAR','',60),(16,'宿舍安排','CHAR','',60),(17,'ERP系统/帐号','CHAR','',60),(18,'邮箱开通/邮箱地址','CHAR','',60),(19,'贷款银行抬头','CHAR','',62),(20,'薪水截止日期','CHAR','',63),(21,'社保及公积金办理','CHAR','',63),(22,'工卡/门禁卡/饭卡回收','CHAR','',63),(23,'ERP系统/帐号停用','CHAR','',63),(24,'邮箱帐号停用','CHAR','',63),(25,'计算机/IP地址注销','CHAR','',63),(26,'工作内容交接','CHAR','',63),(27,'离职证明开具','CHAR','',63),(28,'培训课程','CHAR','',64),(29,'培训机构','CHAR','',64),(30,'培训天数','NUM','',64);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_family` */

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
  `org_id` int(11),
  `tp` varchar(2),
  PRIMARY KEY (`id`),
  KEY `basedata_material_brand_id_70cca220_fk_basedata_brand_id` (`brand_id`),
  KEY `basedata_material_category_id_7ca5506e_fk_basedata_category_id` (`category_id`),
  KEY `basedata_material_9744817e` (`warehouse_id`),
  KEY `basedata_material_9cf869aa` (`org_id`),
  CONSTRAINT `basedata_material_brand_id_70cca220_fk_basedata_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `basedata_brand` (`id`),
  CONSTRAINT `basedata_material_category_id_7ca5506e_fk_basedata_category_id` FOREIGN KEY (`category_id`) REFERENCES `basedata_category` (`id`),
  CONSTRAINT `basedata_material_org_id_1ac5ffff_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `basedata_material_warehouse_id_1e7533f6_fk_basedata_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `basedata_warehouse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_material` */

insert  into `basedata_material`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`barcode`,`name`,`spec`,`pinyin`,`status`,`is_equip`,`can_sale`,`is_virtual`,`stock_price`,`purchase_price`,`sale_price`,`brand_id`,`category_id`,`warehouse_id`,`org_id`,`tp`) values (1,'2015-05-22','9999-12-31','zhugl','chengcai','2015-05-22 22:03:36','2015-06-29 21:18:44','IT00001','','出差申请','差旅【费用报销】需有出差申请',NULL,1,0,0,1,NULL,NULL,NULL,NULL,1,2,NULL,'80'),(2,'2015-05-23','9999-12-31','zhugl',NULL,'2015-05-23 07:47:02','2015-06-14 13:33:05','IT00002','','戴尔（DELL）Inspiron 3455-R1248 灵越23.8英寸一体电脑 ','E2-7110 4G 500G WIFI 蓝牙 WIN8.1 3年上门',NULL,1,1,0,0,'4512.8205','5280.0000',NULL,2,3,3,NULL,'10'),(3,'2015-05-24','9999-12-31','zhugl','chengcai','2015-05-24 15:13:47','2015-06-29 21:23:43','IT00003','','用车申请','请提前24小时申请',NULL,1,0,0,1,NULL,NULL,NULL,NULL,1,NULL,NULL,'80'),(4,'2015-06-03','9999-12-31','zhugl','caojufang','2015-06-03 21:23:43','2015-07-17 12:29:02','IT00004','','福光杯子','500ml 真空保温',NULL,1,0,0,0,'27.3504','32.0000',NULL,NULL,NULL,NULL,NULL,'10'),(5,'2015-06-03','9999-12-31','zhugl',NULL,'2015-06-03 21:43:33','2015-06-03 21:43:33','IT00005','','手套','',NULL,1,0,1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10'),(6,'2015-06-11','9999-12-31','zhugl','chengcai','2015-06-11 22:36:17','2015-06-29 21:40:04','IT00006','','2号楼3楼大会议室','投影、话筒、视频会议、白板',NULL,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'20'),(40,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9001',NULL,'陕西红富士苹果','#80',NULL,1,0,1,0,'5.6000',NULL,NULL,NULL,NULL,11,NULL,'10'),(41,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9002',NULL,'丰水梨','#75',NULL,1,0,1,0,'8.2000',NULL,NULL,NULL,NULL,11,NULL,'10'),(42,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9003',NULL,'冰糖心富士','#80',NULL,1,0,1,0,'9.5000',NULL,NULL,NULL,NULL,11,NULL,'10'),(43,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9004',NULL,'常香玉','',NULL,1,0,1,0,'6.5000',NULL,NULL,NULL,NULL,11,NULL,'10'),(44,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9005',NULL,'砀山梨','',NULL,1,0,1,0,'7.8000',NULL,NULL,NULL,NULL,11,NULL,'10'),(45,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9006',NULL,'赣南橙','',NULL,1,0,1,0,'6.9000',NULL,NULL,NULL,NULL,11,NULL,'10'),(46,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9007',NULL,'红毛丹','',NULL,1,0,1,0,'12.6000',NULL,NULL,NULL,NULL,11,NULL,'10'),(47,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9008',NULL,'红心火龙果','',NULL,1,0,1,0,'8.2000',NULL,NULL,NULL,NULL,11,NULL,'10'),(48,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9009',NULL,'黄圣女果','',NULL,1,0,1,0,'8.9000',NULL,NULL,NULL,NULL,11,NULL,'10'),(49,NULL,NULL,NULL,NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','IT9010',NULL,'国产柠檬','',NULL,1,0,1,0,'14.6000',NULL,NULL,NULL,NULL,11,NULL,'10'),(52,NULL,NULL,NULL,NULL,'2015-06-17 21:29:52','2015-06-17 21:29:52','IT9981',NULL,'PZ-30配电箱','',NULL,1,0,1,0,NULL,'210.4500','320.0000',NULL,NULL,NULL,NULL,'10'),(53,NULL,NULL,NULL,NULL,'2015-06-27 19:19:52','2015-06-27 19:19:52','IT5001',NULL,'联想T440笔记本电脑','14寸双核4G内存1T硬盘',NULL,1,0,1,0,NULL,'6219.0000','7150.0000',NULL,NULL,NULL,NULL,'10'),(54,NULL,NULL,NULL,NULL,'2015-06-27 19:21:33','2015-06-27 19:21:33','IT5002',NULL,'戴尔M-10塔式服务器','9核16G内存500G硬盘',NULL,1,0,1,0,NULL,'8125.0000','9999.0000',NULL,NULL,NULL,NULL,'10'),(55,NULL,NULL,NULL,NULL,'2015-06-27 20:06:15','2015-07-17 12:29:02','IT5003',NULL,'格力电风扇','遥控功能，1.2m高',NULL,1,0,1,0,'255.5556','299.0000',NULL,NULL,NULL,NULL,NULL,'10'),(56,NULL,NULL,NULL,NULL,'2015-06-27 20:58:04','2015-06-27 20:58:04','IT5004',NULL,'进口红蛇果','#85',NULL,1,0,1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'10'),(57,'2015-06-29','9999-12-31','chengcai','chengcai','2015-06-29 21:02:51','2015-06-29 21:16:37','IT00057','','加班申请','加班时长可调休',NULL,1,0,0,1,NULL,NULL,NULL,NULL,NULL,2,NULL,'80'),(58,'2015-06-29','9999-12-31','chengcai','chengcai','2015-06-29 21:03:37','2015-06-29 21:16:46','IT00058','','调休申请','调休申请需要有加班单据，请在【参考工单】中选择加班单据',NULL,1,0,0,1,NULL,NULL,NULL,NULL,NULL,2,NULL,'80'),(59,'2015-06-29','9999-12-31','chengcai','chengcai','2015-06-29 21:06:13','2015-06-29 21:16:56','IT00059','','休假申请','请注明休假类别：年假、病假、事假、婚假、丧假、探亲假',NULL,1,0,0,1,NULL,NULL,NULL,NULL,NULL,2,NULL,'80'),(60,'2015-06-29','9999-12-31','chengcai','chengcai','2015-06-29 21:13:47','2015-06-29 21:27:04','IT00060','','入职办理','员工入职办理手续',NULL,1,0,0,1,NULL,NULL,NULL,NULL,NULL,2,NULL,'80'),(61,'2015-06-29','9999-12-31','chengcai','chengcai','2015-06-29 21:22:36','2015-06-29 22:02:04','IT00061','','用印申请','公章、法人章、人事章、财务章、合同章、投标章、采购章',NULL,1,0,0,1,NULL,NULL,NULL,NULL,NULL,2,NULL,'80'),(62,'2015-06-29','9999-12-31','chengcai','chengcai','2015-06-29 21:33:14','2015-06-29 21:42:26','IT00062','','收入证明','收入证明有效期为2个月',NULL,1,0,0,1,NULL,NULL,NULL,NULL,1,2,NULL,'80'),(63,'2015-06-29','9999-12-31','chengcai','chengcai','2015-06-29 21:38:11','2015-06-30 20:07:48','IT00063','','离职办理','请提前30天提出申请',NULL,1,0,0,1,NULL,NULL,NULL,NULL,NULL,2,NULL,'80'),(64,'2015-06-30','9999-12-31','chengcai',NULL,'2015-06-30 20:09:12','2015-06-30 20:09:12','IT00064','','培训申请','外部培训3000元以上需签订服务期协议',NULL,1,0,0,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'80');

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
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_material_measure` */

insert  into `basedata_material_measure`(`id`,`material_id`,`measure_id`) values (49,1,8),(5,2,9),(51,3,8),(10,4,1),(9,5,1),(56,6,1),(23,40,3),(24,41,3),(25,42,3),(26,43,3),(27,44,3),(28,45,3),(29,46,3),(30,47,3),(31,48,3),(32,49,3),(45,57,8),(46,58,8),(47,59,8),(52,60,8),(59,61,8),(58,62,8),(60,63,8),(61,64,8);

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
  `org_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_partner_9cf869aa` (`org_id`),
  CONSTRAINT `basedata_partner_org_id_29c57159_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_partner` */

insert  into `basedata_partner`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`partner_type`,`level`,`tax_num`,`tax_address`,`tax_account`,`contacts`,`memo`,`phone`,`org_id`) values (17,NULL,NULL,NULL,'chengcai','2015-06-27 22:27:23','2015-06-29 22:01:03','C1001','中国船舶重工业集团','中船集团','cdt','C','A','10111293847','北京市海淀区10号','北京银行海淀支行 330291837','周强','','13813898213',NULL),(18,'2015-06-30','9999-12-31','chengcai',NULL,'2015-06-30 20:22:27','2015-06-30 20:22:27','90018','京东商城','','','S','A','','','','','','',NULL);

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
  `org_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_project_partner_id_36721156_fk_basedata_partner_id` (`partner_id`),
  KEY `basedata_project_9cf869aa` (`org_id`),
  CONSTRAINT `basedata_project_org_id_5726486_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `basedata_project_partner_id_36721156_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_project` */

insert  into `basedata_project`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`status`,`prj_type`,`description`,`budget`,`income`,`expand`,`blueprint`,`offer`,`business`,`partner_id`,`org_id`) values (7,NULL,NULL,NULL,'chengcai','2015-06-27 22:39:27','2015-07-30 21:24:06','PJ-C-1001','内部运营项目','','','02','00','','50000.00',NULL,NULL,'','','',NULL,NULL),(8,NULL,NULL,NULL,NULL,'2015-06-27 22:39:27','2015-07-03 05:50:38','PJ-C-1002','办公用品分摊项目','','','03','00',NULL,NULL,NULL,NULL,'','','',NULL,NULL),(9,'2015-07-04','9999-12-31','zhangsan',NULL,'2015-07-04 11:05:59','2015-07-12 01:26:21','PJ0009','中海洋船舶工业集团张江工业园配电柜项目','','','03','00','',NULL,NULL,NULL,'','','',NULL,NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_project_users` */

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_valuelist` */

insert  into `basedata_valuelist`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`status`,`init`,`locked`,`lock_time`,`locked_by_id`,`module_id`) values (10,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 09:58:32','2015-05-03 08:16:48','gender','性别',1,0,0,NULL,NULL,2),(11,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 10:31:10','2015-05-03 07:08:51','S011','地址类型',1,0,0,NULL,NULL,2),(12,'2015-05-02','9999-12-31','zhugl','zhugl','2015-05-02 10:00:30','2015-05-03 07:08:44','S012','项目状态',1,0,0,NULL,NULL,2),(13,'2015-05-02','9999-12-31','zhugl','zhugl','2015-05-02 10:03:27','2015-05-03 07:08:28','S013','项目类别',1,0,0,NULL,NULL,2),(14,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 06:49:41','2015-05-03 06:49:41','S014','岗位序列',1,0,0,NULL,NULL,2),(15,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 06:56:08','2015-05-09 15:41:55','S015','岗位级别',1,0,0,NULL,NULL,2),(16,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:13:31','2015-05-03 07:13:31','S016','人员状态',1,0,0,NULL,NULL,2),(17,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 07:19:43','2015-05-03 07:19:50','S017','职员级别',1,0,0,NULL,NULL,2),(18,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:22:10','2015-05-03 07:22:10','S018','人员类别',1,0,0,NULL,NULL,2),(19,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 07:24:00','2015-05-03 15:12:54','S019','用工形式',1,0,0,NULL,NULL,2),(20,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:33:41','2015-05-03 07:33:41','S020','宗教信仰',1,0,0,NULL,NULL,2),(21,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 07:42:12','2015-05-03 08:32:32','S021','民族',1,0,0,NULL,NULL,2),(22,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 07:54:20','2015-05-03 07:54:20','S022','国家',1,0,0,NULL,NULL,2),(23,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:00:47','2015-05-03 08:33:02','S023','婚姻状况',1,0,0,NULL,NULL,2),(24,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:11:20','2015-05-03 08:32:51','S024','文化程度',1,0,0,NULL,NULL,2),(25,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:26:49','2015-05-03 08:32:42','S025','家庭关系',1,0,0,NULL,NULL,2),(26,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:39:02','2015-05-03 08:43:11','S026','政治面貌',1,0,0,NULL,NULL,2),(27,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:41:44','2015-05-03 08:41:44','S027','兵役状况',1,0,0,NULL,NULL,2),(28,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:44:29','2015-05-03 08:44:29','S028','血型',1,0,0,NULL,NULL,2),(29,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:51:03','2015-05-03 08:51:03','S029','人员身份',1,0,0,NULL,NULL,2),(30,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:52:49','2015-05-03 08:52:49','S030','合同类型',1,0,0,NULL,NULL,2),(31,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:54:11','2015-05-03 08:54:19','S031','合同期限类型',1,0,0,NULL,NULL,2),(32,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 08:55:13','2015-05-03 08:56:32','S032','合同密级',1,0,0,NULL,NULL,2),(33,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:56:17','2015-05-03 08:56:17','S033','合同变动类型',1,0,0,NULL,NULL,2),(34,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 08:58:32','2015-05-03 08:58:32','S034','工时制度',1,0,0,NULL,NULL,2),(35,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 09:56:24','2015-05-03 09:56:24','S035','教育类型',1,0,0,NULL,NULL,2),(36,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 10:02:20','2015-05-03 10:02:38','S036','从学单位类别',1,0,0,NULL,NULL,2),(37,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 10:13:32','2015-05-03 10:16:48','S037','学位',1,0,0,NULL,NULL,2),(38,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 10:16:17','2015-05-03 10:17:06','S038','专业类别',1,0,0,NULL,NULL,2),(39,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 13:41:51','2015-05-03 13:41:51','S039','复转军人标识',1,0,0,NULL,NULL,2),(40,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 14:04:26','2015-05-03 14:07:50','S040','党委负责人标识',1,0,0,NULL,NULL,2),(41,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 14:07:37','2015-05-03 14:08:16','S041','董事监事标识',1,0,0,NULL,NULL,2),(42,'2015-05-03','9999-12-31','zhugl','zhugl','2015-05-03 14:14:35','2015-05-03 14:18:08','S042','特殊工种',1,0,0,NULL,NULL,2),(43,'2015-05-03','9999-12-31','zhugl',NULL,'2015-05-03 14:21:31','2015-05-03 14:21:31','S043','身体状况',1,0,0,NULL,NULL,2),(44,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 22:38:58','2015-05-25 20:58:34','S044','工单类型',1,0,0,NULL,NULL,2),(45,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 22:41:19','2015-05-25 20:26:41','S045','业务域',1,0,0,NULL,NULL,4),(46,'2015-05-22','9999-12-31','zhugl','zhugl','2015-05-22 22:44:49','2015-05-24 20:07:18','S046','工单状态',1,0,0,NULL,NULL,4),(47,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 20:04:37','2015-05-24 20:06:09','S047','试用期',1,1,1,NULL,NULL,3),(48,'2015-05-24','9999-12-31','zhugl',NULL,'2015-05-24 20:11:06','2015-05-24 20:11:06','S048','工资项类别',1,0,0,NULL,NULL,3),(49,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 20:13:08','2015-05-24 20:13:15','S049','增减属性',1,0,0,NULL,NULL,3),(50,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 20:20:10','2015-05-24 20:37:22','S050','计算方式',1,0,0,NULL,NULL,3),(51,'2015-05-24','9999-12-31','zhugl','zhugl','2015-05-24 21:32:21','2015-05-24 21:32:31','S051','离职类别',1,0,0,NULL,NULL,3),(52,'2015-06-03','9999-12-31','zhugl',NULL,'2015-06-03 20:01:03','2015-06-03 20:01:03','S052','税率',1,0,0,NULL,NULL,5),(53,'2015-06-14','9999-12-31','zhugl','zhugl','2015-06-14 11:09:43','2015-06-14 12:43:38','S053','发票类别 ',1,0,0,NULL,NULL,6),(54,'2015-06-20','9999-12-31','zhugl','zhugl','2015-06-20 21:33:08','2015-06-21 11:30:19','S054','物料性质',1,0,0,NULL,NULL,2);

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
) ENGINE=InnoDB AUTO_INCREMENT=416 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_valuelistitem` */

insert  into `basedata_valuelistitem`(`id`,`group_code`,`code`,`name`,`status`,`weight`,`group_id`) values (13,'S011','01','送货地址',1,9,11),(14,'S011','02','发票地址',1,9,11),(15,'S011','03','临时地址',1,9,11),(16,'S011','04','家庭地址',0,9,11),(17,'S012','00','跟踪/新建',1,1,12),(18,'S012','01','投标/报价',1,2,12),(19,'S012','02','签订合同',1,3,12),(20,'S012','03','生产/交付',1,4,12),(21,'S012','04','验收/回款',1,5,12),(22,'S012','99','关闭',1,6,12),(23,'S013','00','产品/服务交付类',1,9,13),(24,'S013','10','技术/设备改造类',1,9,13),(25,'S013','20','内部运营类',1,9,13),(26,'S013','40','其他临时项目',1,9,13),(27,'S014','A','管理/行政类',1,9,14),(28,'S014','S','营销/市场类',1,9,14),(29,'S014','T','技术/研发类',1,9,14),(30,'S014','P','生产/操作类',1,9,14),(31,'S015','01','员级',1,9,15),(32,'S015','02','初级',1,9,15),(33,'S015','03','中级',1,9,15),(34,'S015','04','高级',1,9,15),(35,'S015','05','专家',1,9,15),(36,'S016','10','在岗工作',1,9,16),(37,'S016','11','见习期（试用）',1,9,16),(38,'S016','12','待岗',1,9,16),(39,'S016','20','离职',1,9,16),(40,'S016','21','退休',1,9,16),(41,'S016','22','终止劳动合同',1,9,16),(42,'S016','23','协商解除劳动合同',1,9,16),(43,'S016','24','劳动者主张解除劳动合同',1,9,16),(44,'S016','25','用人单位主张解除劳动合同',1,9,16),(45,'S016','30','死亡',1,9,16),(46,'S017','10','领导班子',1,9,17),(47,'S017','11','副总师（助理）',1,9,17),(48,'S017','12','部门负责人（正职）',1,9,17),(49,'S017','13','部门负责人（副职）',1,9,17),(50,'S017','14','部门内设机构负责人（正职）',1,9,17),(51,'S017','15','部门内设机构负责人（副职）',1,9,17),(52,'S017','20','一级职员',1,9,17),(53,'S017','21','二级职员',1,9,17),(54,'S017','22','三级职员',1,9,17),(55,'S017','23','四级职员',1,9,17),(56,'S017','24','五级职员',1,9,17),(57,'S017','25','六级职员',1,9,17),(58,'S017','26','七级职员',1,9,17),(59,'S017','27','八级职员',1,9,17),(60,'S018','10','经营者',1,9,18),(61,'S018','20','中层管理人员',1,9,18),(62,'S018','21','一般管理人员',1,9,18),(63,'S018','30','专业技术人员',1,9,18),(64,'S018','40','技能人员',1,9,18),(65,'S018','50','服务人员',1,9,18),(66,'S018','90','其他人员',1,9,18),(67,'S019','1','劳动合同制（长期）',1,9,19),(68,'S019','2','劳动合同制（短期）',1,9,19),(69,'S019','3','人事代理制',1,9,19),(70,'S019','4','劳务派遣制',1,9,19),(71,'S019','5','非全日制',1,9,19),(72,'S019','6','业务外包',1,9,19),(73,'S019','9','其他',1,9,19),(74,'S020','00','无宗教信仰',1,9,20),(75,'S020','10','佛教',1,9,20),(76,'S020','20','喇嘛教',1,9,20),(77,'S020','30','道教',1,9,20),(78,'S020','40','天主教',1,9,20),(79,'S020','50','基督教',1,9,20),(80,'S020','70','东正教',1,9,20),(81,'S020','80','伊斯兰教',1,9,20),(82,'S020','99','其他',1,9,20),(83,'S021','01','汉族',1,9,21),(84,'S021','02','蒙古族',1,9,21),(85,'S021','03','回族',1,9,21),(86,'S021','04','藏族',1,9,21),(87,'S021','05','维吾尔族',1,9,21),(88,'S021','06','苗族',1,9,21),(89,'S021','07','彝族',1,9,21),(90,'S021','08','壮族',1,9,21),(91,'S021','09','布依族',1,9,21),(92,'S021','10','朝鲜族',1,9,21),(93,'S021','11','满族',1,9,21),(94,'S022','CN','中国',1,9,22),(95,'S022','EG','埃及',1,9,22),(96,'S022','AT','奥地利',1,9,22),(97,'S022','AU','澳大利亚',1,9,22),(98,'S022','PK','巴基斯坦',1,9,22),(99,'S022','BR','巴西',1,9,22),(100,'S022','KP','北朝鲜',1,9,22),(101,'S022','BE','比利时',1,9,22),(102,'S022','IS','冰岛',1,9,22),(103,'S022','PL','波兰',1,9,22),(104,'S022','DK','丹麦',1,9,22),(105,'S022','DE','德国',1,9,22),(106,'S022','FR','法国',1,9,22),(107,'S022','KR','韩国',1,9,22),(108,'S022','NL','荷兰',1,9,22),(109,'S022','CA','加拿大',1,9,22),(110,'S022','US','美国',1,9,22),(111,'S022','JP','日本',1,9,22),(112,'S022','TW','中国台湾',1,9,22),(113,'S022','HK','中国香港',1,9,22),(114,'S022','ES','西班牙',1,9,22),(115,'S022','GR','希腊',1,9,22),(116,'S022','SG','新加坡',1,9,22),(117,'S022','NZ','新西兰',1,9,22),(118,'S022','IT','意大利',1,9,22),(119,'S022','GB','英国',1,9,22),(120,'S022','MO','中国澳门',1,9,22),(121,'S022','IL','以色列',1,9,22),(122,'S023','10','未婚',1,9,23),(123,'S023','20','初婚',1,9,23),(124,'S023','21','再婚',1,9,23),(125,'S023','22','复婚',1,9,23),(126,'S023','30','丧偶',1,9,23),(127,'S023','40','离婚',1,9,23),(128,'S023','90','其他',1,9,23),(129,'S024','0','研究生',1,9,24),(132,'S024','10','大学本科',1,9,24),(136,'S024','20','大学专科和专科学校',1,9,24),(144,'S024','40','技工学校',1,9,24),(146,'S024','50','高中',1,9,24),(147,'S024','60','初中',1,9,24),(148,'S024','70','小学',1,9,24),(149,'S024','80','文盲或半文盲',1,9,24),(150,'gender','0','未知的性别',1,9,10),(151,'gender','1','男性',1,9,10),(152,'gender','2','女性',1,9,10),(153,'gender','9','未说明的性别',1,9,10),(154,'S025','11','丈夫',1,9,25),(155,'S025','12','妻子',1,9,25),(156,'S025','21','独生子',1,9,25),(157,'S025','22','长子',1,9,25),(158,'S025','23','次子',1,9,25),(159,'S025','24','三子',1,9,25),(160,'S025','25','四子',1,9,25),(161,'S025','26','五子',1,9,25),(162,'S025','27','养子或继子',1,9,25),(163,'S025','28','女婿',1,9,25),(164,'S025','31','独生女',1,9,25),(165,'S025','32','长女',1,9,25),(166,'S025','33','次女',1,9,25),(167,'S025','34','三女',1,9,25),(168,'S025','35','四女',1,9,25),(169,'S025','36','五女',1,9,25),(170,'S025','37','养女或继女',1,9,25),(171,'S025','51','父亲',1,9,25),(172,'S025','52','母亲',1,9,25),(173,'S025','53','公公',1,9,25),(174,'S025','54','婆婆',1,9,25),(175,'S025','55','岳父',1,9,25),(176,'S025','56','岳母',1,9,25),(177,'S025','57','继父或养父',1,9,25),(178,'S025','58','继母或养母',1,9,25),(179,'S025','71','兄',1,9,25),(180,'S025','72','嫂',1,9,25),(181,'S025','73','弟',1,9,25),(182,'S025','74','弟媳',1,9,25),(183,'S025','75','姐姐',1,9,25),(184,'S025','76','姐夫',1,9,25),(185,'S025','77','妹妹',1,9,25),(186,'S025','78','妹夫',1,9,25),(187,'S026','01','中国共产党党员',1,9,26),(188,'S026','02','中国共产党预备党员',1,9,26),(189,'S026','03','中国共产主义青年团团员',1,9,26),(190,'S026','04','中国国民党革命委员会会员',1,9,26),(191,'S026','05','中国民主同盟盟员',1,9,26),(192,'S026','06','中国民主建国会会员',1,9,26),(193,'S026','07','中国民主促进会会员',1,9,26),(194,'S026','08','中国农工民主党党员',1,9,26),(195,'S026','09','中国致公党党员',1,9,26),(196,'S026','10','九三学社社员',1,9,26),(197,'S026','11','台湾民主自治同盟盟员',1,9,26),(198,'S026','12','无党派民主人士',1,9,26),(199,'S026','13','群众',1,9,26),(200,'S027','0','未服兵役',1,9,27),(201,'S027','1','退出现役',1,9,27),(202,'S027','2','士兵预备役',1,9,27),(203,'S027','3','军官预备役',1,9,27),(204,'S027','4','服现役',1,9,27),(205,'S027','9','其他',1,9,27),(206,'S028','0','不明',1,9,28),(207,'S028','1','A型',1,9,28),(208,'S028','2','B型',1,9,28),(209,'S028','3','O型',1,9,28),(210,'S028','4','AB型',1,9,28),(211,'S028','9','其他',1,9,28),(212,'S029','11','国家公务员',1,9,29),(213,'S029','13','专业技术人员',1,9,29),(214,'S029','17','职员',1,9,29),(215,'S029','21','企业管理人员',1,9,29),(216,'S029','24','工人',1,9,29),(217,'S029','27','农民',1,9,29),(218,'S029','31','学生',1,9,29),(219,'S029','37','现役军人',1,9,29),(220,'S029','51','自由职业者',1,9,29),(221,'S029','54','个人经营者',1,9,29),(222,'S029','70','无业人员',1,9,29),(223,'S029','80','退（离）休人员',1,9,29),(224,'S029','90','其他',1,9,29),(225,'S030','1','劳动合同',1,9,30),(226,'S030','2','岗位聘用合同',1,9,30),(227,'S030','3','聘任合同',1,9,30),(228,'S030','9','其他',1,9,30),(229,'S031','1','有固定期限',1,9,31),(230,'S031','2','无固定期限',1,9,31),(231,'S031','3','以任务为限',1,9,31),(232,'S031','9','其他',1,9,31),(233,'S032','1','严格保密',1,9,32),(234,'S032','2','需要保密',1,9,32),(235,'S032','3','无需保密',1,9,32),(236,'S033','01','初定',1,9,33),(237,'S033','02','续订',1,9,33),(238,'S033','03','变更',1,9,33),(239,'S033','04','终止',1,9,33),(240,'S033','05','解除',1,9,33),(241,'S034','1','定时',1,9,34),(242,'S034','2','不定时',1,9,34),(243,'S034','3','综合计算工时',1,9,34),(244,'S035','10','研究生教育',1,9,35),(245,'S035','20','大学本科教育',1,9,35),(246,'S035','30','大学专科教育',1,9,35),(247,'S035','40','中等职业教育',1,9,35),(248,'S035','60','普通高级中学教育',1,9,35),(249,'S035','70','初级中学教育',1,9,35),(250,'S035','80','小学教育',1,9,35),(251,'S035','90','其他',1,9,35),(252,'S035','99','非学历教育',1,9,35),(254,'S036','11','全日制小学',1,9,36),(255,'S036','12','全日制中学',1,9,36),(256,'S036','13','全日制中专',1,9,36),(257,'S036','14','全日制高等学校',1,9,36),(259,'S036','41','国家行政学院',1,9,36),(260,'S036','42','省行政学院',1,9,36),(261,'S036','49','其他行政学院（校）',1,9,36),(262,'S036','71','中央党校',1,9,36),(263,'S036','72','省委党校',1,9,36),(264,'S036','73','地、市委党校',1,9,36),(265,'S036','81','军队（武警）高等院校',1,9,36),(266,'S036','82','军队（武警）中等专科学校',1,9,36),(267,'S036','83','军队（武警）党校',1,9,36),(268,'S036','84','军队（武警）科研机构',1,9,36),(269,'S036','85','军队（武警）医院',1,9,36),(270,'S037','1','名誉博士 ',1,9,37),(271,'S037','2','博士',1,9,37),(272,'S037','3','硕士',1,9,37),(273,'S037','4','学士',1,9,37),(274,'S037','5','双学士',1,9,37),(275,'S038','01','哲学',1,9,38),(276,'S038','02','经济学',1,9,38),(277,'S038','03','法学',1,9,38),(278,'S038','04','教育学',1,9,38),(279,'S038','05','文学',1,9,38),(280,'S038','06','历史学',1,9,38),(281,'S038','07','理学',1,9,38),(282,'S038','08','工学',1,9,38),(283,'S038','09','农学',1,9,38),(284,'S038','10','医学',1,9,38),(285,'S038','11','军事学',1,9,38),(286,'S038','12','管理学',1,9,38),(287,'S038','14','建筑学',1,9,38),(288,'S037','9','其他',1,9,37),(289,'S038','99','其他',1,9,38),(290,'S039','15','复员干部',1,9,39),(291,'S039','10','军转干部',1,9,39),(292,'S039','20','转业士官',1,9,39),(293,'S039','30','复员士官',1,9,39),(294,'S039','40','退役士兵',1,9,39),(295,'S039','99','非复转军人',1,9,39),(296,'S040','1','党委（党组）书记',1,9,40),(297,'S040','2','党委（党组）副书记',1,9,40),(298,'S040','3','党委常委（党组成员）',1,9,40),(299,'S040','4','纪委书记（纪检组组长）',1,9,40),(300,'S040','6','工会主席',1,9,40),(301,'S040','8','其他党委（党组）负责人',1,9,40),(302,'S040','9','非党委负责人',1,9,40),(303,'S041','010101','董事长',1,9,41),(304,'S041','010102','副董事长',1,9,41),(305,'S041','010103','董事',1,9,41),(306,'S041','010104','职工董事',1,9,41),(307,'S041','0201','监事会主席',1,9,41),(308,'S041','0202','监事会副主席',1,9,41),(309,'S041','0203','监事',1,9,41),(310,'S041','0204','国资委派出监事',1,9,41),(311,'S041','0205','职工监事',1,9,41),(312,'S041','00','非董事监事',1,9,41),(313,'S042','00','非特殊工种',1,9,42),(314,'S042','11','汽机运行值班工',1,9,42),(315,'S042','12','锅炉运行值班工',1,9,42),(316,'S042','13','燃料运行值班工',1,9,42),(317,'S042','14','锅炉本体检修工',1,9,42),(318,'S042','15','保温工',1,9,42),(319,'S042','16','钢球磨煤机及制粉系统检修工',1,9,42),(320,'S042','17','水轮机检修工',1,9,42),(321,'S042','6','其他（由地方社会保障部门认可的特殊工种）',1,9,42),(322,'S042','21','锅炉本体安装工',1,9,42),(323,'S042','22','管道安装工',1,9,42),(324,'S042','23','筑炉瓦工',1,9,42),(325,'S042','24','装模工',1,9,42),(326,'S042','31','水轮机安装工',1,9,42),(327,'S042','32','采石工',1,9,42),(328,'S042','33','爆破',1,9,42),(329,'S042','34','石料粉碎工',1,9,42),(330,'S042','35','潜水员',1,9,42),(331,'S042','35','轮机工',1,9,42),(332,'S042','37','水手',1,9,42),(333,'S042','41','翻砂铸造工',1,9,42),(334,'S042','42','喷砂工',1,9,42),(335,'S042','43','镀锌工',1,9,42),(336,'S042','44','电镀工',1,9,42),(337,'S042','45','印刷线路制板工',1,9,42),(338,'S042','46','浸漆工',1,9,42),(339,'S042','47','电焊条制作工',1,9,42),(340,'S042','48','注塑工',1,9,42),(341,'S042','49','铆工',1,9,42),(342,'S042','51','混凝土工',1,9,42),(343,'S042','52','钢筋工',1,9,42),(344,'S042','53','架子工',1,9,42),(345,'S042','54','推土机司机',1,9,42),(346,'S042','55','挖土机司机',1,9,42),(347,'S042','56','重型载重汽车司机',1,9,42),(348,'S042','57','野外勘测工',1,9,42),(349,'S042','58','沥青工',1,9,42),(350,'S042','59','环氧树脂工',1,9,42),(351,'S043','1','健康或良好',1,9,43),(352,'S043','2','一般或较弱',1,9,43),(353,'S043','3','有慢性病（一）',1,9,43),(354,'S043','4','有慢性病（二）',1,9,43),(355,'S043','6','残疾',1,9,43),(356,'S043','7','军残',1,9,43),(357,'S044','S','内部服务',1,9,44),(358,'S044','R','设备维修',1,9,44),(359,'S044','Q','问题咨询',1,9,44),(360,'S045','HR','人事',1,1,45),(361,'S045','FI','财务',1,2,45),(362,'S045','AD','行政',1,4,45),(363,'S045','MA','市场',1,4,45),(364,'S045','BU','商务',1,5,45),(365,'S045','CS','客服',1,6,45),(366,'S045','OT','其他',1,7,45),(367,'S046','NEW','新建',1,9,46),(368,'S046','SCHE','调度',1,9,46),(369,'S046','PROC','处理',1,9,46),(370,'S046','CLOSE','关闭',1,9,46),(371,'S044','D','采购申请',1,9,44),(372,'S047','0','无试用期',1,1,47),(373,'S047','1','1个月',1,2,47),(374,'S047','2','2个月',1,2,47),(375,'S047','3','3个月',1,3,47),(376,'S047','4','4个月',1,4,47),(377,'S047','5','5个月',1,5,47),(378,'S047','6','6个月',1,6,47),(379,'S047','12','1年',1,12,47),(380,'S048','10','工资',1,9,48),(381,'S048','20','社保',1,9,48),(382,'S048','30','奖金',1,9,48),(383,'S048','40','福利',1,9,48),(384,'S048','99','其他',1,9,48),(385,'S049','+','增加',1,9,49),(386,'S049','-','扣款',1,9,49),(387,'S050','10','固定值',1,9,50),(388,'S050','20','比例值',1,9,50),(390,'S050','30','计算值',1,9,50),(391,'S051','10','个人辞职',1,9,51),(392,'S051','20','合同到期',1,9,51),(393,'S051','30','公司辞退',1,9,51),(394,'S051','40','人员死亡',1,9,51),(395,'S051','50','法定退休',1,9,51),(396,'S051','60','其他',1,9,51),(397,'S045','PO','采购',1,3,45),(398,'S052','0.00','0%',1,9,52),(399,'S052','0.03','3%',1,9,52),(400,'S052','0.05','5%',1,9,52),(401,'S052','0.07','7%',1,9,52),(402,'S052','0.10','10%',1,9,52),(403,'S052','0.17','17%',1,9,52),(404,'S053','10','普通发票',1,9,53),(405,'S053','20','增值税专用发票',1,9,53),(406,'S053','30','专业发票',1,9,53),(407,'S054','10','生产物料',1,9,54),(408,'S054','20','建筑物/培训室',1,9,54),(409,'S054','30','员工宿舍',1,9,54),(410,'S054','40','工卡/饭卡',1,9,54),(411,'S054','50','车辆',1,9,54),(412,'S054','60','图书',1,9,54),(413,'S054','70','工位',1,9,54),(414,'S054','80','工单服务',1,9,54),(415,'S054','11','办公用品',1,9,54);

/*Table structure for table `basedata_warehouse` */

DROP TABLE IF EXISTS `basedata_warehouse`;

CREATE TABLE `basedata_warehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `location` varchar(120) DEFAULT NULL,
  `org_id` int(11),
  PRIMARY KEY (`id`),
  KEY `basedata_warehouse_9cf869aa` (`org_id`),
  CONSTRAINT `basedata_warehouse_org_id_1160a0d2_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `basedata_warehouse` */

insert  into `basedata_warehouse`(`id`,`code`,`name`,`status`,`location`,`org_id`) values (1,'A01','电力信息一号库',1,'',NULL),(2,'A02','内部运营服务',1,'',NULL),(3,'A03','办公用品仓库',1,'',NULL),(11,'FR','水果库',1,NULL,NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `basedata_workexperience` */

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
) ENGINE=InnoDB AUTO_INCREMENT=1148 DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

insert  into `django_admin_log`(`id`,`action_time`,`object_id`,`object_repr`,`action_flag`,`change_message`,`content_type_id`,`user_id`) values (986,'2015-06-28 06:19:13','18','用户信息',3,'',75,11),(987,'2015-06-28 06:19:51','19','用户信息导入',1,'',75,11),(988,'2015-06-28 06:21:08','19','用户信息导入',2,'已修改 attach 。',75,11),(989,'2015-06-28 07:27:18','1','规章制度-考勤手册',1,'',76,11),(990,'2015-06-28 07:40:49','1','职员',2,'已修改 permissions 。',3,11),(991,'2015-06-28 08:16:44','1','【模板文档】-【基础数据】-1001部门岗位员工导入模板',2,'已修改 title，keywords，description，tp 和 attach 。',76,11),(992,'2015-06-28 08:18:34','1','【模板文档】-【基础数据】-1001部门岗位员工导入模板',2,'已修改 description 。',76,11),(993,'2015-06-28 08:20:33','1','【模板文档】-【基础数据】-1001部门岗位员工导入模板',2,'已修改 description 。',76,11),(994,'2015-06-28 08:21:18','1','【模板文档】-【基础数据】-1001部门岗位员工导入模板',2,'已修改 description 。',76,11),(995,'2015-06-28 08:23:01','2','【模板文档】-【基础数据】-1002期初库存导入模板',1,'',76,11),(996,'2015-06-28 08:23:55','2','【模板文档】-【基础数据】-1002期初库存导入模板',2,'已修改 description 。',76,11),(997,'2015-06-28 08:26:09','2','【模板文档】-【基础数据】-1002期初库存导入模板',2,'已修改 description 。',76,11),(998,'2015-06-28 08:27:02','2','【模板文档】-【基础数据】-1002期初库存导入模板',2,'已修改 description 。',76,11),(999,'2015-06-28 08:30:17','3','【模板文档】-【基础数据】-1003合作伙伴导入模板',1,'',76,11),(1000,'2015-06-28 08:31:03','3','【模板文档】-【基础数据】-1003合作伙伴导入模板',2,'已修改 description 。',76,11),(1001,'2015-06-28 08:32:25','4','【模板文档】-【基础数据】-1004项目信息导入模板',1,'',76,11),(1002,'2015-06-28 08:32:33','3','【模板文档】-【基础数据】-1003合作伙伴导入模板',2,'已修改 tp 。',76,11),(1003,'2015-06-28 08:32:43','2','【模板文档】-【基础数据】-1002期初库存导入模板',2,'已修改 tp 。',76,11),(1004,'2015-06-28 08:35:37','5','【模板文档】-【基础数据】-1005用户信息导入模板',1,'',76,11),(1005,'2015-06-28 08:35:59','5','【模板文档】-【基础数据】-1005用户信息导入模板',2,'已修改 tp 。',76,11),(1006,'2015-06-28 08:39:50','6','【模板文档】-【明细数据】-2001报价单明细导入模板',1,'',76,11),(1007,'2015-06-28 08:44:03','6','【模板文档】-【明细数据】-2001报价单明细导入模板',2,'已修改 description 。',76,11),(1008,'2015-06-28 08:45:56','6','【模板文档】-【明细数据】-2001报价单明细导入模板',2,'已修改 description 。',76,11),(1009,'2015-06-28 08:47:41','7','【模板文档】-【明细数据】-2002需求单明细导入模板',1,'',76,11),(1010,'2015-06-28 08:48:09','7','【模板文档】-【明细数据】-2002需求单明细导入模板',2,'已修改 description 。',76,11),(1011,'2015-06-28 08:50:09','8','【模板文档】-【明细数据】-2003采购单明细导入模板',1,'',76,11),(1012,'2015-06-28 08:54:09','1','【模板文档】-【基础数据】-1001部门岗位员工导入模板',2,'已修改 description 。',76,11),(1013,'2015-06-28 08:58:43','19','用户信息导入',3,'',75,11),(1014,'2015-06-28 08:58:43','16','项目导入',3,'',75,11),(1015,'2015-06-28 08:58:43','15','合作伙伴',3,'',75,11),(1016,'2015-06-28 09:03:59','20','【上线准备】-【部门|岗位|员工】数据导入',1,'',75,11),(1017,'2015-06-28 09:06:51','20','【上线准备】-【部门|岗位|员工】数据导入',2,'已修改 description 。',75,11),(1018,'2015-06-28 09:07:25','20','【上线准备】-【部门|岗位|员工】数据导入',2,'已修改 description 。',75,11),(1019,'2015-06-28 09:07:45','20','【上线准备】-【部门|岗位|员工】数据导入',2,'已修改 description 。',75,11),(1020,'2015-06-28 09:08:36','20','【上线准备】-【部门|岗位|员工】数据导入',2,'已修改 description 。',75,11),(1021,'2015-06-28 09:09:24','21','【上线准备】-【用户信息】数据导入',1,'',75,11),(1022,'2015-06-28 09:10:16','21','【上线准备】-【用户信息】数据导入',2,'已修改 description 。',75,11),(1023,'2015-06-28 09:10:30','21','【上线准备】-【用户信息】数据导入',2,'已修改 description 。',75,11),(1024,'2015-06-28 09:11:53','21','【上线准备】-【用户信息】数据导入',2,'已修改 description 。',75,11),(1025,'2015-06-28 09:12:02','20','【上线准备】-【部门|岗位|员工】数据导入',2,'已修改 description 。',75,11),(1026,'2015-06-28 09:12:46','21','【上线准备】-【用户信息】数据导入',2,'已修改 is_clear 。',75,11),(1027,'2015-06-28 09:13:34','22','【上线准备】-【合作伙伴信息】数据导入',1,'',75,11),(1028,'2015-06-28 09:14:29','22','【上线准备】-【合作伙伴信息】数据导入',2,'已修改 description 。',75,11),(1029,'2015-06-28 09:14:45','22','【上线准备】-【合作伙伴信息】数据导入',2,'已修改 description 。',75,11),(1030,'2015-06-28 09:16:24','20','【上线准备】-【部门|岗位|员工】第一步',2,'已修改 title 。',75,11),(1031,'2015-06-28 09:16:37','21','【上线准备】-【用户信息】第二步',2,'已修改 title 。',75,11),(1032,'2015-06-28 09:16:49','22','【上线准备】-【合作伙伴信息】第三步',2,'已修改 title 。',75,11),(1033,'2015-06-28 09:18:59','23','【上线准备】-【项目信息】数据导入',1,'',75,11),(1034,'2015-06-28 09:19:11','23','【上线准备】-【项目信息】第四步',2,'已修改 title 。',75,11),(1035,'2015-06-28 09:19:28','23','【上线准备】-【项目信息】第四步（可选）',2,'已修改 title 。',75,11),(1036,'2015-06-28 09:20:20','22','【上线准备】-【合作伙伴信息】第三步',2,'已修改 description 。',75,11),(1037,'2015-06-28 09:20:48','23','【上线准备】-【项目信息】第四步（可选）',2,'已修改 description 。',75,11),(1038,'2015-06-29 21:02:51','57',' 加班申请',1,'',27,11),(1039,'2015-06-29 21:03:37','58',' 调休申请',1,'',27,11),(1040,'2015-06-29 21:03:55','58','IT00058 调休申请',2,'已修改 tp 。',27,11),(1041,'2015-06-29 21:06:13','59',' 休假申请',1,'',27,11),(1042,'2015-06-29 21:07:24','58','IT00058 调休申请',2,'已修改 spec 和 warehouse 。',27,11),(1043,'2015-06-29 21:09:02','57','IT00057 加班申请',2,'已修改 spec 。',27,11),(1044,'2015-06-29 21:13:47','60',' 入职办理',1,'',27,11),(1045,'2015-06-29 21:15:17','3','IT00003 用车申请',2,'已变更 name 和 data_type for 扩展参数 \"起始里程\". 已变更 name 和 data_type for 扩展参数 \"结束里程\". 已变更 name for 扩展参数 \"所用里程\". 已变更 name for 扩展参数 \"目的地\".',27,11),(1046,'2015-06-29 21:16:00','3','IT00003 用车申请',2,'已修改 spec 。',27,11),(1047,'2015-06-29 21:16:37','57','IT00057 加班申请',2,'已修改 is_virtual 。',27,11),(1048,'2015-06-29 21:16:46','58','IT00058 调休申请',2,'已修改 can_sale 和 is_virtual 。',27,11),(1049,'2015-06-29 21:16:56','59','IT00059 休假申请',2,'已修改 can_sale 和 is_virtual 。',27,11),(1050,'2015-06-29 21:17:15','60','IT00060 入职办理',2,'已修改 is_virtual 。',27,11),(1051,'2015-06-29 21:18:44','1','IT00001 出差申请',2,'已修改 spec 。',27,11),(1052,'2015-06-29 21:22:36','61',' 用印申请',1,'',27,11),(1053,'2015-06-29 21:23:43','3','IT00003 用车申请',2,'已修改 spec 。',27,11),(1054,'2015-06-29 21:27:04','60','IT00060 入职办理',2,'已添加 扩展参数 \"ERP系统/帐号\". 已添加 扩展参数 \"邮箱开通/邮箱地址\". 已变更 name for 扩展参数 \"员工手册/保密培训\".',27,11),(1055,'2015-06-29 21:33:14','62',' 收入证明开具',1,'',27,11),(1056,'2015-06-29 21:38:11','63',' 员工离职',1,'',27,11),(1057,'2015-06-29 21:39:13','6','IT00006 F2-H03 罗浮厅',2,'已修改 spec 。',27,11),(1058,'2015-06-29 21:40:04','6','IT00006 2号楼3楼大会议室',2,'已修改 name 。',27,11),(1059,'2015-06-29 21:42:10','62','IT00062 收入证明',2,'已修改 name 。',27,11),(1060,'2015-06-29 21:42:26','62','IT00062 收入证明',2,'已修改 spec 。',27,11),(1061,'2015-06-29 22:00:18','18',' ',3,'',14,11),(1062,'2015-06-29 22:01:03','17','中国船舶重工业集团',2,'已修改 name 和 short 。',14,11),(1063,'2015-06-29 22:02:04','61','IT00061 用印申请',2,'已修改 spec 。',27,11),(1064,'2015-06-30 20:07:48','63','IT00063 离职办理',2,'已修改 name 。',27,11),(1065,'2015-06-30 20:09:12','64',' 培训申请',1,'',27,11),(1066,'2015-06-30 20:22:27','18','京东商城',1,'',14,11),(1067,'2015-06-30 20:23:07','1',' 采购物品',1,'',59,11),(1068,'2015-06-30 20:23:36','1','CG00001 采购物品',2,'已变更 price 和 tax for 采购明细 \"POItem object\". 已变更 measure，price 和 tax for 采购明细 \"POItem object\".',59,11),(1069,'2015-07-01 05:58:07','None','1',1,'',63,11),(1070,'2015-07-01 06:17:53','2','2',1,'',63,11),(1071,'2015-07-01 06:18:24','2','2',2,'没有字段被修改。',63,11),(1072,'2015-07-01 06:29:17','2','2',2,'已修改 description 。',63,11),(1073,'2015-07-01 06:32:18','2','2',2,'已修改 description 。',63,11),(1074,'2015-07-01 06:34:14','2','2',2,'已修改 description 。',63,11),(1075,'2015-07-01 06:35:11','2','2',2,'已修改 description 。',63,11),(1076,'2015-07-01 06:35:55','2','2',2,'已修改 description 。',63,11),(1077,'2015-07-01 06:37:00','2','2',2,'已修改 description 。',63,11),(1078,'2015-07-01 06:37:21','3','123',1,'',63,11),(1079,'2015-07-01 06:46:22','2','项目审批流程',1,'',34,11),(1080,'2015-07-02 05:04:19','1','张三',2,'已修改 code，gender 和 rank 。',30,11),(1081,'2015-07-02 05:16:59','13','zhangsan',1,'',4,11),(1082,'2015-07-02 05:17:08','14','lisi',1,'',4,11),(1083,'2015-07-02 05:17:21','15','wangwu',1,'',4,11),(1084,'2015-07-02 05:17:32','16','dongyong',1,'',4,11),(1085,'2015-07-02 05:18:01','16','dongyong',2,'已修改 first_name 和 groups 。',4,11),(1086,'2015-07-02 05:18:14','14','lisi',2,'已修改 first_name 和 groups 。',4,11),(1087,'2015-07-02 05:18:32','15','wangwu',2,'已修改 first_name 和 groups 。',4,11),(1088,'2015-07-02 05:18:47','13','zhangsan',2,'已修改 first_name 和 groups 。',4,11),(1089,'2015-07-02 05:19:41','16','dongyong',2,'已修改 is_staff 。',4,11),(1090,'2015-07-02 05:19:48','14','lisi',2,'已修改 is_staff 。',4,11),(1091,'2015-07-02 05:19:54','15','wangwu',2,'已修改 is_staff 。',4,11),(1092,'2015-07-02 05:20:01','13','zhangsan',2,'已修改 is_staff 。',4,11),(1093,'2015-07-02 05:22:26','2','张三',1,'',30,11),(1094,'2015-07-02 05:23:53','2','张三',2,'已修改 birthday 和 user 。',30,11),(1095,'2015-07-02 05:24:41','1','李四',2,'已修改 name，pinyin，gender 和 user 。',30,11),(1096,'2015-07-02 05:25:23','2','张三',2,'已修改 workday 和 startday 。',30,11),(1097,'2015-07-02 05:27:10','3','王五',1,'',30,11),(1098,'2015-07-02 05:28:44','4','董永',1,'',30,11),(1099,'2015-07-02 05:44:31','5','N01-商务主管审批',2,'已修改 next_user_handler 。',35,11),(1100,'2015-07-02 06:07:37','4','1004 董永',2,'已修改 user 。',30,11),(1101,'2015-07-02 06:18:45','5','N01-商务主管审批',2,'已修改 status_field 和 status_value 。',35,11),(1102,'2015-07-02 06:19:06','6','N02-财务经理审批',2,'已修改 next_user_handler，status_field 和 status_value 。',35,11),(1103,'2015-07-02 06:19:27','7','N03-总经理审批',2,'已修改 handler_type 和 positions 。',35,11),(1104,'2015-07-02 20:50:47','5','N01-商务主管审批',2,'已修改 next 。',35,11),(1105,'2015-07-02 20:58:30','5','N01-商务主管审批',2,'已修改 next 。',35,11),(1106,'2015-07-02 21:43:08','5','N01-商务主管审批',2,'已修改 can_edit 。',35,11),(1107,'2015-07-02 21:50:00','5','N01-商务主管审批',2,'已修改 can_edit 。',35,11),(1108,'2015-07-02 21:51:23','5','N01-商务主管审批',2,'已修改 can_edit 。',35,11),(1109,'2015-07-03 05:46:47','6','N02-财务经理审批',2,'已修改 action 。',35,11),(1110,'2015-07-03 06:19:36','7','内部运营项目',2,'已修改 budget 。',19,11),(1111,'2015-07-03 06:24:43','5','N01-商务主管审批',2,'已修改 next_node_handler 。',35,11),(1112,'2015-07-03 21:28:30','9','【使用手册】-功能概述',1,'',76,11),(1113,'2015-07-03 21:28:58','10','【使用手册】-基本操作',1,'',76,11),(1114,'2015-07-03 21:29:29','11','【使用手册】-个人自助',1,'',76,11),(1115,'2015-07-03 21:29:58','12','【使用手册】-销售管理',1,'',76,11),(1116,'2015-07-03 21:30:39','13','【使用手册】-采购管理',1,'',76,11),(1117,'2015-07-03 21:31:19','14','【使用手册】-库存管理',1,'',76,11),(1118,'2015-07-03 21:31:41','15','【使用手册】-组织机构',1,'',76,11),(1119,'2015-07-03 21:32:03','16','【使用手册】-基础数据',1,'',76,11),(1120,'2015-07-03 21:32:26','17','【使用手册】-工作流管理',1,'',76,11),(1121,'2015-07-04 10:56:34','1','-申请采购办公用品一批',1,'',40,13),(1122,'2015-07-04 11:06:00','9','中海洋船舶工业集团张江工业园配电柜项目',1,'',19,13),(1123,'2015-07-04 11:58:58','2','-出差申请（重庆）',1,'',40,13),(1124,'2015-07-04 12:15:27','3','-用车申请（张江）',1,'',40,13),(1125,'2015-07-04 12:18:14','4','-用车申请（张江）',1,'',40,13),(1126,'2015-07-04 12:20:21','3','WO00003-用车申请（张江）',2,'已修改 classification 。',40,13),(1127,'2015-07-04 13:36:53','1',' 张三 2015年3月份行政部备用金 J:3000.00 Y:3000.00',1,'',43,13),(1128,'2015-07-04 13:38:14','1','15年3月份行政部费用报销',1,'',44,13),(1129,'2015-07-04 13:39:34','1','15年3月份行政部费用报销',2,'已添加 费用明细 \"ReimbursementItem object\". 已添加 费用明细 \"ReimbursementItem object\".',44,13),(1130,'2015-07-04 13:39:59','1','15年3月份行政部费用报销',2,'已修改 description 。',44,13),(1131,'2015-07-04 15:18:13','3','WO00003-用车申请（张江）',2,'已修改 classification 。',40,13),(1132,'2015-07-04 15:19:05','3','WO00003-2号楼3楼男厕所小便池堵塞',2,'已修改 title 和 description 。',40,13),(1133,'2015-07-04 18:15:02','1','WO00001-申请采购办公用品一批',2,'已修改 description 。',40,13),(1134,'2015-07-04 18:21:01','1','WO00001-申请采购办公用品一批',2,'已修改 service 。',40,13),(1135,'2015-07-07 21:09:47','1','123',1,'',69,11),(1136,'2015-07-07 21:10:14','1','123',2,'已变更 measure 和 sale_price for 报价明细 \"OfferItem object\". 已变更 measure for 报价明细 \"OfferItem object\". 已变更 measure for 报价明细 \"OfferItem object\".',69,11),(1137,'2015-07-15 12:04:06','20','【上线准备】-【部门|岗位|员工】第一步',2,'已修改 attach 。',75,11),(1138,'2015-07-15 12:10:58','20','【上线准备】-【部门|岗位|员工】第一步',2,'已修改 attach 。',75,11),(1139,'2015-07-15 12:36:18','1','11',1,'',54,11),(1140,'2015-07-15 12:36:39','1','11',2,'已变更 inventory for 出库明细 \"OutItem object\".',54,11),(1141,'2015-07-15 12:39:11','1','会议接待领用水果',2,'已修改 title 。 已变更 cnt for 出库明细 \"OutItem object\".',54,11),(1142,'2015-07-17 12:07:05','1','一批物资入库',1,'',53,11),(1143,'2015-07-17 12:07:23','1','一批办公物资入库',2,'已修改 title 。',53,11),(1144,'2015-07-17 12:09:39','2','调整一批物资库存',1,'',73,11),(1145,'2015-07-17 12:12:39','1','归还物资',1,'',71,11),(1146,'2015-07-17 12:14:55','1','归还物资',2,'已变更 cnt for 返库明细 \"ReturnItem object\".',71,11),(1147,'2015-07-17 12:16:36','1','上海某集团有限公司',2,'已修改 name 。',16,11);

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(13,'basedata','address'),(15,'basedata','bankaccount'),(23,'basedata','brand'),(24,'basedata','category'),(75,'basedata','dataimport'),(76,'basedata','document'),(32,'basedata','education'),(30,'basedata','employee'),(29,'basedata','expenseaccount'),(39,'basedata','extraparam'),(31,'basedata','family'),(27,'basedata','material'),(28,'basedata','materialparam'),(21,'basedata','measure'),(14,'basedata','partner'),(19,'basedata','project'),(25,'basedata','technicalparametername'),(26,'basedata','technicalparametervalue'),(22,'basedata','trade'),(11,'basedata','valuelist'),(12,'basedata','valuelistitem'),(20,'basedata','warehouse'),(33,'basedata','workexperience'),(5,'contenttypes','contenttype'),(50,'hr','departure'),(48,'hr','employeesalaryitem'),(47,'hr','entry'),(46,'hr','salaryitem'),(49,'hr','transfer'),(74,'invent','adjustitem'),(57,'invent','initem'),(52,'invent','initialinventory'),(56,'invent','inititem'),(55,'invent','inoutdetail'),(51,'invent','inventory'),(58,'invent','outitem'),(72,'invent','returnitem'),(53,'invent','stockin'),(54,'invent','stockout'),(73,'invent','wareadjust'),(71,'invent','warereturn'),(16,'organ','organization'),(17,'organ','orgunit'),(18,'organ','position'),(61,'purchase','invoice'),(62,'purchase','payment'),(60,'purchase','poitem'),(59,'purchase','purchaseorder'),(70,'sale','offeritem'),(69,'sale','offersheet'),(68,'sale','paymentcollection'),(67,'sale','saleitem'),(66,'sale','saleorder'),(63,'selfhelp','activity'),(65,'selfhelp','enroll'),(64,'selfhelp','feedback'),(43,'selfhelp','loan'),(44,'selfhelp','reimbursement'),(45,'selfhelp','reimbursementitem'),(41,'selfhelp','woextravalue'),(42,'selfhelp','woitem'),(40,'selfhelp','workorder'),(6,'sessions','session'),(9,'syscfg','menu'),(8,'syscfg','module'),(10,'syscfg','role'),(7,'syscfg','site'),(37,'workflow','history'),(36,'workflow','instance'),(34,'workflow','modal'),(35,'workflow','node'),(38,'workflow','todolist');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values (1,'contenttypes','0001_initial','2015-05-01 07:28:26'),(2,'auth','0001_initial','2015-05-01 07:28:26'),(3,'admin','0001_initial','2015-05-01 07:28:26'),(4,'contenttypes','0002_remove_content_type_name','2015-05-01 07:28:26'),(5,'auth','0002_alter_permission_name_max_length','2015-05-01 07:28:26'),(6,'auth','0003_alter_user_email_max_length','2015-05-01 07:28:26'),(7,'auth','0004_alter_user_username_opts','2015-05-01 07:28:26'),(8,'auth','0005_alter_user_last_login_null','2015-05-01 07:28:26'),(9,'auth','0006_require_contenttypes_0002','2015-05-01 07:28:26'),(10,'sessions','0001_initial','2015-05-01 07:28:26'),(11,'syscfg','0001_initial','2015-05-01 07:28:27'),(12,'basedata','0001_initial','2015-05-01 09:25:30'),(13,'basedata','0002_auto_20150501_0929','2015-05-01 09:30:01'),(14,'basedata','0003_auto_20150501_0931','2015-05-01 09:31:07'),(15,'basedata','0004_address','2015-05-01 10:52:00'),(16,'basedata','0005_auto_20150501_1121','2015-05-01 11:21:30'),(17,'basedata','0006_partner','2015-05-01 12:02:16'),(18,'basedata','0007_bankaccount','2015-05-01 15:35:20'),(19,'basedata','0008_auto_20150501_1547','2015-05-01 15:48:03'),(20,'organ','0001_initial','2015-05-01 19:14:41'),(21,'organ','0002_auto_20150501_2036','2015-05-01 20:36:43'),(22,'organ','0003_auto_20150501_2045','2015-05-01 20:46:03'),(23,'basedata','0009_auto_20150502_0817','2015-05-02 08:17:55'),(24,'basedata','0010_auto_20150502_0851','2015-05-02 08:51:53'),(25,'basedata','0011_auto_20150502_0934','2015-05-02 09:34:17'),(26,'basedata','0012_auto_20150502_0946','2015-05-02 09:46:24'),(27,'basedata','0013_auto_20150502_1311','2015-05-02 13:11:33'),(28,'basedata','0014_auto_20150502_1314','2015-05-02 13:14:16'),(29,'basedata','0015_brand_weight','2015-05-02 13:21:10'),(30,'basedata','0016_auto_20150502_1402','2015-05-02 14:04:33'),(31,'basedata','0017_auto_20150502_1731','2015-05-02 17:31:10'),(32,'basedata','0018_auto_20150502_2100','2015-05-02 21:00:06'),(33,'organ','0004_auto_20150503_1445','2015-05-03 14:46:12'),(34,'basedata','0019_auto_20150503_1445','2015-05-03 14:46:12'),(35,'basedata','0020_auto_20150503_1501','2015-05-03 15:01:41'),(36,'basedata','0021_auto_20150503_1518','2015-05-03 15:18:14'),(37,'basedata','0022_auto_20150503_1538','2015-05-03 15:38:24'),(38,'basedata','0023_auto_20150504_2120','2015-05-04 21:20:32'),(39,'basedata','0024_education_family_workexperience','2015-05-04 21:59:53'),(44,'organ','0005_auto_20150510_1141','2015-05-10 11:41:46'),(49,'workflow','0001_initial','2015-05-10 12:18:40'),(50,'workflow','0002_auto_20150513_2124','2015-05-13 21:24:50'),(51,'basedata','0025_auto_20150516_1829','2015-05-16 18:30:12'),(52,'basedata','0026_extraparam','2015-05-22 22:01:36'),(53,'selfhelp','0001_initial','2015-05-22 23:06:19'),(54,'selfhelp','0002_auto_20150522_2330','2015-05-22 23:30:14'),(55,'selfhelp','0003_auto_20150523_0621','2015-05-23 06:21:46'),(56,'basedata','0027_auto_20150523_2007','2015-05-23 20:07:34'),(57,'selfhelp','0004_auto_20150523_2007','2015-05-23 20:07:35'),(58,'selfhelp','0005_auto_20150523_2031','2015-05-23 20:31:54'),(59,'selfhelp','0006_auto_20150523_2050','2015-05-23 20:50:08'),(60,'selfhelp','0007_auto_20150523_2052','2015-05-23 20:52:17'),(61,'selfhelp','0008_auto_20150523_2133','2015-05-23 21:33:23'),(62,'selfhelp','0009_auto_20150523_2146','2015-05-23 21:46:15'),(65,'workflow','0003_auto_20150524_2208','2015-05-24 22:23:11'),(67,'hr','0001_initial','2015-05-25 22:12:43'),(68,'selfhelp','0010_auto_20150525_2255','2015-05-25 22:55:20'),(69,'selfhelp','0011_auto_20150603_1344','2015-06-03 13:44:59'),(70,'basedata','0028_auto_20150603_1444','2015-06-03 14:44:39'),(71,'invent','0001_initial','2015-06-03 15:56:04'),(72,'purchase','0001_initial','2015-06-03 20:27:01'),(73,'purchase','0002_auto_20150603_2117','2015-06-03 21:17:30'),(74,'purchase','0003_auto_20150603_2202','2015-06-03 22:02:53'),(75,'basedata','0029_auto_20150606_0944','2015-06-06 09:44:41'),(76,'basedata','0030_auto_20150606_0949','2015-06-06 09:49:22'),(77,'purchase','0004_auto_20150606_1050','2015-06-06 10:50:56'),(78,'invent','0002_auto_20150606_1050','2015-06-06 10:50:57'),(79,'invent','0003_auto_20150606_1147','2015-06-06 11:48:06'),(80,'purchase','0005_poitem_measure','2015-06-06 11:48:07'),(81,'invent','0004_initem_po_item','2015-06-06 11:54:49'),(82,'invent','0005_auto_20150606_1205','2015-06-06 12:06:09'),(83,'invent','0006_stockin_batch','2015-06-06 12:08:31'),(84,'invent','0007_auto_20150606_2008','2015-06-06 20:08:50'),(85,'invent','0008_inoutdetail_status','2015-06-06 20:30:43'),(86,'invent','0009_auto_20150607_1132','2015-06-07 11:33:09'),(87,'invent','0010_auto_20150607_1202','2015-06-07 12:03:02'),(88,'purchase','0006_auto_20150607_1202','2015-06-07 12:03:04'),(89,'purchase','0007_auto_20150607_1353','2015-06-07 13:53:55'),(90,'invent','0011_outitem_inventory','2015-06-08 21:07:50'),(91,'basedata','0031_auto_20150608_2143','2015-06-08 21:44:17'),(92,'invent','0012_auto_20150608_2143','2015-06-08 21:44:18'),(93,'invent','0013_auto_20150609_0623','2015-06-09 06:23:21'),(94,'purchase','0008_invoice','2015-06-10 20:51:34'),(95,'purchase','0009_auto_20150610_2133','2015-06-10 21:33:08'),(96,'selfhelp','0012_activity_enroll_feedback','2015-06-11 21:37:16'),(97,'selfhelp','0013_activity_code','2015-06-11 21:41:50'),(98,'invent','0014_auto_20150613_1747','2015-06-13 17:48:07'),(99,'sale','0001_initial','2015-06-14 12:07:39'),(100,'sale','0002_auto_20150614_1748','2015-06-14 17:48:34'),(101,'sale','0003_paymentcollection_org','2015-06-14 17:51:18'),(102,'purchase','0010_auto_20150614_1822','2015-06-14 18:22:22'),(103,'sale','0004_auto_20150614_2026','2015-06-14 20:26:59'),(104,'sale','0005_offeritem_discount_price','2015-06-14 20:31:16'),(105,'sale','0006_auto_20150617_2108','2015-06-17 21:08:38'),(106,'sale','0007_saleitem_discount_price','2015-06-20 21:16:32'),(107,'basedata','0032_material_tp','2015-06-20 21:35:33'),(108,'invent','0015_auto_20150621_0836','2015-06-21 08:36:19'),(109,'invent','0016_auto_20150621_1425','2015-06-21 14:25:45'),(110,'basedata','0033_auto_20150622_1009','2015-06-22 10:09:50'),(111,'selfhelp','0014_auto_20150627_0534','2015-06-27 05:34:44'),(112,'selfhelp','0015_loan_is_clear','2015-06-27 06:45:06'),(113,'purchase','0011_purchaseorder_attach','2015-06-27 19:58:41'),(114,'selfhelp','0016_auto_20150627_2039','2015-06-27 20:40:10'),(115,'basedata','0034_auto_20150627_2055','2015-06-27 20:56:46'),(116,'selfhelp','0017_woitem_measure','2015-06-27 20:56:47'),(117,'basedata','0035_document','2015-06-28 07:13:21'),(118,'workflow','0004_auto_20150630_2042','2015-06-30 20:43:08'),(119,'workflow','0005_auto_20150630_2138','2015-06-30 21:38:29'),(120,'workflow','0006_node_action','2015-06-30 22:10:27'),(121,'workflow','0007_node_can_edit','2015-07-02 21:12:10');

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

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values ('2rdw4agh630yjfqhy14jie3dgzhi8v8i','OGEyMjM1MDM3YmU1ZmE4NjYxNmIzOWE5MTY3NjYzZjhhNDUyMWQxMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjUzODFkNDg2MjM0YTlmMTQ0YjBkM2Y4ZWY4NWNmMDZlMmRkYjE1MWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-05-16 08:18:20'),('9yr00u8rvtplvssvra5nkw29ykbs9cxo','OGEyMjM1MDM3YmU1ZmE4NjYxNmIzOWE5MTY3NjYzZjhhNDUyMWQxMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjUzODFkNDg2MjM0YTlmMTQ0YjBkM2Y4ZWY4NWNmMDZlMmRkYjE1MWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-06-24 20:54:54'),('bffad131mfdzd3ti0eat4ixwbaedqqfn','OGEyMjM1MDM3YmU1ZmE4NjYxNmIzOWE5MTY3NjYzZjhhNDUyMWQxMDp7Il9hdXRoX3VzZXJfaGFzaCI6IjUzODFkNDg2MjM0YTlmMTQ0YjBkM2Y4ZWY4NWNmMDZlMmRkYjE1MWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIn0=','2015-05-15 07:39:11');

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `hr_salaryitem` */

insert  into `hr_salaryitem`(`id`,`code`,`name`,`classification`,`plus_or_minus`,`required`) values (1,'1001','基本工资','10','+',1),(2,'1002','岗位工资','10','+',1),(3,'1003','技能工资','10','+',1),(4,'1004','学历工资','10','+',1),(5,'1006','职务工资','10','+',1),(6,'2001','养老保险','20','-',1),(7,'2002','医疗保险','20','-',1),(8,'2003','生育保险','20','-',1),(9,'2004','失业保险','20','-',1),(10,'2005','工伤保险','20','-',1),(11,'2006','住房公积金','20','-',1),(12,'3001','销售佣金','30','+',0),(13,'3002','伯乐奖','30','+',0),(14,'4001','高温费','40','+',0),(15,'4002','取暖费','40','+',0),(16,'4003','独生子女费','40','+',0),(17,'4004','交通费','40','+',0),(18,'4005','住房补贴','40','+',0);

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

/*Table structure for table `invent_adjustitem` */

DROP TABLE IF EXISTS `invent_adjustitem`;

CREATE TABLE `invent_adjustitem` (
  `inoutdetail_ptr_id` int(11) NOT NULL,
  `inventory_id` int(11) DEFAULT NULL,
  `master_id` int(11) NOT NULL,
  PRIMARY KEY (`inoutdetail_ptr_id`),
  KEY `invent_adjustitem_inventory_id_26479e75_fk_invent_inventory_id` (`inventory_id`),
  KEY `invent_adjustitem_90349b61` (`master_id`),
  CONSTRAINT `invent_adjustitem_inventory_id_26479e75_fk_invent_inventory_id` FOREIGN KEY (`inventory_id`) REFERENCES `invent_inventory` (`id`),
  CONSTRAINT `invent_adjustitem_master_id_4e55f6a0_fk_invent_wareadjust_id` FOREIGN KEY (`master_id`) REFERENCES `invent_wareadjust` (`id`),
  CONSTRAINT `invent_adju_inoutdetail_ptr_id_56d701c4_fk_invent_inoutdetail_id` FOREIGN KEY (`inoutdetail_ptr_id`) REFERENCES `invent_inoutdetail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invent_adjustitem` */

insert  into `invent_adjustitem`(`inoutdetail_ptr_id`,`inventory_id`,`master_id`) values (102,49,1),(103,48,1),(104,47,1),(108,51,2),(109,49,2),(110,45,2);

/*Table structure for table `invent_initem` */

DROP TABLE IF EXISTS `invent_initem`;

CREATE TABLE `invent_initem` (
  `inoutdetail_ptr_id` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  `po_item_id` int(11),
  PRIMARY KEY (`inoutdetail_ptr_id`),
  KEY `invent_initem_master_id_777093cc_fk_invent_stockin_id` (`master_id`),
  KEY `invent_initem_2a7dcb03` (`po_item_id`),
  CONSTRAINT `invent_initem_master_id_777093cc_fk_invent_stockin_id` FOREIGN KEY (`master_id`) REFERENCES `invent_stockin` (`id`),
  CONSTRAINT `invent_initem_po_item_id_10308e1c_fk_purchase_poitem_id` FOREIGN KEY (`po_item_id`) REFERENCES `purchase_poitem` (`id`),
  CONSTRAINT `invent_init_inoutdetail_ptr_id_62cb8948_fk_invent_inoutdetail_id` FOREIGN KEY (`inoutdetail_ptr_id`) REFERENCES `invent_inoutdetail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invent_initem` */

insert  into `invent_initem`(`inoutdetail_ptr_id`,`master_id`,`po_item_id`) values (106,1,1),(107,1,2);

/*Table structure for table `invent_initialinventory` */

DROP TABLE IF EXISTS `invent_initialinventory`;

CREATE TABLE `invent_initialinventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `title` varchar(40) NOT NULL,
  `status` varchar(2) NOT NULL,
  `execute_time` datetime DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(14,4),
  `attach` varchar(100),
  PRIMARY KEY (`id`),
  KEY `invent_initialinventory_org_id_5505a597_fk_organ_organization_id` (`org_id`),
  KEY `invent_initialinventory_user_id_52fe41ef_fk_auth_user_id` (`user_id`),
  CONSTRAINT `invent_initialinventory_org_id_5505a597_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `invent_initialinventory_user_id_52fe41ef_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `invent_initialinventory` */

insert  into `invent_initialinventory`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`status`,`execute_time`,`org_id`,`user_id`,`amount`,`attach`) values (15,'2015-06-14','9999-12-31','zhugl',NULL,'2015-06-14 13:22:36','2015-06-14 13:22:54','QC015','期初库存x12','9','2015-06-14 13:22:54',1,NULL,'19438.0000','inventory/INVENTORY_PPfDioe.csv');

/*Table structure for table `invent_inititem` */

DROP TABLE IF EXISTS `invent_inititem`;

CREATE TABLE `invent_inititem` (
  `inoutdetail_ptr_id` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  PRIMARY KEY (`inoutdetail_ptr_id`),
  KEY `invent_inititem_master_id_2e3b4e8d_fk_invent_initialinventory_id` (`master_id`),
  CONSTRAINT `invent_inititem_master_id_2e3b4e8d_fk_invent_initialinventory_id` FOREIGN KEY (`master_id`) REFERENCES `invent_initialinventory` (`id`),
  CONSTRAINT `invent_init_inoutdetail_ptr_id_4be99311_fk_invent_inoutdetail_id` FOREIGN KEY (`inoutdetail_ptr_id`) REFERENCES `invent_inoutdetail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invent_inititem` */

insert  into `invent_inititem`(`inoutdetail_ptr_id`,`master_id`) values (76,15),(77,15),(78,15),(79,15),(80,15),(81,15),(82,15),(83,15),(84,15),(85,15);

/*Table structure for table `invent_inoutdetail` */

DROP TABLE IF EXISTS `invent_inoutdetail`;

CREATE TABLE `invent_inoutdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `event_time` datetime DEFAULT NULL,
  `batch` varchar(20) DEFAULT NULL,
  `price` decimal(14,4) DEFAULT NULL,
  `prop` varchar(2) NOT NULL,
  `source` varchar(20) DEFAULT NULL,
  `material_id` int(11) DEFAULT NULL,
  `measure_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `cnt` decimal(14,4) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invent_inoutdetail_eb4b9aaa` (`material_id`),
  KEY `invent_inoutdetail_80c371ce` (`measure_id`),
  KEY `invent_inoutdetail_9744817e` (`warehouse_id`),
  CONSTRAINT `invent_inoutdetail_material_id_61f641de_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `invent_inoutdetail_measure_id_24903062_fk_basedata_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `basedata_measure` (`id`),
  CONSTRAINT `invent_inoutdetail_warehouse_id_b6de15f_fk_basedata_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `basedata_warehouse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;

/*Data for the table `invent_inoutdetail` */

insert  into `invent_inoutdetail`(`id`,`create_time`,`event_time`,`batch`,`price`,`prop`,`source`,`material_id`,`measure_id`,`warehouse_id`,`cnt`,`status`) values (76,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'5.6000','+','QC015',40,3,11,'120.0000',1),(77,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'8.2000','+','QC015',41,3,11,'105.0000',1),(78,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'9.5000','+','QC015',42,3,11,'569.0000',1),(79,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'6.5000','+','QC015',43,3,11,'159.0000',1),(80,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'7.8000','+','QC015',44,3,11,'276.0000',1),(81,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'6.9000','+','QC015',45,3,11,'309.0000',1),(82,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'12.6000','+','QC015',46,3,11,'38.0000',1),(83,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'8.2000','+','QC015',47,3,11,'98.0000',1),(84,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'8.9000','+','QC015',48,3,11,'315.0000',1),(85,'2015-06-14 13:22:36','2015-06-14 13:22:54',NULL,'14.6000','+','QC015',49,3,11,'212.0000',1),(102,'2015-06-21 14:34:47','2015-06-21 14:42:33',NULL,NULL,'+','TZ001',47,3,11,'1.0000',1),(103,'2015-06-21 14:34:47','2015-06-21 14:42:33',NULL,NULL,'+','TZ001',46,3,11,'1.0000',1),(104,'2015-06-21 14:34:47','2015-06-21 14:42:33',NULL,NULL,'+','TZ001',45,3,11,'1.0000',1),(105,'2015-07-15 12:36:18','2015-07-15 12:43:35',NULL,'5.6000','-','CK00001',40,3,11,'5.0000',1),(106,'2015-07-17 12:07:05','2015-07-17 12:29:02','','27.3504','+','RK00001',4,1,3,'5.0000',1),(107,'2015-07-17 12:07:05','2015-07-17 12:29:02','','255.5556','+','RK00001',55,1,3,'5.0000',1),(108,'2015-07-17 12:09:39','2015-07-17 12:37:12',NULL,NULL,'+','TZ002',49,3,11,'1.0000',1),(109,'2015-07-17 12:09:39','2015-07-17 12:37:12',NULL,NULL,'-','TZ002',47,3,11,'2.0000',1),(110,'2015-07-17 12:09:39','2015-07-17 12:37:12',NULL,NULL,'+','TZ002',43,3,11,'1.0000',1),(111,'2015-07-17 12:12:39','2015-07-17 12:56:25',NULL,'5.6000','+','FK0001',40,3,11,'2.0000',1);

/*Table structure for table `invent_inventory` */

DROP TABLE IF EXISTS `invent_inventory`;

CREATE TABLE `invent_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `batch` varchar(20) DEFAULT NULL,
  `price` decimal(14,4) NOT NULL,
  `material_id` int(11) NOT NULL,
  `measure_id` int(11) NOT NULL,
  `org_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `cnt` decimal(14,4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invent_inventory_material_id_7b04cfa0_fk_basedata_material_id` (`material_id`),
  KEY `invent_inventory_measure_id_66c34c34_fk_basedata_measure_id` (`measure_id`),
  KEY `invent_inventory_org_id_3e72901a_fk_organ_organization_id` (`org_id`),
  KEY `invent_inventory_warehouse_id_7b12f523_fk_basedata_warehouse_id` (`warehouse_id`),
  CONSTRAINT `invent_inventory_material_id_7b04cfa0_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `invent_inventory_measure_id_66c34c34_fk_basedata_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `basedata_measure` (`id`),
  CONSTRAINT `invent_inventory_org_id_3e72901a_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `invent_inventory_warehouse_id_7b12f523_fk_basedata_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `basedata_warehouse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

/*Data for the table `invent_inventory` */

insert  into `invent_inventory`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`batch`,`price`,`material_id`,`measure_id`,`org_id`,`warehouse_id`,`cnt`) values (42,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-07-17 12:56:25',NULL,'5.6000',40,3,NULL,11,'114.0000'),(43,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-06-14 13:22:54',NULL,'8.2000',41,3,NULL,11,'105.0000'),(44,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-06-14 13:22:54',NULL,'9.5000',42,3,NULL,11,'569.0000'),(45,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-07-17 12:37:12',NULL,'6.5000',43,3,NULL,11,'160.0000'),(46,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-06-14 13:22:54',NULL,'7.8000',44,3,NULL,11,'276.0000'),(47,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-06-21 14:42:33',NULL,'6.9000',45,3,NULL,11,'310.0000'),(48,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-06-21 14:42:33',NULL,'12.6000',46,3,NULL,11,'39.0000'),(49,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-07-17 12:37:12',NULL,'8.2000',47,3,NULL,11,'97.0000'),(50,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-06-14 13:22:54',NULL,'8.9000',48,3,NULL,11,'315.0000'),(51,NULL,NULL,NULL,NULL,'2015-06-14 13:22:54','2015-07-17 12:37:12',NULL,'14.6000',49,3,NULL,11,'208.0000'),(52,NULL,NULL,NULL,NULL,'2015-06-14 13:33:05','2015-06-21 10:23:35',NULL,'4512.8205',2,9,NULL,3,'2.0000'),(53,NULL,NULL,NULL,NULL,'2015-07-17 12:29:02','2015-07-17 12:29:02',NULL,'27.3504',4,1,NULL,3,'5.0000'),(54,NULL,NULL,NULL,NULL,'2015-07-17 12:29:02','2015-07-17 12:29:02',NULL,'255.5556',55,1,NULL,3,'5.0000');

/*Table structure for table `invent_outitem` */

DROP TABLE IF EXISTS `invent_outitem`;

CREATE TABLE `invent_outitem` (
  `inoutdetail_ptr_id` int(11) NOT NULL,
  `master_id` int(11) NOT NULL,
  `inventory_id` int(11),
  PRIMARY KEY (`inoutdetail_ptr_id`),
  KEY `invent_outitem_master_id_5d572ab8_fk_invent_stockout_id` (`master_id`),
  KEY `invent_outitem_98fac743` (`inventory_id`),
  CONSTRAINT `invent_outitem_inventory_id_1a5f5da3_fk_invent_inventory_id` FOREIGN KEY (`inventory_id`) REFERENCES `invent_inventory` (`id`),
  CONSTRAINT `invent_outitem_master_id_5d572ab8_fk_invent_stockout_id` FOREIGN KEY (`master_id`) REFERENCES `invent_stockout` (`id`),
  CONSTRAINT `invent_outi_inoutdetail_ptr_id_60f3e3dc_fk_invent_inoutdetail_id` FOREIGN KEY (`inoutdetail_ptr_id`) REFERENCES `invent_inoutdetail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invent_outitem` */

insert  into `invent_outitem`(`inoutdetail_ptr_id`,`master_id`,`inventory_id`) values (105,1,42);

/*Table structure for table `invent_returnitem` */

DROP TABLE IF EXISTS `invent_returnitem`;

CREATE TABLE `invent_returnitem` (
  `inoutdetail_ptr_id` int(11) NOT NULL,
  `out_cnt` decimal(14,4) NOT NULL,
  `master_id` int(11) NOT NULL,
  `out_item_id` int(11),
  PRIMARY KEY (`inoutdetail_ptr_id`),
  KEY `invent_returnitem_90349b61` (`master_id`),
  KEY `invent_returnitem_99ef2a78` (`out_item_id`),
  CONSTRAINT `invent_out_item_id_735b9d2f_fk_invent_outitem_inoutdetail_ptr_id` FOREIGN KEY (`out_item_id`) REFERENCES `invent_outitem` (`inoutdetail_ptr_id`),
  CONSTRAINT `invent_returnitem_master_id_11698bd3_fk_invent_warereturn_id` FOREIGN KEY (`master_id`) REFERENCES `invent_warereturn` (`id`),
  CONSTRAINT `invent_retu_inoutdetail_ptr_id_616dfca9_fk_invent_inoutdetail_id` FOREIGN KEY (`inoutdetail_ptr_id`) REFERENCES `invent_inoutdetail` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `invent_returnitem` */

insert  into `invent_returnitem`(`inoutdetail_ptr_id`,`out_cnt`,`master_id`,`out_item_id`) values (111,'5.0000',1,105);

/*Table structure for table `invent_stockin` */

DROP TABLE IF EXISTS `invent_stockin`;

CREATE TABLE `invent_stockin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `title` varchar(40) NOT NULL,
  `status` varchar(2) NOT NULL,
  `execute_time` datetime DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `po_id` int(11),
  `batch` varchar(20),
  `amount` decimal(14,4),
  PRIMARY KEY (`id`),
  KEY `invent_stockin_org_id_138faa53_fk_organ_organization_id` (`org_id`),
  KEY `invent_stockin_user_id_7ca6d2b_fk_auth_user_id` (`user_id`),
  KEY `invent_stockin_warehouse_id_77701ff6_fk_basedata_warehouse_id` (`warehouse_id`),
  KEY `invent_stockin_c73ffa0a` (`po_id`),
  CONSTRAINT `invent_stockin_org_id_138faa53_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `invent_stockin_po_id_54608973_fk_purchase_purchaseorder_id` FOREIGN KEY (`po_id`) REFERENCES `purchase_purchaseorder` (`id`),
  CONSTRAINT `invent_stockin_user_id_7ca6d2b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `invent_stockin_warehouse_id_77701ff6_fk_basedata_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `basedata_warehouse` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `invent_stockin` */

insert  into `invent_stockin`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`status`,`execute_time`,`org_id`,`user_id`,`warehouse_id`,`po_id`,`batch`,`amount`) values (1,'2015-07-17','9999-12-31','chengcai','chengcai','2015-07-17 12:07:05','2015-07-17 12:29:02','RK00001','一批办公物资入库','9','2015-07-17 12:29:02',NULL,11,3,1,'','1414.5300');

/*Table structure for table `invent_stockout` */

DROP TABLE IF EXISTS `invent_stockout`;

CREATE TABLE `invent_stockout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `title` varchar(40) NOT NULL,
  `description` longtext,
  `status` varchar(2) NOT NULL,
  `execute_time` datetime DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `wo_id` int(11) DEFAULT NULL,
  `amount` decimal(14,4),
  PRIMARY KEY (`id`),
  KEY `invent_stockout_org_id_71a748a3_fk_organ_organization_id` (`org_id`),
  KEY `invent_stockout_project_id_4e2d4cbc_fk_basedata_project_id` (`project_id`),
  KEY `invent_stockout_wo_id_3c16dd70_fk_selfhelp_workorder_id` (`wo_id`),
  KEY `invent_stockout_user_id_537784b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `invent_stockout_org_id_71a748a3_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `invent_stockout_project_id_4e2d4cbc_fk_basedata_project_id` FOREIGN KEY (`project_id`) REFERENCES `basedata_project` (`id`),
  CONSTRAINT `invent_stockout_user_id_537784b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `invent_stockout_wo_id_3c16dd70_fk_selfhelp_workorder_id` FOREIGN KEY (`wo_id`) REFERENCES `selfhelp_workorder` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `invent_stockout` */

insert  into `invent_stockout`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`description`,`status`,`execute_time`,`org_id`,`project_id`,`user_id`,`wo_id`,`amount`) values (1,'2015-07-15','9999-12-31','chengcai','chengcai','2015-07-15 12:36:18','2015-07-15 12:43:35','CK00001','会议接待领用水果','','9','2015-07-15 12:43:35',NULL,8,11,1,'28.0000');

/*Table structure for table `invent_wareadjust` */

DROP TABLE IF EXISTS `invent_wareadjust`;

CREATE TABLE `invent_wareadjust` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `title` varchar(40) NOT NULL,
  `description` longtext,
  `status` varchar(2) NOT NULL,
  `execute_time` datetime DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invent_wareadjust_org_id_4dd80263_fk_organ_organization_id` (`org_id`),
  KEY `invent_wareadjust_user_id_5f3e6fc5_fk_auth_user_id` (`user_id`),
  CONSTRAINT `invent_wareadjust_org_id_4dd80263_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `invent_wareadjust_user_id_5f3e6fc5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `invent_wareadjust` */

insert  into `invent_wareadjust`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`description`,`status`,`execute_time`,`org_id`,`user_id`) values (1,'2015-06-21','9999-12-31','zhugl',NULL,'2015-06-21 14:34:47','2015-06-21 14:42:33','TZ001','水果库存调整','','9','2015-06-21 14:42:33',NULL,NULL),(2,'2015-07-17','9999-12-31','chengcai',NULL,'2015-07-17 12:09:39','2015-07-17 12:37:12','TZ002','调整一批物资库存','因前期盘点有误，调整库存数量','9','2015-07-17 12:37:12',NULL,11);

/*Table structure for table `invent_warereturn` */

DROP TABLE IF EXISTS `invent_warereturn`;

CREATE TABLE `invent_warereturn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `title` varchar(40) NOT NULL,
  `amount` decimal(14,4) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `execute_time` datetime DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `out_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invent_warereturn_org_id_c9a93c_fk_organ_organization_id` (`org_id`),
  KEY `invent_warereturn_out_id_3a81433a_fk_invent_stockout_id` (`out_id`),
  KEY `invent_warereturn_user_id_5a6b8d9c_fk_auth_user_id` (`user_id`),
  CONSTRAINT `invent_warereturn_org_id_c9a93c_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `invent_warereturn_out_id_3a81433a_fk_invent_stockout_id` FOREIGN KEY (`out_id`) REFERENCES `invent_stockout` (`id`),
  CONSTRAINT `invent_warereturn_user_id_5a6b8d9c_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `invent_warereturn` */

insert  into `invent_warereturn`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`amount`,`status`,`execute_time`,`org_id`,`out_id`,`user_id`) values (1,'2015-07-17','9999-12-31','chengcai','chengcai','2015-07-17 12:12:39','2015-07-17 12:56:25','FK0001','归还物资','11.2000','9','2015-07-17 12:56:25',NULL,1,11);

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

insert  into `organ_organization`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`status`,`tax_num`,`tax_address`,`tax_account`,`represent`,`address`,`zipcode`,`fax`,`contacts`,`phone`,`website`,`email`,`lic_code`,`cer_code`,`license`,`certificate`,`weight`) values (1,'2015-05-01','9999-12-31','zhugl','chengcai','2015-05-01 20:26:05','2015-07-17 12:16:36','O01','上海某集团有限公司','上海机场','Shanghai Airport',1,'310120000001357','上海市浦东机场启航路900号','交通银行上海分行浦东支行','李德润','上海市肇嘉浜路301号','200032','021-58698201','王勇','021-58698202','www.shairport.com','webadmin@sgs.gov.cn','310120000001357','20120620102952945','','',9);

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
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

/*Data for the table `organ_orgunit` */

insert  into `organ_orgunit`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`unit_type`,`status`,`virtual`,`fax`,`phone`,`contacts`,`email`,`weight`,`organization_id`,`parent_id`) values (70,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','B1001','董事会','董事会','board',2,1,0,NULL,NULL,NULL,NULL,99,NULL,NULL),(71,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','B1002','总经理办公室','总办','president office',2,1,0,NULL,NULL,NULL,NULL,99,NULL,NULL),(72,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','B1003','人事行政部','人事部','hr',2,1,0,NULL,NULL,NULL,NULL,99,NULL,NULL),(73,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','B1004','财务部','财务部','finace',2,1,0,NULL,NULL,NULL,NULL,99,NULL,NULL),(74,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','B1005','采购部','采购部','purchase',2,1,0,NULL,NULL,NULL,NULL,99,NULL,NULL),(75,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','B1006','生产中心','生产中心','produce center',2,1,0,NULL,NULL,NULL,NULL,99,NULL,NULL),(76,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','B1007','质检中心','质检中心','qulification center',2,1,0,NULL,NULL,NULL,NULL,99,NULL,NULL),(77,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','B1001','董事会','董事会','board',2,1,0,NULL,NULL,NULL,NULL,1,NULL,NULL),(78,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','B1002','总经理办公室','总办','president office',2,1,0,NULL,NULL,NULL,NULL,2,NULL,NULL),(79,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','B1003','人事行政部','人事部','hr',2,1,0,NULL,NULL,NULL,NULL,3,NULL,NULL),(80,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','B1004','财务部','财务部','finace',2,1,0,NULL,NULL,NULL,NULL,4,NULL,NULL),(81,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','B1005','采购部','采购部','purchase',2,1,0,NULL,NULL,NULL,NULL,5,NULL,NULL),(82,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','B1006','生产中心','生产中心','produce center',2,1,0,NULL,NULL,NULL,NULL,6,NULL,NULL),(83,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','B1007','质检中心','质检中心','qulification center',2,1,0,NULL,NULL,NULL,NULL,7,NULL,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

/*Data for the table `organ_position` */

insert  into `organ_position`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`short`,`pinyin`,`series`,`grade`,`virtual`,`description`,`qualification`,`document`,`weight`,`parent_id`,`unit_id`,`organization_id`,`status`) values (86,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1001','董事长',NULL,NULL,'A','01',0,NULL,NULL,'',99,NULL,70,NULL,1),(87,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1002','总经理',NULL,NULL,'A','01',0,NULL,NULL,'',99,86,70,NULL,1),(88,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1003','副总经理',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,71,NULL,1),(89,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1004','总工程师',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,71,NULL,1),(90,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1005','总经济师',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,71,NULL,1),(91,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1006','人事经理',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,72,NULL,1),(92,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1007','行政经理',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,72,NULL,1),(93,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1008','财务经理',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,73,NULL,1),(94,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1009','生产总监',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,75,NULL,1),(95,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1010','采购经理',NULL,NULL,'A','01',0,NULL,NULL,'',99,87,74,NULL,1),(96,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1011','会计',NULL,NULL,'A','01',0,NULL,NULL,'',99,93,73,NULL,1),(97,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1012','出纳',NULL,NULL,'A','01',0,NULL,NULL,'',99,93,73,NULL,1),(98,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1013','人事专员',NULL,NULL,'A','01',0,NULL,NULL,'',99,91,72,NULL,1),(99,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1014','司机',NULL,NULL,'A','01',0,NULL,NULL,'',99,92,72,NULL,1),(100,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1015','行政专员',NULL,NULL,'A','01',0,NULL,NULL,'',99,92,72,NULL,1),(101,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1016','报价员',NULL,NULL,'A','01',0,NULL,NULL,'',99,94,75,NULL,1),(102,'2015-06-27','9999-12-31',NULL,NULL,'2015-06-27 13:08:27','2015-06-27 13:08:27','P1017','技术工程师',NULL,NULL,'A','01',0,NULL,NULL,'',99,94,75,NULL,1),(103,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1001','董事长',NULL,NULL,'A','01',0,NULL,NULL,'',1,NULL,70,NULL,1),(104,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1002','总经理',NULL,NULL,'A','01',0,NULL,NULL,'',2,86,70,NULL,1),(105,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1003','副总经理',NULL,NULL,'A','01',0,NULL,NULL,'',3,87,71,NULL,1),(106,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1004','总工程师',NULL,NULL,'A','01',0,NULL,NULL,'',4,87,71,NULL,1),(107,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1005','总经济师',NULL,NULL,'A','01',0,NULL,NULL,'',5,87,71,NULL,1),(108,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1006','人事经理',NULL,NULL,'A','01',0,NULL,NULL,'',6,87,72,NULL,1),(109,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1007','行政经理',NULL,NULL,'A','01',0,NULL,NULL,'',7,87,72,NULL,1),(110,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1008','财务经理',NULL,NULL,'A','01',0,NULL,NULL,'',8,87,73,NULL,1),(111,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1009','生产总监',NULL,NULL,'A','01',0,NULL,NULL,'',9,87,75,NULL,1),(112,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1010','采购经理',NULL,NULL,'A','01',0,NULL,NULL,'',10,87,74,NULL,1),(113,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1011','会计',NULL,NULL,'A','01',0,NULL,NULL,'',11,93,73,NULL,1),(114,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1012','出纳',NULL,NULL,'A','01',0,NULL,NULL,'',12,93,73,NULL,1),(115,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1013','人事专员',NULL,NULL,'A','01',0,NULL,NULL,'',13,91,72,NULL,1),(116,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1014','司机',NULL,NULL,'A','01',0,NULL,NULL,'',14,92,72,NULL,1),(117,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1015','行政专员',NULL,NULL,'A','01',0,NULL,NULL,'',15,92,72,NULL,1),(118,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1016','报价员',NULL,NULL,'A','01',0,NULL,NULL,'',16,94,75,NULL,1),(119,'2015-07-15','9999-12-31',NULL,NULL,'2015-07-15 12:04:17','2015-07-15 12:04:17','P1017','技术工程师',NULL,NULL,'A','01',0,NULL,NULL,'',17,94,75,NULL,1);

/*Table structure for table `purchase_invoice` */

DROP TABLE IF EXISTS `purchase_invoice`;

CREATE TABLE `purchase_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `vo_date` date,
  `code` varchar(20) NOT NULL,
  `number` varchar(20) NOT NULL,
  `po_amount` decimal(14,4) DEFAULT NULL,
  `vo_amount` decimal(14,4) NOT NULL,
  `file` varchar(100) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `po_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `purchase_invoice_partner_id_7ee3f712_fk_basedata_partner_id` (`partner_id`),
  KEY `purchase_invoice_po_id_3777f562_fk_purchase_purchaseorder_id` (`po_id`),
  CONSTRAINT `purchase_invoice_partner_id_7ee3f712_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`),
  CONSTRAINT `purchase_invoice_po_id_3777f562_fk_purchase_purchaseorder_id` FOREIGN KEY (`po_id`) REFERENCES `purchase_purchaseorder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `purchase_invoice` */

/*Table structure for table `purchase_payment` */

DROP TABLE IF EXISTS `purchase_payment`;

CREATE TABLE `purchase_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `py_date` date DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `po_amount` decimal(14,4) DEFAULT NULL,
  `py_amount` decimal(14,4) NOT NULL,
  `response_code` varchar(80) DEFAULT NULL,
  `memo` longtext,
  `bank_id` int(11) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `po_id` int(11) NOT NULL,
  `org_id` int(11),
  PRIMARY KEY (`id`),
  KEY `purchase_payment_partner_id_102965e7_fk_basedata_partner_id` (`partner_id`),
  KEY `purchase_payment_po_id_3291acc9_fk_purchase_purchaseorder_id` (`po_id`),
  KEY `purchase_payment_bank_id_66ac7b06_fk_basedata_bankaccount_id` (`bank_id`),
  KEY `purchase_payment_9cf869aa` (`org_id`),
  CONSTRAINT `purchase_payment_bank_id_66ac7b06_fk_basedata_bankaccount_id` FOREIGN KEY (`bank_id`) REFERENCES `basedata_bankaccount` (`id`),
  CONSTRAINT `purchase_payment_org_id_33cf80e9_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `purchase_payment_partner_id_102965e7_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`),
  CONSTRAINT `purchase_payment_po_id_3291acc9_fk_purchase_purchaseorder_id` FOREIGN KEY (`po_id`) REFERENCES `purchase_purchaseorder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `purchase_payment` */

/*Table structure for table `purchase_poitem` */

DROP TABLE IF EXISTS `purchase_poitem`;

CREATE TABLE `purchase_poitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` decimal(12,4) DEFAULT NULL,
  `cnt` decimal(12,4) DEFAULT NULL,
  `discount_price` decimal(12,4) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `tax` varchar(6) NOT NULL,
  `material_id` int(11) NOT NULL,
  `po_id` int(11) NOT NULL,
  `woitem_id` int(11),
  `in_stock_time` datetime,
  `is_in_stock` tinyint(1) NOT NULL,
  `measure_id` int(11),
  `entry_cnt` decimal(12,4),
  `left_cnt` decimal(12,4),
  PRIMARY KEY (`id`),
  KEY `purchase_poitem_material_id_10910564_fk_basedata_material_id` (`material_id`),
  KEY `purchase_poitem_c73ffa0a` (`po_id`),
  KEY `purchase_poitem_1f526118` (`woitem_id`),
  KEY `purchase_poitem_80c371ce` (`measure_id`),
  CONSTRAINT `purchase_poitem_material_id_10910564_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `purchase_poitem_measure_id_115682d0_fk_basedata_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `basedata_measure` (`id`),
  CONSTRAINT `purchase_poitem_po_id_698de2ca_fk_purchase_purchaseorder_id` FOREIGN KEY (`po_id`) REFERENCES `purchase_purchaseorder` (`id`),
  CONSTRAINT `purchase_poitem_woitem_id_7ee62f3a_fk_selfhelp_woitem_id` FOREIGN KEY (`woitem_id`) REFERENCES `selfhelp_woitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `purchase_poitem` */

insert  into `purchase_poitem`(`id`,`price`,`cnt`,`discount_price`,`amount`,`discount_amount`,`tax`,`material_id`,`po_id`,`woitem_id`,`in_stock_time`,`is_in_stock`,`measure_id`,`entry_cnt`,`left_cnt`) values (1,'32.0000','5.0000',NULL,'160.00',NULL,'0.17',4,1,NULL,'2015-07-17 12:29:02',1,1,'5.0000','0.0000'),(2,'299.0000','5.0000',NULL,'1495.00',NULL,'0.17',55,1,NULL,'2015-07-17 12:29:02',1,1,'5.0000','0.0000');

/*Table structure for table `purchase_purchaseorder` */

DROP TABLE IF EXISTS `purchase_purchaseorder`;

CREATE TABLE `purchase_purchaseorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `order_date` date NOT NULL,
  `arrive_date` date NOT NULL,
  `title` varchar(40) NOT NULL,
  `description` longtext,
  `status` varchar(2) NOT NULL,
  `amount` decimal(12,2),
  `discount_amount` decimal(12,2),
  `org_id` int(11) DEFAULT NULL,
  `partner_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `entry_status` tinyint(1) NOT NULL,
  `entry_time` datetime,
  `attach` varchar(100),
  PRIMARY KEY (`id`),
  KEY `purchase_purchaseorder_org_id_5454e9a_fk_organ_organization_id` (`org_id`),
  KEY `purchase_purchaseorder_partner_id_4f47a8a_fk_basedata_partner_id` (`partner_id`),
  KEY `purchase_purchaseorder_user_id_6da1490e_fk_auth_user_id` (`user_id`),
  CONSTRAINT `purchase_purchaseorder_org_id_5454e9a_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `purchase_purchaseorder_partner_id_4f47a8a_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`),
  CONSTRAINT `purchase_purchaseorder_user_id_6da1490e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `purchase_purchaseorder` */

insert  into `purchase_purchaseorder`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`order_date`,`arrive_date`,`title`,`description`,`status`,`amount`,`discount_amount`,`org_id`,`partner_id`,`user_id`,`entry_status`,`entry_time`,`attach`) values (1,'2015-06-30','9999-12-31','chengcai','chengcai','2015-06-30 20:23:07','2015-07-17 12:29:02','CG00001','2015-06-30','2015-07-30','采购物品','','99','1655.00','0.00',NULL,18,11,1,'2015-07-17 12:29:02','');

/*Table structure for table `sale_offeritem` */

DROP TABLE IF EXISTS `sale_offeritem`;

CREATE TABLE `sale_offeritem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cnt` decimal(14,4) NOT NULL,
  `stock_price` decimal(14,4) DEFAULT NULL,
  `sale_price` decimal(14,4) DEFAULT NULL,
  `tax` varchar(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `event_time` datetime DEFAULT NULL,
  `master_id` int(11) NOT NULL,
  `material_id` int(11),
  `measure_id` int(11),
  `discount_price` decimal(14,4),
  `brand` varchar(20),
  `cost_price` decimal(14,4),
  PRIMARY KEY (`id`),
  KEY `sale_offeritem_90349b61` (`master_id`),
  KEY `sale_offeritem_eb4b9aaa` (`material_id`),
  KEY `sale_offeritem_80c371ce` (`measure_id`),
  CONSTRAINT `sale_offeritem_master_id_759ed829_fk_sale_offersheet_id` FOREIGN KEY (`master_id`) REFERENCES `sale_offersheet` (`id`),
  CONSTRAINT `sale_offeritem_material_id_1984f90_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `sale_offeritem_measure_id_3e74b43c_fk_basedata_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `basedata_measure` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `sale_offeritem` */

insert  into `sale_offeritem`(`id`,`cnt`,`stock_price`,`sale_price`,`tax`,`create_time`,`status`,`event_time`,`master_id`,`material_id`,`measure_id`,`discount_price`,`brand`,`cost_price`) values (1,'2.0000',NULL,'550.0000','0.00','2015-07-07 21:09:47',0,NULL,1,55,2,NULL,NULL,NULL),(2,'2.0000',NULL,'9999.0000','0.00','2015-07-07 21:09:47',0,NULL,1,54,2,NULL,NULL,NULL),(3,'2.0000',NULL,'320.0000','0.00','2015-07-07 21:09:47',0,NULL,1,52,2,NULL,NULL,NULL);

/*Table structure for table `sale_offersheet` */

DROP TABLE IF EXISTS `sale_offersheet`;

CREATE TABLE `sale_offersheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `offer_date` date NOT NULL,
  `deliver_date` date NOT NULL,
  `title` varchar(40) NOT NULL,
  `description` longtext,
  `amount` decimal(12,2) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `attach` varchar(100) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `event_time` datetime DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `partner_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_offersheet_org_id_4224cc19_fk_organ_organization_id` (`org_id`),
  KEY `sale_offersheet_partner_id_180d0c89_fk_basedata_partner_id` (`partner_id`),
  KEY `sale_offersheet_user_id_34ea58c1_fk_auth_user_id` (`user_id`),
  CONSTRAINT `sale_offersheet_org_id_4224cc19_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `sale_offersheet_partner_id_180d0c89_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`),
  CONSTRAINT `sale_offersheet_user_id_34ea58c1_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `sale_offersheet` */

insert  into `sale_offersheet`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`offer_date`,`deliver_date`,`title`,`description`,`amount`,`discount_amount`,`attach`,`status`,`event_time`,`org_id`,`partner_id`,`user_id`) values (1,'2015-07-07','9999-12-31','chengcai','chengcai','2015-07-07 21:09:46','2015-07-07 21:10:14','BJ00001','2015-07-07','2015-08-06','123','','21738.00','0.00','',0,NULL,NULL,17,11);

/*Table structure for table `sale_paymentcollection` */

DROP TABLE IF EXISTS `sale_paymentcollection`;

CREATE TABLE `sale_paymentcollection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `collection_date` date DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `order_amount` decimal(14,4) DEFAULT NULL,
  `collection_amount` decimal(14,4) NOT NULL,
  `memo` longtext,
  `bank_id` int(11) DEFAULT NULL,
  `partner_id` int(11) DEFAULT NULL,
  `so_id` int(11) NOT NULL,
  `org_id` int(11),
  PRIMARY KEY (`id`),
  KEY `sale_paymentcollecti_bank_id_5db2135c_fk_basedata_bankaccount_id` (`bank_id`),
  KEY `sale_paymentcollectio_partner_id_545062b1_fk_basedata_partner_id` (`partner_id`),
  KEY `sale_paymentcollection_5a20014e` (`so_id`),
  KEY `sale_paymentcollection_9cf869aa` (`org_id`),
  CONSTRAINT `sale_paymentcollection_org_id_3858f3f_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `sale_paymentcollection_so_id_1640456e_fk_sale_saleorder_id` FOREIGN KEY (`so_id`) REFERENCES `sale_saleorder` (`id`),
  CONSTRAINT `sale_paymentcollectio_partner_id_545062b1_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`),
  CONSTRAINT `sale_paymentcollecti_bank_id_5db2135c_fk_basedata_bankaccount_id` FOREIGN KEY (`bank_id`) REFERENCES `basedata_bankaccount` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sale_paymentcollection` */

/*Table structure for table `sale_saleitem` */

DROP TABLE IF EXISTS `sale_saleitem`;

CREATE TABLE `sale_saleitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cnt` decimal(14,4) NOT NULL,
  `stock_price` decimal(14,4) DEFAULT NULL,
  `sale_price` decimal(14,4) DEFAULT NULL,
  `tax` varchar(6) NOT NULL,
  `create_time` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `event_time` datetime DEFAULT NULL,
  `master_id` int(11) NOT NULL,
  `material_id` int(11),
  `measure_id` int(11),
  `discount_price` decimal(14,4),
  PRIMARY KEY (`id`),
  KEY `sale_saleitem_90349b61` (`master_id`),
  KEY `sale_saleitem_eb4b9aaa` (`material_id`),
  KEY `sale_saleitem_80c371ce` (`measure_id`),
  CONSTRAINT `sale_saleitem_master_id_7aa6dde1_fk_sale_saleorder_id` FOREIGN KEY (`master_id`) REFERENCES `sale_saleorder` (`id`),
  CONSTRAINT `sale_saleitem_material_id_4cb3eb8_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `sale_saleitem_measure_id_317dc10c_fk_basedata_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `basedata_measure` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sale_saleitem` */

/*Table structure for table `sale_saleorder` */

DROP TABLE IF EXISTS `sale_saleorder`;

CREATE TABLE `sale_saleorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `order_date` date NOT NULL,
  `deliver_date` date NOT NULL,
  `title` varchar(40) NOT NULL,
  `description` longtext,
  `contact` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `deliver_address` varchar(120) DEFAULT NULL,
  `invoice_type` varchar(6) NOT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `discount_amount` decimal(12,2) DEFAULT NULL,
  `status` varchar(2) NOT NULL,
  `org_id` int(11) DEFAULT NULL,
  `partner_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sale_saleorder_org_id_1d0df2d2_fk_organ_organization_id` (`org_id`),
  KEY `sale_saleorder_partner_id_31af6b7e_fk_basedata_partner_id` (`partner_id`),
  KEY `sale_saleorder_user_id_1b41e486_fk_auth_user_id` (`user_id`),
  CONSTRAINT `sale_saleorder_org_id_1d0df2d2_fk_organ_organization_id` FOREIGN KEY (`org_id`) REFERENCES `organ_organization` (`id`),
  CONSTRAINT `sale_saleorder_partner_id_31af6b7e_fk_basedata_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `basedata_partner` (`id`),
  CONSTRAINT `sale_saleorder_user_id_1b41e486_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sale_saleorder` */

/*Table structure for table `selfhelp_activity` */

DROP TABLE IF EXISTS `selfhelp_activity`;

CREATE TABLE `selfhelp_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `begin` date DEFAULT NULL,
  `end` date DEFAULT NULL,
  `creator` varchar(20) DEFAULT NULL,
  `modifier` varchar(20) DEFAULT NULL,
  `creation` datetime DEFAULT NULL,
  `modification` datetime DEFAULT NULL,
  `begin_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `enroll_deadline` datetime DEFAULT NULL,
  `title` varchar(120) NOT NULL,
  `description` longtext,
  `host` varchar(80) DEFAULT NULL,
  `speaker` varchar(80) DEFAULT NULL,
  `accept_enroll` tinyint(1) NOT NULL,
  `location` varchar(80) DEFAULT NULL,
  `classification` varchar(2),
  `mail_list` longtext,
  `mail_notice` tinyint(1) NOT NULL,
  `short_message_notice` tinyint(1) NOT NULL,
  `weixin_notice` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `publish_time` datetime DEFAULT NULL,
  `attach` varchar(100) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `code` varchar(20),
  PRIMARY KEY (`id`),
  KEY `selfhelp_activity_parent_id_1638e788_fk_selfhelp_activity_id` (`parent_id`),
  KEY `selfhelp_activity_room_id_76f73121_fk_basedata_material_id` (`room_id`),
  CONSTRAINT `selfhelp_activity_parent_id_1638e788_fk_selfhelp_activity_id` FOREIGN KEY (`parent_id`) REFERENCES `selfhelp_activity` (`id`),
  CONSTRAINT `selfhelp_activity_room_id_76f73121_fk_basedata_material_id` FOREIGN KEY (`room_id`) REFERENCES `basedata_material` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_activity` */

insert  into `selfhelp_activity`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`begin_time`,`end_time`,`enroll_deadline`,`title`,`description`,`host`,`speaker`,`accept_enroll`,`location`,`classification`,`mail_list`,`mail_notice`,`short_message_notice`,`weixin_notice`,`status`,`publish_time`,`attach`,`parent_id`,`room_id`,`code`) values (1,'2015-06-11','9999-12-31','zhugl',NULL,'2015-06-11 22:36:57','2015-06-11 22:36:57','2015-06-12 10:34:00','2015-06-12 16:34:00',NULL,'hadoop大数据应用Qcon分享','关于hadoop大数据技术分享','张三','李四',1,'','T','nsg@abc.com;cuc@abc.com;',1,1,1,0,NULL,'',NULL,6,'AC00001'),(2,'2015-07-01','9999-12-31','chengcai','chengcai','2015-07-01 06:17:53','2015-07-01 06:37:00','2015-07-01 18:17:00','2015-07-02 00:17:00',NULL,'2','1234567','','',1,'','M','',1,1,1,0,NULL,'',NULL,6,'AC00002'),(3,'2015-07-01','9999-12-31','chengcai',NULL,'2015-07-01 06:37:21','2015-07-01 06:37:21','2015-07-01 18:37:00','2015-07-02 00:37:00',NULL,'123','123','','',1,'','M','',1,1,1,0,NULL,'',NULL,6,'AC00003');

/*Table structure for table `selfhelp_enroll` */

DROP TABLE IF EXISTS `selfhelp_enroll`;

CREATE TABLE `selfhelp_enroll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enroll_time` datetime NOT NULL,
  `activity_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selfhelp_enroll_activity_id_5615acbc_fk_selfhelp_activity_id` (`activity_id`),
  KEY `selfhelp_enroll_user_id_a71585e_fk_auth_user_id` (`user_id`),
  CONSTRAINT `selfhelp_enroll_activity_id_5615acbc_fk_selfhelp_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `selfhelp_activity` (`id`),
  CONSTRAINT `selfhelp_enroll_user_id_a71585e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_enroll` */

/*Table structure for table `selfhelp_feedback` */

DROP TABLE IF EXISTS `selfhelp_feedback`;

CREATE TABLE `selfhelp_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed_time` datetime NOT NULL,
  `rank` varchar(2) DEFAULT NULL,
  `comment` varchar(80) DEFAULT NULL,
  `activity_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selfhelp_feedback_activity_id_1591e8eb_fk_selfhelp_activity_id` (`activity_id`),
  KEY `selfhelp_feedback_user_id_10b5739_fk_auth_user_id` (`user_id`),
  CONSTRAINT `selfhelp_feedback_activity_id_1591e8eb_fk_selfhelp_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `selfhelp_activity` (`id`),
  CONSTRAINT `selfhelp_feedback_user_id_10b5739_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_feedback` */

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
  `loan_amount` decimal(10,2) DEFAULT NULL,
  `logout_amount` decimal(10,2) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `description` longtext,
  `pay_time` datetime,
  `pay_user` varchar(40),
  `is_clear` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `selfhelp_loan_project_id_7b541607_fk_basedata_project_id` (`project_id`),
  KEY `selfhelp_loan_user_id_1d36464e_fk_auth_user_id` (`user_id`),
  CONSTRAINT `selfhelp_loan_project_id_7b541607_fk_basedata_project_id` FOREIGN KEY (`project_id`) REFERENCES `basedata_project` (`id`),
  CONSTRAINT `selfhelp_loan_user_id_1d36464e_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_loan` */

insert  into `selfhelp_loan`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`status`,`logout_time`,`loan_amount`,`logout_amount`,`project_id`,`user_id`,`description`,`pay_time`,`pay_user`,`is_clear`) values (1,'2015-07-04','9999-12-31','zhangsan',NULL,'2015-07-04 13:36:53','2015-07-04 13:36:53','JK00001','2015年3月份行政部备用金','N',NULL,'3000.00',NULL,7,13,'行政部零星采购使用',NULL,NULL,0);

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
  `pay_user` varchar(40),
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_reimbursement` */

insert  into `selfhelp_reimbursement`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`title`,`bank_account`,`status`,`amount`,`loan_amount`,`logout_amount`,`pay_amount`,`pay_time`,`loan_id`,`org_id`,`project_id`,`user_id`,`wo_id`,`description`,`pay_user`) values (1,'2015-07-04','9999-12-31','zhangsan','zhangsan','2015-07-04 13:38:14','2015-07-04 13:39:59','BX00001','15年3月份行政部费用报销',NULL,'N','1348.00',NULL,'1348.00','0.00',NULL,1,72,7,13,NULL,'印刷宣传册及维修费',NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_reimbursementitem` */

insert  into `selfhelp_reimbursementitem`(`id`,`begin`,`amount`,`memo`,`expense_account_id`,`reimbursement_id`) values (1,'2015-07-04','1258.00','印刷企业宣传册',18,1),(2,'2015-07-04','90.00','维修公司打印机',25,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_woextravalue` */

insert  into `selfhelp_woextravalue`(`id`,`param_value`,`param_name_id`,`workorder_id`) values (1,NULL,1,2),(2,NULL,2,2),(3,NULL,3,2),(4,NULL,4,4),(5,NULL,5,4),(6,NULL,6,4),(7,NULL,7,4),(8,NULL,19,1);

/*Table structure for table `selfhelp_woitem` */

DROP TABLE IF EXISTS `selfhelp_woitem`;

CREATE TABLE `selfhelp_woitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,4) DEFAULT NULL,
  `price` decimal(10,4) DEFAULT NULL,
  `material_id` int(11) DEFAULT NULL,
  `workorder_id` int(11) NOT NULL,
  `measure_id` int(11),
  PRIMARY KEY (`id`),
  KEY `selfhelp_woitem_material_id_34e897bf_fk_basedata_material_id` (`material_id`),
  KEY `selfhelp_woitem_be2c0a1b` (`workorder_id`),
  KEY `selfhelp_woitem_80c371ce` (`measure_id`),
  CONSTRAINT `selfhelp_woitem_material_id_34e897bf_fk_basedata_material_id` FOREIGN KEY (`material_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `selfhelp_woitem_measure_id_2352ebad_fk_basedata_measure_id` FOREIGN KEY (`measure_id`) REFERENCES `basedata_measure` (`id`),
  CONSTRAINT `selfhelp_woitem_workorder_id_6a435420_fk_selfhelp_workorder_id` FOREIGN KEY (`workorder_id`) REFERENCES `selfhelp_workorder` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_woitem` */

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
  `attach` varchar(100),
  `detail` varchar(100),
  PRIMARY KEY (`id`),
  KEY `selfhelp_workorder_service_id_17a66979_fk_basedata_material_id` (`service_id`),
  KEY `selfhelp_workorder_user_id_72d939fa_fk_auth_user_id` (`user_id`),
  KEY `selfhelp_workorder_b098ad43` (`project_id`),
  KEY `selfhelp_workorder_12b2c0fd` (`refer_id`),
  CONSTRAINT `selfhelp_workorder_project_id_66ab927f_fk_basedata_project_id` FOREIGN KEY (`project_id`) REFERENCES `basedata_project` (`id`),
  CONSTRAINT `selfhelp_workorder_refer_id_212bc854_fk_selfhelp_workorder_id` FOREIGN KEY (`refer_id`) REFERENCES `selfhelp_workorder` (`id`),
  CONSTRAINT `selfhelp_workorder_service_id_17a66979_fk_basedata_material_id` FOREIGN KEY (`service_id`) REFERENCES `basedata_material` (`id`),
  CONSTRAINT `selfhelp_workorder_user_id_72d939fa_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `selfhelp_workorder` */

insert  into `selfhelp_workorder`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`title`,`description`,`business_domain`,`classification`,`status`,`answer`,`service_id`,`user_id`,`project_id`,`code`,`refer_id`,`attach`,`detail`) values (1,'2015-07-04','9999-12-31','zhangsan','zhangsan','2015-07-04 10:56:34','2015-07-04 18:21:01','申请采购办公用品一批','2015年3月份办公用品采购，详细查看明细,2','OT','D','NEW',NULL,62,13,8,'WO00001',NULL,'',''),(2,'2015-07-04','9999-12-31','zhangsan',NULL,'2015-07-04 11:58:58','2015-07-04 11:58:58','出差申请（重庆）','因项目需要，前往重庆出差。','OT','S','NEW',NULL,1,13,NULL,'WO00002',NULL,'',''),(3,'2015-07-04','9999-12-31','zhangsan','zhangsan','2015-07-04 12:15:27','2015-07-04 15:19:05','2号楼3楼男厕所小便池堵塞','内有烟头，请安排人员清理','OT','R','NEW',NULL,NULL,13,NULL,'WO00003',NULL,'',''),(4,'2015-07-04','9999-12-31','zhangsan',NULL,'2015-07-04 12:18:14','2015-07-04 12:18:14','用车申请（张江）','','OT','S','NEW',NULL,3,13,NULL,'WO00004',NULL,'','');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_module` */

insert  into `syscfg_module`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`url`,`weight`,`icon`,`status`,`parent_id`) values (1,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 07:30:01','2015-05-01 07:30:01','U001','系统管理','',99,'',1,NULL),(2,'2015-05-01','9999-12-31','zhugl',NULL,'2015-05-01 07:51:45','2015-05-01 07:51:45','U002','基础数据','',99,'',1,NULL),(3,'2015-05-24','9999-12-31','zhugl',NULL,'2015-05-24 20:02:43','2015-05-24 20:02:43','HR','人力资源','',99,'',1,NULL),(4,'2015-05-24','9999-12-31','zhugl',NULL,'2015-05-24 20:07:15','2015-05-24 20:07:15','U004','个人自助','',99,'',1,NULL),(5,'2015-06-03','9999-12-31','zhugl',NULL,'2015-06-03 20:00:04','2015-06-03 20:00:04','U005','采购管理','',99,'',1,NULL),(6,'2015-06-14','9999-12-31','zhugl',NULL,'2015-06-14 11:08:29','2015-06-14 11:08:29','SA','销售管理','',99,'',1,NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_role` */

insert  into `syscfg_role`(`id`,`begin`,`end`,`creator`,`modifier`,`creation`,`modification`,`code`,`name`,`description`,`status`,`parent_id`) values (1,'2015-05-01','9999-12-31','zhugl','zhugl','2015-05-01 07:31:46','2015-05-10 16:53:23','R001','职员','',1,NULL),(2,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:41:11','2015-06-23 20:41:11','R002','部门经理','',1,NULL),(3,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:41:23','2015-06-23 20:41:23','R003','副总经理','',1,NULL),(4,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:41:47','2015-06-23 20:41:47','R004','人事经理','',1,NULL),(5,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:41:55','2015-06-23 20:41:55','R005','财务经理','',1,NULL),(6,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:42:12','2015-06-23 20:42:12','R006','人事专员','',1,NULL),(7,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:42:18','2015-06-23 20:42:18','R007','财务会计','',1,NULL),(9,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:42:37','2015-06-23 20:42:37','R009','财务出纳','',1,NULL),(10,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:43:02','2015-06-23 20:43:02','R010','行政专员','',1,NULL),(11,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:43:12','2015-06-23 20:43:12','R011','市场销售','',1,NULL),(12,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:43:24','2015-06-23 20:43:24','R012','库存专员','',1,NULL),(13,'2015-06-23','9999-12-31','zhugl',NULL,'2015-06-23 20:43:32','2015-06-23 20:43:32','R013','总经理','',1,NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_role_users` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `syscfg_site_user` */

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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_history` */

insert  into `workflow_history`(`id`,`pro_time`,`pro_type`,`memo`,`inst_id`,`node_id`,`user_id`) values (1,'2015-07-02 06:19:52',0,NULL,1,NULL,14),(2,'2015-07-03 05:48:11',1,'同意',1,5,13),(3,'2015-07-03 05:50:38',1,'好',1,6,16),(4,'2015-07-03 05:51:08',1,'',1,7,16),(7,'2015-07-05 09:44:25',0,NULL,3,NULL,14),(14,'2015-07-09 21:25:38',1,'123',3,5,13),(15,'2015-07-12 01:26:21',1,'12',3,6,16),(16,'2015-07-12 01:26:40',1,'123',3,7,16),(20,'2015-07-30 21:24:06',0,NULL,8,NULL,14);

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_instance` */

insert  into `workflow_instance`(`id`,`code`,`object_id`,`start_time`,`approved_time`,`status`,`modal_id`,`starter_id`) values (1,'S00001',8,'2015-07-02 06:19:52','2015-07-03 05:51:08',99,2,14),(3,'S00003',9,'2015-07-05 09:44:25','2015-07-12 01:26:40',99,2,14),(8,'S00008',7,'2015-07-30 21:24:06',NULL,1,2,14);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_instance_current_nodes` */

insert  into `workflow_instance_current_nodes`(`id`,`instance_id`,`node_id`) values (3,8,5);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_modal` */

insert  into `workflow_modal`(`id`,`code`,`name`,`description`,`app_name`,`model_name`,`begin`,`end`,`content_type_id`) values (1,'WF001','新员工入职流程','','basedata','employee','2015-05-10','9999-12-31',30),(2,'WF002','项目审批流程','','basedata','project','2015-07-01','9999-12-31',19);

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
  `next_node_handler` varchar(40),
  `next_user_handler` varchar(40),
  `status_field` varchar(40),
  `status_value` varchar(40),
  `action` varchar(40),
  `can_edit` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workflow_node_modal_id_3aa9d381_fk_workflow_modal_id` (`modal_id`),
  CONSTRAINT `workflow_node_modal_id_3aa9d381_fk_workflow_modal_id` FOREIGN KEY (`modal_id`) REFERENCES `workflow_modal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node` */

insert  into `workflow_node`(`id`,`code`,`name`,`tooltip`,`start`,`stop`,`can_terminate`,`can_deny`,`email_notice`,`short_message_notice`,`approve_node`,`handler`,`handler_type`,`modal_id`,`next_node_handler`,`next_user_handler`,`status_field`,`status_value`,`action`,`can_edit`) values (3,'N01','薪酬专员审批','',0,0,0,1,1,0,0,'',1,1,NULL,NULL,NULL,NULL,NULL,0),(4,'N02','合同专员审批','',0,0,0,1,1,0,0,'',1,1,NULL,NULL,NULL,NULL,NULL,0),(5,'N01','商务主管审批',NULL,0,0,0,1,1,0,0,'',1,2,'project.budge.gt.10000','up.position.user','status','02','',1),(6,'N02','财务经理审批',NULL,0,0,0,1,1,0,0,'',1,2,'','up.position.user','status','03','action.test',0),(7,'N03','总经理审批',NULL,0,0,0,1,1,0,0,'',2,2,'','','','','',0);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node_positions` */

insert  into `workflow_node_positions`(`id`,`node_id`,`position_id`) values (1,7,87);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `workflow_node_users` */

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `workflow_todolist` */

insert  into `workflow_todolist`(`id`,`app_name`,`model_name`,`arrived_time`,`is_read`,`read_time`,`inst_id`,`node_id`,`user_id`,`code`,`status`) values (1,'basedata','project','2015-07-02 06:19:52',1,'2015-07-02 06:20:23',1,5,13,'TD00001',1),(2,'basedata','project','2015-07-03 05:48:11',1,'2015-07-03 05:50:21',1,6,16,'TD00002',1),(3,'basedata','project','2015-07-03 05:50:38',1,'2015-07-03 05:50:39',1,7,16,'TD00003',1),(5,'basedata','project','2015-07-05 09:44:25',1,'2015-07-05 09:49:38',3,5,13,'TD00005',1),(12,'basedata','project','2015-07-09 21:25:38',1,'2015-07-12 01:26:17',3,6,16,'TD00012',1),(13,'basedata','project','2015-07-12 01:26:21',1,'2015-07-12 01:26:21',3,7,16,'TD00013',1),(17,'basedata','project','2015-07-30 21:24:06',1,'2015-07-30 21:24:17',8,5,13,'TD00017',0),(18,'basedata','project','2015-07-30 21:24:06',1,'2015-07-30 21:24:06',8,NULL,14,'TD00018',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
