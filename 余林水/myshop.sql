-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: myshop
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add group',4,'add_group'),(11,'Can change group',4,'change_group'),(12,'Can delete group',4,'delete_group'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add users',7,'add_users'),(20,'Can change users',7,'change_users'),(21,'Can delete users',7,'delete_users');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(11) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` double(6,2) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail`
--

LOCK TABLES `detail` WRITE;
/*!40000 ALTER TABLE `detail` DISABLE KEYS */;
INSERT INTO `detail` VALUES (16,13,3,'fwef',440.00,3),(17,14,5,'男士天丝休闲裤',345.00,7),(18,14,3,'fwef',440.00,6);
/*!40000 ALTER TABLE `detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(4,'auth','group'),(2,'auth','permission'),(3,'auth','user'),(5,'contenttypes','contenttype'),(7,'myadmin','users'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-11-07 08:57:47.581898'),(2,'auth','0001_initial','2017-11-07 08:57:53.391523'),(3,'admin','0001_initial','2017-11-07 08:57:53.981774'),(4,'admin','0002_logentry_remove_auto_add','2017-11-07 08:57:54.063590'),(5,'contenttypes','0002_remove_content_type_name','2017-11-07 08:57:54.265545'),(6,'auth','0002_alter_permission_name_max_length','2017-11-07 08:57:54.339569'),(7,'auth','0003_alter_user_email_max_length','2017-11-07 08:57:54.465570'),(8,'auth','0004_alter_user_username_opts','2017-11-07 08:57:54.480991'),(9,'auth','0005_alter_user_last_login_null','2017-11-07 08:57:54.599646'),(10,'auth','0006_require_contenttypes_0002','2017-11-07 08:57:54.605073'),(11,'auth','0007_alter_validators_add_error_messages','2017-11-07 08:57:54.641882'),(12,'auth','0008_alter_user_username_max_length','2017-11-07 08:57:54.792277'),(13,'sessions','0001_initial','2017-11-07 08:57:54.973857'),(14,'myadmin','0001_initial','2017-11-07 09:12:42.857546');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4z5f2cvicrzmkjc8p8tys80w9yuqjr51','MGNhMDhlZTEyZDg0MDBlMDNlZjlkZTAwYTcwMzQwZjZhOTI4ZjdiYzp7InNob3BsaXN0Ijp7IjMiOnsicHJpY2UiOjQ0MC4wLCJnb29kcyI6ImZ3ZWYiLCJwaWNuYW1lIjoiMTUxMDIwMTQ2Mi4xNjAyNy5qcGciLCJzdG9yZSI6MjMsImlkIjozLCJtIjo5fSwiNiI6eyJwcmljZSI6MTM0LjAsImdvb2RzIjoiXHU2MmQzXHU4ZGVmXHU4MDA1XHU1NzA2XHU5ODg2XHU1MzZiXHU4ODYzXHU3NTM3XHU1MmEwXHU3ZWQyXHU1MmEwXHU1MzlhXHU2OGM5XHU4ZDI4XHU5NzUyXHU1ZTc0XHU3NTM3XHU1OGViXHU1MzZiXHU4ODYzXHU1OTU3XHU1OTM0XHU1MWFjXHU1YjYzXHU1YmJkXHU2NzdlIiwicGljbmFtZSI6IjE1MTAyMTQwNjMuNTkwOTUzNC5qcGciLCJzdG9yZSI6MjM0LCJpZCI6NiwibSI6OH0sIjUiOnsicHJpY2UiOjM0NS4wLCJnb29kcyI6Ilx1NzUzN1x1NThlYlx1NTkyOVx1NGUxZFx1NGYxMVx1OTVmMlx1ODhlNCIsInBpY25hbWUiOiIxNTEwMjEzMjI4LjYxNzQ5OTQuanBnIiwic3RvcmUiOjM0LCJpZCI6NSwibSI6MTl9fSwib3JkZXJzbGlzdCI6eyIzIjp7InByaWNlIjo0NDAuMCwiZ29vZHMiOiJmd2VmIiwicGljbmFtZSI6IjE1MTAyMDE0NjIuMTYwMjcuanBnIiwic3RvcmUiOjIzLCJpZCI6MywibSI6OX0sIjYiOnsicHJpY2UiOjEzNC4wLCJnb29kcyI6Ilx1NjJkM1x1OGRlZlx1ODAwNVx1NTcwNlx1OTg4Nlx1NTM2Ylx1ODg2M1x1NzUzN1x1NTJhMFx1N2VkMlx1NTJhMFx1NTM5YVx1NjhjOVx1OGQyOFx1OTc1Mlx1NWU3NFx1NzUzN1x1NThlYlx1NTM2Ylx1ODg2M1x1NTk1N1x1NTkzNFx1NTFhY1x1NWI2M1x1NWJiZFx1Njc3ZSIsInBpY25hbWUiOiIxNTEwMjE0MDYzLjU5MDk1MzQuanBnIiwic3RvcmUiOjIzNCwiaWQiOjYsIm0iOjh9fSwidG90YWwiOjUwMzIuMCwiYWRtaW51c2VyIjoid3d3IiwidmlwdXNlcnMiOiJcdTU5ZGFcdTY2MGUifQ==','2017-12-01 13:46:50.845664'),('ajwo6pqd9biejgule7iw9hjl3d0aectc','Y2I2MGZjZThmZjZkMDFhY2I2YmRiNGIxZmFmYWNhM2VmYThiYWY0ZDp7InZpcHVzZXJzIjp7ImFkZHJlc3MiOiIiLCJwaG9uZSI6IjE1ODg4NDAxNTcyIiwicGFzc3dvcmQiOiJlMTBhZGMzOTQ5YmE1OWFiYmU1NmUwNTdmMjBmODgzZSIsImNvZGUiOiIiLCJ1c2VybmFtZSI6ImJiYyIsImlkIjoxMCwibmFtZSI6Ilx1NWMwZlx1NzY3ZCJ9LCJzaG9wbGlzdCI6e30sImFkbWludXNlciI6Ind3dyIsInZlcmlmeWNvZGUiOiIyMzAzIn0=','2017-12-04 12:06:10.113598'),('orm896acumia28p6ngom93e4934o080l','NzM0NTlhYTBkOTFlMjcwZTVlYWNkZjJkMGFkZTMzNGQxN2UyNDNkYTp7InZpcHVzZXJzIjoiIiwic2hvcGxpc3QiOnsiMyI6eyJwaWNuYW1lIjoiMTUxMDIwMTQ2Mi4xNjAyNy5qcGciLCJzdG9yZSI6MjMsIm0iOjQsInByaWNlIjo0NDAuMCwiZ29vZHMiOiJmd2VmIiwiaWQiOjN9LCI1Ijp7InByaWNlIjozNDUuMCwicGljbmFtZSI6IjE1MTAyMTMyMjguNjE3NDk5NC5qcGciLCJnb29kcyI6Ilx1NzUzN1x1NThlYlx1NTkyOVx1NGUxZFx1NGYxMVx1OTVmMlx1ODhlNCIsIm0iOjEwLCJpZCI6NX0sIjYiOnsicGljbmFtZSI6IjE1MTAyMTQwNjMuNTkwOTUzNC5qcGciLCJzdG9yZSI6MjM0LCJtIjo1LCJwcmljZSI6MTM0LjAsImdvb2RzIjoiXHU2MmQzXHU4ZGVmXHU4MDA1XHU1NzA2XHU5ODg2XHU1MzZiXHU4ODYzXHU3NTM3XHU1MmEwXHU3ZWQyXHU1MmEwXHU1MzlhXHU2OGM5XHU4ZDI4XHU5NzUyXHU1ZTc0XHU3NTM3XHU1OGViXHU1MzZiXHU4ODYzXHU1OTU3XHU1OTM0XHU1MWFjXHU1YjYzXHU1YmJkXHU2NzdlIiwiaWQiOjZ9fSwiYWRtaW4iOiIifQ==','2017-11-30 13:18:11.205966'),('pkcrt2ks94rjpyexyx7ld0gohytseban','MzYwZjVhYmMxNjk1ODkwY2FhZDE1NzdjNDk4N2UxNzUyYzc3MmIxOTp7ImFkbWludXNlciI6eyJwYXNzd29yZCI6ImUxMGFkYzM5NDliYTU5YWJiZTU2ZTA1N2YyMGY4ODNlIiwidXNlcm5hbWUiOiJ3d3ciLCJpZCI6MywibmFtZSI6Ind3dyJ9fQ==','2017-11-21 15:42:20.736328'),('yjp42tpe5ectjaw0eqcno1uuzmrmqqi5','MGMyYzZiNTFjYmM5MzM4MjIyMDBhZmZlMzA2NDExOTk5ZTFjZWRhMjp7ImFkbWludXNlciI6Ind3dyJ9','2017-11-23 00:43:49.943840');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `typeid` int(10) unsigned DEFAULT NULL,
  `goods` varchar(32) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `descr` text,
  `price` double(6,2) DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `store` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `clicknum` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (1,6,'男士天丝休闲裤','5er8o','                    ',300.00,'1510198060.7875981.jpg',1,23,0,5,1510198060),(8,3,'456','eff','                    ',123.00,'1510555843.4234176.bmp',1,234,0,0,1510555843),(3,7,'fwef','fww','                    ',440.00,'1510201462.16027.jpg',1,23,0,30,1510201463),(5,6,'男士天丝休闲裤','日韩','                    ',345.00,'1510213228.6174994.jpg',1,34,0,15,1510213228),(6,6,'拓路者圆领卫衣男加绒加厚棉质青年男士卫衣套头冬季宽松','中国','                    ',134.00,'1510214063.5909534.jpg',1,234,0,5,1510214063),(7,13,'6','46','                    ',6.00,'1510230158.6791341.jpg',1,64,0,1,1510230158);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myweb_detail`
--

DROP TABLE IF EXISTS `myweb_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myweb_detail` (
  `id` int(11) NOT NULL,
  `orderid` int(11) DEFAULT NULL,
  `goodsid` int(11) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  `price` double(6,2) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `orderid` FOREIGN KEY (`id`) REFERENCES `myweb_orders` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myweb_detail`
--

LOCK TABLES `myweb_detail` WRITE;
/*!40000 ALTER TABLE `myweb_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `myweb_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myweb_goods`
--

DROP TABLE IF EXISTS `myweb_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myweb_goods` (
  `id` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `goods` varchar(32) DEFAULT NULL,
  `company` varchar(50) DEFAULT NULL,
  `descr` text,
  `price` double(6,2) DEFAULT NULL,
  `picname` varchar(255) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '1',
  `store` int(11) DEFAULT '0',
  `num` int(11) DEFAULT '0',
  `clicknum` int(11) DEFAULT '0',
  `addtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `typeid` FOREIGN KEY (`id`) REFERENCES `myweb_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myweb_goods`
--

LOCK TABLES `myweb_goods` WRITE;
/*!40000 ALTER TABLE `myweb_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `myweb_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myweb_orders`
--

DROP TABLE IF EXISTS `myweb_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myweb_orders` (
  `id` int(11) NOT NULL,
  `uid` int(11) DEFAULT NULL,
  `linkman` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL,
  `total` double(8,2) DEFAULT NULL,
  `status` tinyint(255) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myweb_orders`
--

LOCK TABLES `myweb_orders` WRITE;
/*!40000 ALTER TABLE `myweb_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `myweb_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myweb_type`
--

DROP TABLE IF EXISTS `myweb_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myweb_type` (
  `id` int(11) NOT NULL,
  `name` varchar(32) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myweb_type`
--

LOCK TABLES `myweb_type` WRITE;
/*!40000 ALTER TABLE `myweb_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `myweb_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `myweb_users`
--

DROP TABLE IF EXISTS `myweb_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `myweb_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `name` varchar(16) DEFAULT NULL,
  `password` char(32) NOT NULL,
  `sex` tinyint(1) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `state` tinyint(1) DEFAULT '1',
  `addtime` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `myweb_users`
--

LOCK TABLES `myweb_users` WRITE;
/*!40000 ALTER TABLE `myweb_users` DISABLE KEYS */;
INSERT INTO `myweb_users` VALUES (2,'12321','awd','202cb962ac59075b964b07152d234b70',1,'','','','12313',1,1510067197),(3,'www','www','e10adc3949ba59abbe56e057f20f883e',1,'','','','12345qq@.com',0,1510068528),(4,'ww','','e10adc3949ba59abbe56e057f20f883e',1,'','','123345','12367qq@.com',1,1510111458),(5,'fwf','','81dc9bdb52d04dc20036dbd8313ed055',0,'','','','12389qq@.com',0,1510201351),(6,'姚明','姚明','e10adc3949ba59abbe56e057f20f883e',1,'上海','654321','12345678111','12345qq78@.com',1,1510233940),(7,'科比','科比','e10adc3949ba59abbe56e057f20f883e',1,'美国','123456','654321','12345789qq@.com',1,1510234010),(8,'小蜜','小蜜','e10adc3949ba59abbe56e057f20f883e',0,'北极','876543','','123457899qq@.com',1,1510234086),(9,'abc','l李师师','e10adc3949ba59abbe56e057f20f883e',0,'水浒传','123456','654321','12309qq@.com',1,1510629752),(10,'bbc','小白','e10adc3949ba59abbe56e057f20f883e',1,'','','15888401572','',1,1510641010),(11,'ddd','','698d51a19d8a121ce581499d7b701668',1,'','','','',1,1510650559),(12,'aaa','','96e79218965eb72c92a549dd5a330112',1,'','','','',1,1510650685);
/*!40000 ALTER TABLE `myweb_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `linkman` varchar(32) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `code` char(6) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `addtime` int(11) DEFAULT NULL,
  `total` double(8,2) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (13,10,'小白','shangh','345678','15888401572',1511178116,1320.00,0),(14,10,'小白','北京','890234','15888401572',1511179570,5055.00,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  `pid` int(11) DEFAULT '0',
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (1,'服装',0,'0,'),(2,'数码',0,'0,'),(3,'电脑',2,'0,2,'),(4,'CCC',3,'0,2,3,'),(5,'手机',2,'0,2,'),(6,'男装',1,'0,1,'),(7,'女装',1,'0,1,'),(8,'FFF',7,'0,1,7,'),(9,'123',6,'0,1,6,'),(10,'111',9,'0,1,6,9,'),(11,'222',9,'0,1,6,9,'),(12,'食品',0,'0,'),(13,'er',1,'0,1,');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `name` varchar(16) NOT NULL,
  `password` varchar(32) NOT NULL,
  `sex` int(11) NOT NULL,
  `address` varchar(255) NOT NULL,
  `code` varchar(6) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `email` varchar(50) NOT NULL,
  `state` int(11) NOT NULL,
  `addtime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'zhangsan','张三','e10adc3949ba59abbe56e057f20f883e',1,'兄弟连','123456','654321','123qq@.com',1,1510046715),(3,'wangwu','王五','25d55ad283aa400af464c76d713c07ad',1,'兄弟连','456789','0987654321','12345qq@.com',1,1510059535),(4,'tianqi','田七','6531401f9a6807306651b87e44c05751',1,'兄弟连','123456','567890','1236qq@.com',1,1510060238);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-22 19:20:06
