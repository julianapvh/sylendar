CREATE DATABASE  IF NOT EXISTS `bd_agendamentos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bd_agendamentos`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_agendamentos
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
-- Table structure for table `agendamentos_agendamento`
--

DROP TABLE IF EXISTS `agendamentos_agendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_agendamento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cliente_nome` varchar(100) NOT NULL,
  `cliente_cpf` varchar(11) NOT NULL,
  `data` date NOT NULL,
  `hora` time(6) NOT NULL,
  `prazo_devolucao` date DEFAULT NULL,
  `tipo_servico` varchar(100) NOT NULL,
  `cancelado` tinyint(1) NOT NULL,
  `reagendado` tinyint(1) NOT NULL,
  `equipamento_id` bigint NOT NULL,
  `data_entrega_prevista` datetime(6) DEFAULT NULL,
  `nova_data` date DEFAULT NULL,
  `data_original` date DEFAULT NULL,
  `hora_original` time(6) DEFAULT NULL,
  `nova_hora` time(6) DEFAULT NULL,
  `data_emprestimo` datetime(6) DEFAULT NULL,
  `prazo_restante` bigint DEFAULT NULL,
  `situacao` varchar(100) NOT NULL,
  `emprestado` tinyint(1) NOT NULL,
  `data_devolucao` datetime(6) DEFAULT NULL,
  `devolvido` tinyint(1) NOT NULL,
  `quantidade_dias` int NOT NULL,
  `cliente_email` varchar(254) NOT NULL,
  `finalizado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen` (`equipamento_id`),
  CONSTRAINT `agendamentos_agendam_equipamento_id_34a6ea1d_fk_agendamen` FOREIGN KEY (`equipamento_id`) REFERENCES `agendamentos_equipamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_agendamento`
--

LOCK TABLES `agendamentos_agendamento` WRITE;
/*!40000 ALTER TABLE `agendamentos_agendamento` DISABLE KEYS */;
INSERT INTO `agendamentos_agendamento` VALUES (1,'juliana3','00000000000','2024-03-14','14:26:00.000000',NULL,'',1,0,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(3,'juliana3','00000000000','2024-03-15','14:27:00.000000',NULL,'',1,0,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(4,'admin','00000000000','2024-03-15','14:34:00.000000',NULL,'',1,0,4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(5,'admin','00000000000','2024-03-15','15:38:00.000000',NULL,'',1,0,27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(6,'admin','00000000000','2024-03-15','14:38:00.000000',NULL,'',1,0,27,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(8,'juliana3','00000000000','2024-03-15','10:17:00.000000',NULL,'',1,0,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(9,'juliana3','00000000000','2024-03-20','10:12:00.000000',NULL,'',1,0,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(10,'juliana3','00000000000','2024-03-15','10:31:00.000000',NULL,'',1,0,15,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(11,'juliana3','00000000000','2024-03-16','11:26:00.000000',NULL,'',1,0,11,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(12,'juliana3','00000000000','2024-03-16','10:52:00.000000',NULL,'',1,0,17,'2024-03-20 14:52:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(13,'juliana3','00000000000','2024-03-15','12:15:00.000000',NULL,'',1,0,19,'2024-03-20 16:15:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(18,'admin','00000000000','2024-03-15','17:01:00.000000',NULL,'',1,0,15,'2024-03-20 21:01:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(19,'admin','00000000000','2024-03-27','16:01:00.000000',NULL,'',1,0,18,'2024-04-01 20:01:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(20,'admin','00000000000','2024-03-16','14:01:00.000000',NULL,'',1,0,7,'2024-03-20 18:01:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(21,'admin','00000000000','2024-03-15','14:07:00.000000',NULL,'',1,0,11,'2024-03-20 18:07:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(22,'juliana3','00000000000','2024-03-15','14:10:00.000000',NULL,'',1,0,7,'2024-03-20 18:10:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(23,'juliana3','00000000000','2024-03-21','13:05:00.000000',NULL,'',1,0,7,'2024-03-26 17:05:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(24,'juliana3','00000000000','2024-03-27','18:05:00.000000',NULL,'',1,0,12,'2024-03-21 16:07:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(25,'juliana3','00000000000','2024-04-18','13:12:00.000000',NULL,'',1,0,11,'2024-04-23 17:12:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(26,'juliana3','00000000000','2024-03-22','14:13:00.000000',NULL,'',1,0,17,'2024-03-27 18:13:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(27,'juliana3','00000000000','2024-05-16','15:13:00.000000',NULL,'',1,0,21,'2024-05-21 19:13:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(28,'juliana3','00000000000','2024-03-19','13:24:00.000000',NULL,'',1,0,16,'2024-03-22 17:24:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(29,'juliana3','00000000000','2024-03-26','14:48:00.000000',NULL,'',1,0,26,'2024-03-25 19:25:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(30,'juliana3','00000000000','2024-03-27','14:44:00.000000',NULL,'',1,0,18,'2024-03-25 16:32:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(31,'juliana3','00000000000','2024-03-20','17:56:00.000000',NULL,'',1,0,18,'2024-03-25 21:56:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(32,'juliana3','00000000000','2024-03-27','16:04:00.000000',NULL,'',1,0,15,'2024-04-01 20:04:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(33,'juliana3','00000000000','2024-03-20','14:10:00.000000',NULL,'',1,0,25,'2024-03-25 18:10:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(34,'juliana3','00000000000','2024-03-28','17:07:00.000000',NULL,'',1,0,15,'2024-04-02 21:07:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(35,'juliana3','00000000000','2024-03-27','17:12:00.000000',NULL,'',1,0,15,'2024-04-01 21:12:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(36,'juliana3','00000000000','2024-03-27','15:10:00.000000',NULL,'',1,0,17,'2024-04-01 19:10:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(37,'juliana3','00000000000','2024-03-28','17:21:00.000000',NULL,'',1,0,18,'2024-04-02 21:21:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(38,'juliana3','00000000000','2024-03-30','14:32:00.000000',NULL,'',1,0,18,'2024-04-03 18:32:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(39,'juliana3','00000000000','2024-03-28','16:38:00.000000',NULL,'',1,0,18,'2024-04-02 20:38:00.000000',NULL,NULL,NULL,NULL,'2024-03-21 12:57:17.253760',NULL,'Emprestado',1,NULL,0,3,'',0),(40,'juliana3','00000000000','2024-03-19','17:45:00.000000',NULL,'',0,0,10,'2024-03-22 21:45:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 13:55:47.172096',435999930230,'Emprestado',1,NULL,1,3,'',0),(41,'juliana3','00000000000','2024-03-25','17:45:00.000000',NULL,'',0,0,16,'2024-03-28 21:45:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 14:20:01.928671',437448320003,'Emprestado',1,NULL,1,3,'',0),(42,'juliana3','00000000000','2024-03-30','17:51:00.000000',NULL,'',0,0,16,'2024-04-03 21:51:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 14:20:20.911189',437465390994,'Emprestado',1,NULL,1,3,'',0),(43,'juliana3','00000000000','2024-03-31','17:57:00.000000',NULL,'',0,0,25,'2024-04-03 21:57:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 14:24:14.265765',437696934539,'Emprestado',1,NULL,1,3,'',0),(44,'juliana3','00000000000','2024-04-20','16:58:00.000000',NULL,'',0,0,11,'2024-04-24 20:58:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 14:26:45.521934',437846499839,'Emprestado',1,NULL,1,3,'',0),(45,'juliana3','00000000000','2024-03-20','10:26:00.000000',NULL,'',0,0,14,'2024-03-25 14:26:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 14:29:46.076219',438025274924,'Emprestado',1,NULL,1,3,'',0),(46,'juliana3','00000000000','2024-03-20','13:25:00.000000',NULL,'',0,0,12,'2024-03-25 17:25:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 16:50:41.222251',446400000000,'Emprestado',1,NULL,1,3,'',0),(47,'juliana1','00000000000','2024-03-20','12:12:00.000000',NULL,'',0,0,18,'2024-03-25 16:12:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 14:13:02.686665',0,'Devolvido',1,NULL,1,3,'',0),(48,'Mariana','00000000000','2024-03-21','11:00:00.000000',NULL,'',1,0,3,'2024-03-26 15:00:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 14:58:54.662051',446339096473,'Emprestado',1,NULL,0,3,'',0),(49,'Mariana','00000000000','2024-03-20','15:00:00.000000',NULL,'',0,0,30,'2024-03-25 19:00:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 16:50:41.232320',446375068740,'Emprestado',1,NULL,1,3,'',0),(50,'juliana3','00000000000','2024-03-27','16:19:00.000000',NULL,'',0,0,4,'2024-04-01 20:19:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 16:50:41.241352',446400000000,'Emprestado',1,NULL,1,3,'',0),(51,'juliana3','00000000000','2024-03-20','13:21:00.000000',NULL,'',1,0,18,'2024-03-25 17:21:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 16:33:45.645028',446380715114,'Emprestado',1,NULL,0,3,'',0),(52,'juliana3','00000000000','2024-03-21','16:47:00.000000',NULL,'',0,0,10,'2024-03-26 20:47:00.000000',NULL,NULL,NULL,NULL,'2024-03-20 16:48:05.230580',446378840713,'Emprestado',1,NULL,1,3,'',0),(53,'juliana3','00000000000','2024-03-21','13:59:00.000000',NULL,'',0,0,9,'2024-03-26 17:59:00.000000',NULL,NULL,NULL,NULL,'2024-03-21 13:00:03.816260',446380560496,'Emprestado',1,NULL,1,3,'',0),(54,'juliana3','00000000000','2024-03-21','12:08:00.000000',NULL,'',0,0,8,'2024-03-26 16:08:00.000000',NULL,NULL,NULL,NULL,'2024-03-21 13:09:19.453798',446374100189,'Devolvido',1,NULL,1,3,'',0),(55,'juliana3','00000000000','2024-03-21','12:31:00.000000',NULL,'',0,0,14,'2024-03-26 16:31:00.000000',NULL,NULL,NULL,NULL,'2024-03-21 13:31:39.745297',446369331338,'Devolvido',1,NULL,1,3,'',0),(56,'juliana3','00000000000','2024-03-21','13:19:00.000000',NULL,'',0,0,21,'2024-03-26 17:19:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:24:16.556644',446327997584,'Devolvido',1,NULL,1,3,'',0),(57,'juliana3','00000000000','2024-03-22','12:20:00.000000',NULL,'',0,0,19,'2024-03-27 16:20:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:24:55.897199',446365188945,'Devolvido',1,NULL,1,3,'',0),(58,'juliana3','00000000000','2024-03-21','12:21:00.000000',NULL,'',0,0,10,'2024-03-26 16:21:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:25:08.961307',446376355778,'Devolvido',1,NULL,1,3,'',0),(59,'juliana3','00000000000','2024-03-22','16:21:00.000000',NULL,'',0,0,9,'2024-03-26 16:23:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:25:07.102587',446371833942,'Devolvido',1,NULL,1,3,'',0),(60,'juliana3','00000000000','2024-03-23','12:16:00.000000',NULL,'testando',0,0,5,'2024-03-27 16:16:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:25:05.066109',359966047823,'Devolvido',1,NULL,1,2,'',0),(61,'juliana3','00000000000','2024-03-24','12:29:00.000000',NULL,'testando',0,0,31,'2024-03-27 16:29:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 13:30:06.871923',266664448470,'Devolvido',1,NULL,1,1,'',0),(62,'juliana3','00000000000','2024-03-23','11:33:00.000000',NULL,'testando',0,0,31,'2024-03-25 15:33:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:21:25.618056',273341112592,'Devolvido',1,NULL,1,1,'',0),(63,'juliana3','00000000000','2024-03-25','11:44:00.000000',NULL,'testando',0,0,31,'2024-03-26 15:44:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:25:03.245901',273556275145,'Devolvido',1,NULL,1,1,'',0),(64,'juliana3','00000000000','2024-03-29','14:45:00.000000',NULL,'testando',0,0,31,'2024-04-03 18:45:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:25:00.563198',446351517615,'Devolvido',1,NULL,1,3,'',0),(65,'almeidamarii1','00000000000','2024-03-25','12:39:00.000000',NULL,'emprestimo',0,0,9,'2024-03-27 16:39:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 14:41:58.399578',360000000000,'Emprestado',1,NULL,0,2,'',0),(66,'almeidamarii1','00000000000','2024-03-25','11:45:00.000000',NULL,'emprestimo',1,0,32,'2024-03-27 15:45:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,2,'',0),(67,'almeidamarii1','00000000000','2024-03-23','14:45:00.000000',NULL,'emprestimo',1,0,32,'2024-03-26 18:45:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,2,'',0),(68,'almeidamarii1','00000000000','2024-03-27','11:48:00.000000',NULL,'emprestimo',1,0,32,'2024-03-28 15:48:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,1,'',0),(69,'almeidamarii1','00000000000','2024-03-23','10:50:00.000000',NULL,'emprestimo',0,0,32,'2024-03-27 14:50:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:19:32.848545',446399993840,'Emprestado',1,NULL,0,3,'',0),(70,'almeidamarii1','00000000000','2024-03-22','14:15:00.000000',NULL,'emprestimo',0,0,32,'2024-03-25 18:15:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 14:50:50.648551',273600000000,'Emprestado',1,NULL,0,1,'',0),(71,'almeidamarii1','00000000000','2024-03-23','12:28:00.000000',NULL,'emprestimo',0,0,16,'2024-03-25 16:28:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:28:40.547341',273600000000,'Emprestado',1,NULL,0,1,'',0),(72,'admin','00000000000','2024-03-25','13:35:00.000000',NULL,'testando',0,0,12,'2024-03-26 17:35:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:36:03.541849',271850558226,'Devolvido',1,NULL,1,1,'',0),(73,'almeidamarii1','00000000000','2024-03-25','14:40:00.000000',NULL,'emprestimo',0,0,23,'2024-03-27 18:40:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:39:32.278045',360000000000,'Emprestado',1,NULL,0,2,'',0),(74,'admin','00000000000','2024-03-23','12:55:00.000000',NULL,'sdfsaf',0,0,12,'2024-03-25 16:55:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:56:25.357585',273070488619,'Devolvido',1,NULL,1,1,'',0),(75,'admin','00000000000','2024-03-22','12:56:00.000000',NULL,'testando',0,0,11,'2024-03-25 16:56:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:56:25.371811',273068627157,'Devolvido',1,NULL,1,1,'',0),(76,'admin','00000000000','2024-03-22','13:55:00.000000',NULL,'testando',0,0,17,'2024-03-26 17:55:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:56:25.384173',359466334428,'Devolvido',1,NULL,1,2,'',0),(77,'admin','00000000000','2024-03-22','13:56:00.000000',NULL,'testando',0,0,15,'2024-03-27 17:56:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 15:56:25.397682',445863802001,'Devolvido',1,NULL,1,3,'',0),(78,'admin','00000000000','2024-03-22','13:50:00.000000',NULL,'testando',0,0,15,'2024-03-25 17:50:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 16:00:30.531884',273306965118,'Devolvido',1,NULL,1,1,'',0),(79,'admin','00000000000','2024-03-25','14:00:00.000000',NULL,'testando',0,0,18,'2024-03-26 18:00:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 16:01:31.257964',273365902701,'Devolvido',1,NULL,1,1,'',0),(80,'admin','00000000000','2024-03-22','15:09:00.000000',NULL,'testando',0,0,27,'2024-03-27 19:09:00.000000',NULL,NULL,NULL,NULL,'2024-03-22 16:09:31.736785',194153566161,'Devolvido',1,NULL,1,3,'',0),(81,'admin','00000000000','2024-03-26','11:12:00.000000',NULL,'testando',1,0,28,'2024-03-28 16:12:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,2,'',0),(82,'admin','00000000000','2024-03-26','13:12:00.000000',NULL,'testando',0,0,15,'2024-03-29 17:12:00.000000',NULL,NULL,NULL,NULL,'2024-03-25 14:13:17.130316',273584635273,'Devolvido',1,NULL,1,3,'',0),(83,'admin','00000000000','2024-03-28','15:27:00.000000',NULL,'testando',1,0,13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,3,'',0),(84,'admin','00000000000','2024-03-26','12:28:00.000000',NULL,'testando',0,0,13,NULL,NULL,NULL,NULL,NULL,'2024-03-25 14:28:27.032652',NULL,'Devolvido',1,NULL,1,3,'',0),(85,'admin','00000000000','2024-03-26','15:34:00.000000',NULL,'testando',0,0,15,NULL,NULL,NULL,NULL,NULL,'2024-03-25 14:34:27.050988',NULL,'Devolvido',1,NULL,1,1,'',0),(86,'juliana1','00000000000','2024-03-26','15:42:00.000000',NULL,'testando',0,0,10,'2024-03-29 19:42:00.000000',NULL,NULL,NULL,NULL,'2024-04-02 14:03:42.587437',273600000000,'Emprestado',1,NULL,1,3,'',0),(87,'juliana3','00000000000','2024-03-28','13:36:00.000000',NULL,'testando',0,0,18,'2024-04-01 17:36:00.000000',NULL,NULL,NULL,NULL,'2024-03-26 17:35:30.890128',187176279993,'Devolvido',1,NULL,1,2,'',0),(88,'admin','00000000000','2024-04-03','13:04:00.000000',NULL,'testando',0,0,10,'2024-04-08 17:04:00.000000',NULL,NULL,NULL,NULL,'2024-04-02 15:05:41.451594',273600000000,'Emprestado',1,NULL,0,3,'',0),(89,'admin','00000000000','2024-04-17','11:07:00.000000',NULL,'testando',0,0,8,'2024-04-18 15:07:00.000000',NULL,NULL,NULL,NULL,'2024-04-03 14:50:02.994612',100799991432,'Emprestado',1,NULL,0,1,'',0),(90,'admin','00000000000','2024-04-17','14:07:00.000000',NULL,'sdfsaf',0,0,17,'2024-04-19 18:07:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Devolvido',0,NULL,1,2,'',0),(91,'juliana3','00000000000','2024-04-16','14:19:00.000000',NULL,'testando',0,0,20,'2024-04-26 18:18:00.000000',NULL,NULL,NULL,NULL,NULL,NULL,'Agendado',0,NULL,0,1,'',0);
/*!40000 ALTER TABLE `agendamentos_agendamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendamentos_equipamento`
--

DROP TABLE IF EXISTS `agendamentos_equipamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_equipamento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `fabricante` varchar(50) NOT NULL,
  `data_aquisicao` date NOT NULL,
  `quantidade_disponivel` int NOT NULL,
  `status` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_equipamento`
--

LOCK TABLES `agendamentos_equipamento` WRITE;
/*!40000 ALTER TABLE `agendamentos_equipamento` DISABLE KEYS */;
INSERT INTO `agendamentos_equipamento` VALUES (2,'Equipamento2','Descri????o do Equipamento 2','Fabricante B','2024-03-20',0,'Ativo'),(3,'Equipamento3','Descri????o do Equipamento 3','Fabricante C','2024-03-07',8,'Ativo'),(4,'Equipamento3','Descri????o do Equipamento 3','Fabricante C','2024-03-07',7,'Ativo'),(5,'Equipamento4','Descri????o do Equipamento 4','Fabricante D','2024-03-07',4,'Ativo'),(6,'Equipamento5','Descri????o do Equipamento 5','Fabricante E','2024-03-08',7,'Ativo'),(7,'Equipamento6','Descri????o do Equipamento 6','Fabricante F','2024-03-09',10,'Ativo'),(8,'Equipamento7','Descri????o do Equipamento 7','Fabricante G','2024-03-10',2,'Ativo'),(9,'Equipamento8','Descri????o do Equipamento 8','Fabricante H','2024-03-11',4,'Ativo'),(10,'Equipamento9','Descri????o do Equipamento 9','Fabricante I','2024-03-12',6,'Ativo'),(11,'Equipamento10','Descri????o do Equipamento 10','Fabricante J','2024-03-13',4,'Ativo'),(12,'Equipamento11','Descri????o do Equipamento 11','Fabricante K','2024-03-14',9,'Ativo'),(13,'Equipamento12','Descri????o do Equipamento 12','Fabricante L','2024-03-15',3,'Ativo'),(14,'Equipamento13','Descri????o do Equipamento 13','Fabricante M','2024-03-16',5,'Ativo'),(15,'Equipamento14','Descri????o do Equipamento 14','Fabricante N','2024-03-17',7,'Ativo'),(16,'Equipamento15','Descri????o do Equipamento 15','Fabricante O','2024-03-18',9,'Ativo'),(17,'Equipamento16','Descri????o do Equipamento 16','Fabricante P','2024-03-19',4,'Ativo'),(18,'Equipamento17','Descri????o do Equipamento 17','Fabricante Q','2024-03-20',6,'Ativo'),(19,'Equipamento18','Descri????o do Equipamento 18','Fabricante R','2024-03-21',8,'Ativo'),(20,'Equipamento19','Descri????o do Equipamento 19','Fabricante S','2024-03-22',4,'Ativo'),(21,'Equipamento20','Descri????o do Equipamento 20','Fabricante T','2024-03-23',7,'Ativo'),(22,'Equipamento22','Descri????o do Equipamento 21','Fabricante U','2024-03-24',2,'Ativo'),(23,'Equipamento23','Descri????o do Equipamento 23','Fabricante U','2024-03-24',1,'Ativo'),(24,'Equipamento24','Descri????o do Equipamento 21','Fabricante U','2024-03-24',2,'Ativo'),(25,'Equipamento25','Descri????o do Equipamento 21','Fabricante U','2024-03-24',2,'Ativo'),(26,'Equipamento26','Descri????o do Equipamento 21','Fabricante U','2024-03-24',2,'Ativo'),(27,'Equipamento27','Descri????o do Equipamento 21','Fabricante U','2024-03-24',0,'cancelado'),(28,'Equipamento28','Descri????o do Equipamento 21','Fabricante U','2024-03-24',1,'disponivel'),(30,'teste','teste mari','mari','2023-11-15',2,'disponivel'),(31,'Teste22','teste','Fabricante B','2019-10-22',2,'disponivel'),(32,'Teste15','testeteste','Ju','2002-11-15',2,'disponivel');
/*!40000 ALTER TABLE `agendamentos_equipamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendamentos_equipamento_usuarios`
--

DROP TABLE IF EXISTS `agendamentos_equipamento_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_equipamento_usuarios` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `equipamento_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agendamentos_equipamento_equipamento_id_user_id_eda279af_uniq` (`equipamento_id`,`user_id`),
  KEY `agendamentos_equipam_user_id_47f7ff6c_fk_agendamen` (`user_id`),
  CONSTRAINT `agendamentos_equipam_equipamento_id_11117a2e_fk_agendamen` FOREIGN KEY (`equipamento_id`) REFERENCES `agendamentos_equipamento` (`id`),
  CONSTRAINT `agendamentos_equipam_user_id_47f7ff6c_fk_agendamen` FOREIGN KEY (`user_id`) REFERENCES `agendamentos_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_equipamento_usuarios`
--

LOCK TABLES `agendamentos_equipamento_usuarios` WRITE;
/*!40000 ALTER TABLE `agendamentos_equipamento_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `agendamentos_equipamento_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendamentos_event`
--

DROP TABLE IF EXISTS `agendamentos_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `equipamento` varchar(100) NOT NULL,
  `data` date NOT NULL,
  `hora` time(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_event`
--

LOCK TABLES `agendamentos_event` WRITE;
/*!40000 ALTER TABLE `agendamentos_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `agendamentos_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendamentos_historicoagendamento`
--

DROP TABLE IF EXISTS `agendamentos_historicoagendamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_historicoagendamento` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data_hora_alteracao` datetime(6) NOT NULL,
  `tipo_alteracao` varchar(100) NOT NULL,
  `agendamento_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `agendamentos_histori_agendamento_id_05342f8d_fk_agendamen` (`agendamento_id`),
  CONSTRAINT `agendamentos_histori_agendamento_id_05342f8d_fk_agendamen` FOREIGN KEY (`agendamento_id`) REFERENCES `agendamentos_agendamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_historicoagendamento`
--

LOCK TABLES `agendamentos_historicoagendamento` WRITE;
/*!40000 ALTER TABLE `agendamentos_historicoagendamento` DISABLE KEYS */;
INSERT INTO `agendamentos_historicoagendamento` VALUES (1,'2024-03-25 14:19:11.291895','Agendamento Original',83),(2,'2024-03-25 14:28:12.425571','Agendamento Original',84),(3,'2024-03-25 14:28:36.397969','Devolu????o',84),(4,'2024-03-25 14:28:36.409924','Devolu????o',84),(5,'2024-03-25 14:34:03.844377','Agendamento Original',85),(6,'2024-03-25 14:34:47.222846','Devolu????o',85),(7,'2024-03-25 14:34:47.232667','Devolu????o',85),(8,'2024-03-25 16:42:58.621657','Agendamento Original',86);
/*!40000 ALTER TABLE `agendamentos_historicoagendamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendamentos_user`
--

DROP TABLE IF EXISTS `agendamentos_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nome_completo` varchar(100) NOT NULL,
  `telefone` varchar(15) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `agendamentos_user_email_d20021aa_uniq` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_user`
--

LOCK TABLES `agendamentos_user` WRITE;
/*!40000 ALTER TABLE `agendamentos_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `agendamentos_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendamentos_user_groups`
--

DROP TABLE IF EXISTS `agendamentos_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agendamentos_user_groups_user_id_group_id_6d91e88f_uniq` (`user_id`,`group_id`),
  KEY `agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id` (`group_id`),
  CONSTRAINT `agendamentos_user_gr_user_id_efc056f5_fk_agendamen` FOREIGN KEY (`user_id`) REFERENCES `agendamentos_user` (`id`),
  CONSTRAINT `agendamentos_user_groups_group_id_f8a1a175_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_user_groups`
--

LOCK TABLES `agendamentos_user_groups` WRITE;
/*!40000 ALTER TABLE `agendamentos_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `agendamentos_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agendamentos_user_user_permissions`
--

DROP TABLE IF EXISTS `agendamentos_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agendamentos_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `agendamentos_user_user_p_user_id_permission_id_f5308dc4_uniq` (`user_id`,`permission_id`),
  KEY `agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm` (`permission_id`),
  CONSTRAINT `agendamentos_user_us_permission_id_6d9e53e5_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `agendamentos_user_us_user_id_676a76fe_fk_agendamen` FOREIGN KEY (`user_id`) REFERENCES `agendamentos_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agendamentos_user_user_permissions`
--

LOCK TABLES `agendamentos_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `agendamentos_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `agendamentos_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (4,'administrador'),(3,'cliente');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (42,4,1),(43,4,2),(44,4,3),(45,4,4),(46,4,5),(47,4,6),(48,4,7),(49,4,8),(50,4,9),(51,4,10),(52,4,11),(53,4,12),(54,4,13),(55,4,14),(56,4,15),(57,4,16),(58,4,17),(59,4,18),(60,4,19),(61,4,20),(62,4,21),(63,4,22),(64,4,23),(65,4,24),(66,4,25),(67,4,26),(68,4,27),(69,4,28),(70,4,29),(71,4,30),(72,4,31),(73,4,32),(74,4,33),(75,4,34),(76,4,35),(77,4,36),(78,4,37),(79,4,38),(80,4,39),(81,4,40),(82,4,41),(83,4,42),(84,4,43),(85,4,44),(86,4,45),(87,4,46);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add equipamento',7,'add_equipamento'),(26,'Can change equipamento',7,'change_equipamento'),(27,'Can delete equipamento',7,'delete_equipamento'),(28,'Can view equipamento',7,'view_equipamento'),(29,'Can add agendamento',8,'add_agendamento'),(30,'Can change agendamento',8,'change_agendamento'),(31,'Can delete agendamento',8,'delete_agendamento'),(32,'Can view agendamento',8,'view_agendamento'),(33,'Can add user',9,'add_user'),(34,'Can change user',9,'change_user'),(35,'Can delete user',9,'delete_user'),(36,'Can view user',9,'view_user'),(37,'Cancelar Agendamento',4,'cancelar_agendamento'),(38,'Historico',4,'historico'),(39,'Meus Agendamentos',4,'meus_agendamentos'),(40,'Listar Equipamentos',4,'listar_equipamentos'),(41,'Cliente',4,'cliente'),(42,'Reagendar Equipamentos',4,'reagendar_equipamentos'),(43,'Agendar Equipamento',4,'agendar_equipamento'),(44,'Register',4,'register'),(45,'Cliente Home',4,'cliente_home'),(46,'Login',4,'login'),(47,'Can add event',10,'add_event'),(48,'Can change event',10,'change_event'),(49,'Can delete event',10,'delete_event'),(50,'Can view event',10,'view_event'),(51,'Can add historico agendamento',11,'add_historicoagendamento'),(52,'Can change historico agendamento',11,'change_historicoagendamento'),(53,'Can delete historico agendamento',11,'delete_historicoagendamento'),(54,'Can view historico agendamento',11,'view_historicoagendamento');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$720000$g0hTfdMULoOMh5z1QlbIA4$+GC/UkjHvFdl7VVfrkWzwrOD0nyJ0wKfZNgT+bBgFlE=','2024-04-09 15:38:45.946494',1,'admin','','','julianacore2@gmail.com',1,1,'2024-03-05 16:50:34.000000'),(11,'pbkdf2_sha256$720000$96heqH13N2KwiDvPTB7X8o$rb1HM3jvjL0EcnWNzLDOwrVONSqeBc8nAKTAWhW0xac=','2024-03-07 17:42:27.137133',0,'isadora','','','',0,1,'2024-03-07 17:42:18.140140'),(12,'pbkdf2_sha256$720000$pMeaiALbgtaZtl3ENNDUvh$HNKw+MnQHHpY4kZfYCLst2ET+y5w3V0S3Uosa8qlmCM=','2024-03-07 17:56:00.442713',1,'isadora2','','','',1,1,'2024-03-07 17:44:23.000000'),(13,'pbkdf2_sha256$720000$MSKhYF9YaU8mBfceWY2uWa$S+bGHO0V5SRF3XOnyUVb5BLdb14YxMI6xQTU379NU08=','2024-03-07 18:38:24.829867',0,'aline','','','',0,1,'2024-03-07 18:38:13.560529'),(14,'pbkdf2_sha256$720000$cX6oieYkMI8Fc9wRNFekmp$VP2/Q3ml9HIwIW/mXtAyzWL3OtIUMwDfbcjK53Ny0jw=','2024-03-22 14:30:40.362771',1,'Mariana','','','',1,1,'2024-03-07 18:45:03.000000'),(15,'pbkdf2_sha256$720000$jEogWo2ssW16ASPksoN5tU$cTEtWjP5lqNggHdexZzbvnO7p3G8q6eQkS/xqmBb4B8=','2024-03-08 13:50:13.327186',0,'isa','','','',0,1,'2024-03-08 13:50:06.484515'),(18,'pbkdf2_sha256$720000$0qi93BkJWKFTKwXlJGVbRK$Xasr458vW0jKzDBf3trrI7lxmxBDWbv+NNxChwUo/q8=','2024-03-11 14:25:35.387788',0,'almeidamarii','','','',0,1,'2024-03-11 14:25:21.496704'),(24,'pbkdf2_sha256$720000$1w08RX7gyxTPu6L90sZisn$DPgy29upl125qzKkdJNOmuLY7c6kiSHzKewVuVak1rc=','2024-04-09 14:32:15.000000',0,'juliana3','','','',0,1,'2024-03-15 16:43:58.000000'),(25,'pbkdf2_sha256$720000$xEOsun4WZlmvqDWuW1DYlU$sk8wSMqPOuk4knLy8lP6G0nj0Mi0nqJb987IhT1hws4=',NULL,0,'juliana2','','','',0,1,'2024-03-15 16:47:38.585349'),(26,'pbkdf2_sha256$720000$x1PoahlD6gw3RBYqJI7Ero$hLulhdj+y+7w5r3uq+3IKBKuE590rR2yaYnPGsPhAUA=','2024-03-25 16:42:48.751180',0,'juliana1','','','',0,1,'2024-03-15 16:49:12.201984'),(27,'pbkdf2_sha256$720000$7WLwRXj0tEoWNsMm3PAAwy$AgpDSrQ2XFTj+c9ovr2EhiTlXjwRN++viKK03tkaGY0=','2024-03-21 13:53:27.000000',1,'Lmar','','','',1,1,'2024-03-21 13:53:20.000000'),(28,'pbkdf2_sha256$720000$GwjmJuoMeuBqqsS91XMcMu$VXwuoUXzWb0wDClB9wXFGM3CJ9aTpsTpoXsCcOfqRFo=','2024-03-22 14:31:20.990089',0,'almeidamarii1','','','',0,1,'2024-03-22 14:31:06.078401'),(30,'pbkdf2_sha256$720000$8gEvQDfWPrFgYHpMVWHgQp$/mVa3GplinatEzrEQcSMsyIDGooes095pV4g5AfKdLg=',NULL,0,'juju2','','','',0,1,'2024-04-02 16:59:00.504096');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (18,1,3),(9,1,4),(10,11,3),(11,12,4),(12,13,3),(13,14,3),(28,14,4),(14,15,3),(17,18,3),(25,24,3),(26,25,3),(27,26,3),(29,27,3),(30,27,4),(31,28,3),(33,30,3);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=349 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (87,1,1),(88,1,2),(89,1,3),(90,1,4),(91,1,5),(92,1,6),(93,1,7),(94,1,8),(95,1,9),(96,1,10),(97,1,11),(98,1,12),(99,1,13),(100,1,14),(101,1,15),(102,1,16),(103,1,17),(104,1,18),(105,1,19),(106,1,20),(107,1,21),(108,1,22),(109,1,23),(110,1,24),(111,1,25),(112,1,26),(113,1,27),(114,1,28),(115,1,29),(116,1,30),(117,1,31),(118,1,32),(119,1,33),(120,1,34),(121,1,35),(122,1,36),(123,1,37),(124,1,38),(125,1,39),(126,1,40),(127,1,41),(128,1,42),(129,1,43),(130,1,44),(131,1,45),(132,1,46),(133,11,37),(134,11,38),(135,11,39),(136,11,40),(137,11,41),(138,11,42),(139,11,43),(140,11,44),(141,11,45),(142,11,46),(143,12,1),(144,12,2),(145,12,3),(146,12,4),(147,12,5),(148,12,6),(149,12,7),(150,12,8),(151,12,9),(152,12,10),(153,12,11),(154,12,12),(155,12,13),(156,12,14),(157,12,15),(158,12,16),(159,12,17),(160,12,18),(161,12,19),(162,12,20),(163,12,21),(164,12,22),(165,12,23),(166,12,24),(167,12,25),(168,12,26),(169,12,27),(170,12,28),(171,12,29),(172,12,30),(173,12,31),(174,12,32),(175,12,33),(176,12,34),(177,12,35),(178,12,36),(179,12,37),(180,12,38),(181,12,39),(182,12,40),(183,12,41),(184,12,42),(185,12,43),(186,12,44),(187,12,45),(188,12,46),(189,13,37),(190,13,38),(191,13,39),(192,13,40),(193,13,41),(194,13,42),(195,13,43),(196,13,44),(197,13,45),(198,13,46),(199,14,37),(200,14,38),(201,14,39),(202,14,40),(203,14,41),(204,14,42),(205,14,43),(206,14,44),(207,14,45),(208,14,46),(209,15,37),(210,15,38),(211,15,39),(212,15,40),(213,15,41),(214,15,42),(215,15,43),(216,15,44),(217,15,45),(218,15,46),(239,18,37),(240,18,38),(241,18,39),(242,18,40),(243,18,41),(244,18,42),(245,18,43),(246,18,44),(247,18,45),(248,18,46),(279,24,37),(280,24,38),(281,24,39),(282,24,40),(283,24,41),(284,24,42),(285,24,43),(286,24,44),(287,24,45),(288,24,46),(289,25,37),(290,25,38),(291,25,39),(292,25,40),(293,25,41),(294,25,42),(295,25,43),(296,25,44),(297,25,45),(298,25,46),(299,26,37),(300,26,38),(301,26,39),(302,26,40),(303,26,41),(304,26,42),(305,26,43),(306,26,44),(307,26,45),(308,26,46),(309,27,37),(310,27,38),(311,27,39),(312,27,40),(313,27,41),(314,27,42),(315,27,43),(316,27,44),(317,27,45),(318,27,46),(319,28,37),(320,28,38),(321,28,39),(322,28,40),(323,28,41),(324,28,42),(325,28,43),(326,28,44),(327,28,45),(328,28,46),(339,30,37),(340,30,38),(341,30,39),(342,30,40),(343,30,41),(344,30,42),(345,30,43),(346,30,44),(347,30,45),(348,30,46);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2024-03-05 16:50:57.083144','1','juliana',1,'[{\"added\": {}}]',9,1),(2,'2024-03-05 16:55:14.029994','2','teste',1,'[{\"added\": {}}]',9,1),(3,'2024-03-05 16:56:28.166516','1','Clientes',1,'[{\"added\": {}}]',3,1),(4,'2024-03-05 16:56:35.301086','2','Administradores',1,'[{\"added\": {}}]',3,1),(5,'2024-03-05 16:57:45.370776','1','Juliana Gomes',2,'[{\"changed\": {\"fields\": [\"Nome completo\", \"Telefone\", \"Groups\", \"User permissions\"]}}]',9,1),(6,'2024-03-05 18:08:52.260454','3','julianapvh',2,'[{\"changed\": {\"fields\": [\"Groups\", \"User permissions\"]}}]',4,1),(7,'2024-03-05 19:31:25.260842','2','silva',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(8,'2024-03-05 19:51:05.887956','1','Mouse',1,'[{\"added\": {}}]',7,1),(9,'2024-03-05 20:23:20.224518','2','silva',2,'[{\"changed\": {\"fields\": [\"User permissions\"]}}]',4,1),(10,'2024-03-06 14:45:38.203575','2','Administradores',3,'',3,1),(11,'2024-03-06 14:45:38.209584','1','Clientes',3,'',3,1),(12,'2024-03-06 14:45:54.904728','1','Juliana Gomes',3,'',9,1),(13,'2024-03-06 14:45:54.910729','2','teste',3,'',9,1),(14,'2024-03-06 14:46:41.262710','1','Agendamento para silva em Mouse',1,'[{\"added\": {}}]',8,1),(15,'2024-03-06 14:59:50.956185','6','juliana',2,'[]',4,1),(16,'2024-03-06 15:18:44.230732','6','juliana',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(17,'2024-03-06 15:44:07.159222','6','juliana',2,'[{\"changed\": {\"fields\": [\"Groups\", \"User permissions\"]}}]',4,1),(18,'2024-03-06 15:44:15.170621','6','juliana',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(19,'2024-03-06 15:45:29.001858','6','juliana',3,'',4,1),(20,'2024-03-06 15:46:21.400575','7','juliana',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(21,'2024-03-06 15:47:50.203656','7','juliana',3,'',4,1),(22,'2024-03-06 15:47:58.479645','3','julianapvh',3,'',4,1),(23,'2024-03-06 15:47:58.483645','5','pumba',3,'',4,1),(24,'2024-03-06 15:47:58.488661','4','testea',3,'',4,1),(25,'2024-03-06 15:49:12.863810','8','juliana',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(29,'2024-03-07 17:45:29.902881','12','isadora2',2,'[{\"changed\": {\"fields\": [\"Username\", \"Groups\", \"User permissions\"]}}]',4,1),(30,'2024-03-07 17:47:13.580030','4','xbox',1,'[{\"added\": {}}]',7,12),(31,'2024-03-07 17:47:29.856640','4','xbox',2,'[]',7,12),(32,'2024-03-07 18:59:48.113171','19','Agendamento para aline em Teclado',1,'[{\"added\": {}}]',8,1),(33,'2024-03-08 12:40:34.823554','5','Caneta',1,'[{\"added\": {}}]',7,1),(34,'2024-03-08 12:41:07.798087','5','Caneta',2,'[]',7,1),(35,'2024-03-08 12:43:24.878593','20','Agendamento para juliana em Caneta',1,'[{\"added\": {}}]',8,1),(36,'2024-03-08 12:58:23.188496','1','Mouse',2,'[{\"changed\": {\"fields\": [\"Quantidade disponivel\"]}}]',7,1),(37,'2024-03-08 12:58:33.554245','3','Teclado',2,'[{\"changed\": {\"fields\": [\"Fabricante\", \"Quantidade disponivel\"]}}]',7,1),(38,'2024-03-08 12:58:36.257799','5','Caneta',2,'[]',7,1),(39,'2024-03-08 12:58:38.463891','3','Teclado',2,'[]',7,1),(40,'2024-03-08 12:58:42.097859','4','xbox',2,'[{\"changed\": {\"fields\": [\"Quantidade disponivel\"]}}]',7,1),(41,'2024-03-08 12:58:44.588845','1','Mouse',2,'[]',7,1),(42,'2024-03-08 13:10:09.447120','1','Mouse',2,'[{\"changed\": {\"fields\": [\"Quantidade disponivel\"]}}]',7,1),(43,'2024-03-08 13:14:30.744583','1','Mouse',2,'[]',7,1),(44,'2024-03-11 14:28:50.225045','2','Monitor',2,'[{\"changed\": {\"fields\": [\"Fabricante\", \"Quantidade disponivel\"]}}]',7,1),(45,'2024-03-12 12:40:30.920484','10','Admin_teste',3,'',4,1),(46,'2024-03-12 12:40:30.924482','9','gomes',3,'',4,1),(47,'2024-03-12 12:40:30.931995','2','silva',3,'',4,1),(48,'2024-03-12 12:40:30.936499','17','testando',3,'',4,1),(49,'2024-03-12 12:40:30.942016','16','teste',3,'',4,1),(50,'2024-03-12 12:45:20.578904','1','admin',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(51,'2024-03-12 12:46:12.375187','19','juliana2',1,'[{\"added\": {}}]',4,1),(52,'2024-03-12 12:46:33.015932','19','juliana2',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(53,'2024-03-12 12:46:55.977542','20','juliana3',1,'[{\"added\": {}}]',4,1),(54,'2024-03-12 12:47:02.487207','20','juliana3',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(55,'2024-03-12 18:59:10.173824','51','Equipamento28',2,'[{\"changed\": {\"fields\": [\"Quantidade disponivel\", \"Status\"]}}]',7,1),(56,'2024-03-12 18:59:37.337791','51','Equipamento28',2,'[{\"changed\": {\"fields\": [\"Quantidade disponivel\"]}}]',7,1),(57,'2024-03-13 15:53:16.227903','20','juliana3',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(58,'2024-03-14 17:38:06.789437','28','Equipamento28',2,'[{\"changed\": {\"fields\": [\"Quantidade disponivel\", \"Status\"]}}]',7,1),(59,'2024-03-14 17:38:14.216320','27','Equipamento27',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',7,1),(60,'2024-03-14 17:38:20.986893','27','Equipamento27',2,'[{\"changed\": {\"fields\": [\"Status\"]}}]',7,1),(61,'2024-03-14 17:38:37.878894','27','Equipamento27',2,'[]',7,1),(62,'2024-03-14 17:38:45.766572','27','Equipamento27',2,'[]',7,1),(63,'2024-03-15 16:42:50.449401','22','batata',3,'',4,1),(64,'2024-03-15 16:42:50.455584','8','juliana',3,'',4,1),(65,'2024-03-15 16:42:50.459235','19','juliana2',3,'',4,1),(66,'2024-03-15 16:42:50.464226','21','teste',3,'',4,1),(67,'2024-03-15 16:42:50.469062','23','testes',3,'',4,1),(68,'2024-03-15 16:43:28.894699','20','juliana3',3,'',4,1),(69,'2024-03-21 12:58:29.261514','14','Mariana',2,'[{\"changed\": {\"fields\": [\"Groups\"]}}]',4,1),(70,'2024-03-21 12:58:36.447714','14','Mariana',2,'[{\"changed\": {\"fields\": [\"Staff status\", \"Superuser status\"]}}]',4,1),(71,'2024-03-21 13:53:53.221431','27','Lmar',2,'[{\"changed\": {\"fields\": [\"Staff status\", \"Superuser status\", \"Groups\"]}}]',4,1),(72,'2024-04-02 16:40:33.798418','1','Juliana Gomes da Silva',3,'',9,1),(73,'2024-04-02 16:58:46.641150','3','Juliana Tetes',3,'',9,1),(74,'2024-04-02 16:58:54.377027','29','juju',3,'',4,1),(75,'2024-04-03 14:07:54.637462','4','Juliana Teste',3,'',9,1),(76,'2024-04-03 14:07:54.646534','5','Juju Teste',3,'',9,1),(77,'2024-04-09 15:37:58.196914','24','juliana3',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(78,'2024-04-09 16:09:22.804337','24','juliana3',2,'[{\"changed\": {\"fields\": [\"Email address\"]}}]',4,1),(79,'2024-04-09 16:15:59.186221','7','testando si',3,'',9,1),(80,'2024-04-09 16:16:24.383672','8','testando si',1,'[{\"added\": {}}]',9,1),(81,'2024-04-09 16:17:38.604105','8','testando si',3,'',9,1),(82,'2024-04-09 16:22:06.104893','6','Teste Teste',3,'',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(8,'agendamentos','agendamento'),(7,'agendamentos','equipamento'),(10,'agendamentos','event'),(11,'agendamentos','historicoagendamento'),(9,'agendamentos','user'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-03-05 16:49:46.860300'),(2,'auth','0001_initial','2024-03-05 16:49:47.484494'),(3,'admin','0001_initial','2024-03-05 16:49:47.656573'),(4,'admin','0002_logentry_remove_auto_add','2024-03-05 16:49:47.664631'),(5,'admin','0003_logentry_add_action_flag_choices','2024-03-05 16:49:47.671866'),(6,'contenttypes','0002_remove_content_type_name','2024-03-05 16:49:47.890632'),(7,'auth','0002_alter_permission_name_max_length','2024-03-05 16:49:47.959424'),(8,'auth','0003_alter_user_email_max_length','2024-03-05 16:49:47.982957'),(9,'auth','0004_alter_user_username_opts','2024-03-05 16:49:47.991142'),(10,'auth','0005_alter_user_last_login_null','2024-03-05 16:49:48.053442'),(11,'auth','0006_require_contenttypes_0002','2024-03-05 16:49:48.056953'),(12,'auth','0007_alter_validators_add_error_messages','2024-03-05 16:49:48.064748'),(13,'auth','0008_alter_user_username_max_length','2024-03-05 16:49:48.149658'),(14,'auth','0009_alter_user_last_name_max_length','2024-03-05 16:49:48.222251'),(15,'auth','0010_alter_group_name_max_length','2024-03-05 16:49:48.243962'),(16,'auth','0011_update_proxy_permissions','2024-03-05 16:49:48.251740'),(17,'auth','0012_alter_user_first_name_max_length','2024-03-05 16:49:48.322472'),(19,'sessions','0001_initial','2024-03-05 16:49:48.978658'),(25,'agendamentos','0007_agendamento_prazo_devolucao_and_more','2024-03-13 15:43:35.177993'),(26,'agendamentos','0008_user_cpf','2024-03-13 15:52:07.910793'),(27,'agendamentos','0001_initial','2024-03-13 18:16:24.091982'),(28,'agendamentos','0002_agendamento_data_entrega_prevista','2024-03-15 17:06:05.607964'),(29,'agendamentos','0003_agendamento_nova_data','2024-03-19 16:21:12.528963'),(30,'agendamentos','0004_agendamento_data_original_agendamento_hora_original_and_more','2024-03-19 16:37:43.716895'),(31,'agendamentos','0005_alter_equipamento_data_aquisicao','2024-03-19 16:57:43.961327'),(32,'agendamentos','0006_agendamento_data_emprestimo','2024-03-19 17:47:01.968590'),(33,'agendamentos','0007_agendamento_prazo_restante_agendamento_situacao','2024-03-19 18:21:18.754598'),(34,'agendamentos','0008_agendamento_emprestado','2024-03-20 13:49:27.756919'),(35,'agendamentos','0009_agendamento_data_devolucao','2024-03-20 16:25:33.662553'),(36,'agendamentos','0010_agendamento_devolvido','2024-03-20 16:41:08.962504'),(37,'agendamentos','0011_event','2024-03-21 15:03:37.800058'),(38,'agendamentos','0011_agendamento_quantidade_dias','2024-03-22 13:15:36.795403'),(39,'agendamentos','0012_historicoagendamento','2024-03-25 14:11:13.421641');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('0s8brg3o4kasuxv7stukgoynm5z7uzuu','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rmz4h:uTq_hqKImYrecdtc17BzfSqqOnW-LUcj9onOt3nWwZI','2024-04-03 16:45:59.119338'),('2aq4gi40amfej5yld1qbllwaqgs2iubh','.eJxVjL0OwjAQg98lM4pKfltGdp4hutxdSAElUtNOiHcnlTrAYsn2Z79FgG3NYWu8hJnERSgjTr9hBHxy2Rt6QLlXibWsyxzljsijbfJWiV_Xg_07yNByXxtwqLqYYWRrpgQpRm8UdDsxnTk6B4CYBs3QAauM1cp5cn50EUmLzxceYTiU:1rmEYF:bg_kuF1JzvxygVQ256ynzP93L6FmvqCdAnrhAKnYkgY','2024-04-01 15:05:23.486104'),('2dhs731fw6maj8lkwdok5eh5ecgc3w9x','e30:1rhYf2:XkUMxHmZSKoWbLHrc_Lpaam9G_5be41R5BgPUcVdqFk','2024-03-19 17:33:04.554511'),('32wbmi7aovpzk184d4qnebfkksaup4w1','.eJxVjL0OwjAQg98lM4pKfltGdp4hutxdSAElUtNOiHcnlTrAYsn2Z79FgG3NYWu8hJnERSgjTr9hBHxy2Rt6QLlXibWsyxzljsijbfJWiV_Xg_07yNByXxtwqLqYYWRrpgQpRm8UdDsxnTk6B4CYBs3QAauM1cp5cn50EUmLzxceYTiU:1rnHzP:ulmn650ChOgpo8P16N7ZDbuS0Vs7_BIL9ok0tNfhGxU','2024-04-04 12:57:47.254391'),('40m7f1u1cco3p8hv20jpbz21efuu57rv','e30:1rhYgh:6DvmRbwyfRTfhomO_oXYyT0ZlNHEN22uqBUQ2NmPn6I','2024-03-19 17:34:47.008502'),('52yfa9f4idljculwhqzxgogp4zjmq4mx','.eJxVjEEOwiAQRe_C2hCgZUpcuvcMZGBmpGogKe3KeHdt0oVu_3vvv1TEbS1x67zEmdRZ2VGdfseE-cF1J3THems6t7ouc9K7og_a9bURPy-H-3dQsJdvLQZYcghgEklI4gwicwiSiRzDAD5NLpsJvR88GBAhcYKAbkQ7oFXvDzxjOR4:1rnfuq:dQGlkG926AG_e-NXVW1I4f4M4_OYOKln5kpd7QvBzOE','2024-04-05 14:30:40.368772'),('54bza10cjbjdzshi9mu1twvkrv78bvf4','.eJxVjDsOwjAQBe_iGln-S6ak5wzWrteLA8iW4qSKuDuJlALamXlvEwnWpaZ1lDlNJK7CicsvQ8iv0g5BT2iPLnNvyzyhPBJ52iHvncr7drZ_BxVG3ddFQ0TLbE1hr4IL3nFBZzKzZmtz0CFqRPDaRNLsg4oqW9oJAWBw4vMF-2A4rg:1rhaP4:0EBbcNttRngOB9uETGx_iSPiQ9VWiY3aiC3EbGMUl9s','2024-03-19 19:24:42.132872'),('6dd3j2a9pw21zh4uz8ckgahndlubvtyk','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1ruDXa:nyEiTwuoxszusgAyhGQovJIDp09wkqjeb8ri-o4DwJ0','2024-04-23 15:37:42.822100'),('7kkiydz4y6z00otoctljnhirxn06zqd6','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rmceM:ejDKYKU-12JNu6bG3uNDTekuRbEtjW0DHHzt2yubFOU','2024-04-02 16:49:18.293590'),('86rblr65nruq9tqaswyu1v79hzv9n10f','.eJxVjDsOwjAQBe_iGln-20tJzxms3bVDAiiW4qRC3B0ipYD2zcx7iYzbOuat1yVPRZyFEaffjZAfdd5BueN8a5LbvC4TyV2RB-3y2kp9Xg7372DEPn7rIREUXxJRsNoyBFWrchiCA8MAGKM3JUJIQwSrICKxZYOsjSMNzov3B95BN10:1rhace:jdnQvoYfnYR_0NzIv5Sr5IoF_Jkqrc4bqXvNSGB3hHQ','2024-03-19 19:38:44.083877'),('9l5xgggwsu98tzbz6pghy6zv71duoijg','e30:1rhZEz:KqRnTTvJJ4nCdCF2LUkYfjb5RO2QwBrbleTqu-x8KrA','2024-03-19 18:10:13.127024'),('a3nxny3xiuvuog7y2l0km70jeqw5leix','.eJxVjDsOwjAQBe_iGln-20tJzxms3bVDAiiW4qRC3B0ipYD2zcx7iYzbOuat1yVPRZyFEaffjZAfdd5BueN8a5LbvC4TyV2RB-3y2kp9Xg7372DEPn7rIREUXxJRsNoyBFWrchiCA8MAGKM3JUJIQwSrICKxZYOsjSMNzov3B95BN10:1rhYrZ:MK32gMOc-e0BvE1i3Ia55lknCyhg0FEpr1Dj8ZnYxkA','2024-03-19 17:46:01.844028'),('b6st4inpxiwvxdae4wd8kcph6htv9sd0','.eJxVjDsOwjAQBe_iGln-20tJzxms3bVDAiiW4qRC3B0ipYD2zcx7iYzbOuat1yVPRZyFEaffjZAfdd5BueN8a5LbvC4TyV2RB-3y2kp9Xg7372DEPn7rIREUXxJRsNoyBFWrchiCA8MAGKM3JUJIQwSrICKxZYOsjSMNzov3B95BN10:1rhbK7:K8SO2bz-Q_5pozcq89UhVPDDl12fh4W9Hgrrk1ccjOs','2024-03-19 20:23:39.671204'),('bo2sje1emk3ghg6galmfz9klsy1x8l0l','.eJxVjDsOwjAQBe_iGln-20tJzxms3bVDAiiW4qRC3B0ipYD2zcx7iYzbOuat1yVPRZyFEaffjZAfdd5BueN8a5LbvC4TyV2RB-3y2kp9Xg7372DEPn7rIREUXxJRsNoyBFWrchiCA8MAGKM3JUJIQwSrICKxZYOsjSMNzov3B95BN10:1rhbYB:ChLQc7mIFaySEHk4eZZMpjbusXy6i4TtRKF_VLdvDcs','2024-03-19 20:38:11.873793'),('dgoih6pmfhck4z2krht5zrg2ga6juzwx','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rmEPZ:_ZnODS4kXgu2Mj7YKDJqlk6bLmdG02Ode1qi43MRnu0','2024-04-01 14:56:25.034500'),('dol99752turxl92nuxi1d7cb892xeh6o','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rk4qG:aAQng0Z8IlDwJoQTSzxCC7J-qqErQxYRnNKE8no6WcU','2024-03-26 16:19:04.195997'),('ffqg7lsjie1vkwdka9uk710vqsie4tzq','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rmxzH:bjxUlLcZu5Dx5029brXwJXEuwMQD-D1319ik6mTXc9Q','2024-04-03 15:36:19.336500'),('handt63o86li4gkwg3e5xs44j233ickv','.eJxVjDsOwjAQBe_iGln-20tJzxms3bVDAiiW4qRC3B0ipYD2zcx7iYzbOuat1yVPRZyFEaffjZAfdd5BueN8a5LbvC4TyV2RB-3y2kp9Xg7372DEPn7rIREUXxJRsNoyBFWrchiCA8MAGKM3JUJIQwSrICKxZYOsjSMNzov3B95BN10:1rhZqD:vj83PdDFj2CZ0jIeCxk0zAHmJ_LvVV30eHp6hHtV9tA','2024-03-19 18:48:41.573498'),('iavyoh2w6vul1wa00x1qiod8w6wfy06o','.eJxVjL0OwjAQg98lM4pKfltGdp4hutxdSAElUtNOiHcnlTrAYsn2Z79FgG3NYWu8hJnERSgjTr9hBHxy2Rt6QLlXibWsyxzljsijbfJWiV_Xg_07yNByXxtwqLqYYWRrpgQpRm8UdDsxnTk6B4CYBs3QAauM1cp5cn50EUmLzxceYTiU:1rrftm:C1kEuJPa_v00i24dWBk_MvkEBVzm0gqARezFvvWdfaI','2024-04-16 15:18:06.004358'),('j3zqdibc7tv9b4rqn2iy0d5d698rnaob','e30:1rhYbH:Ts-EHsTMXUnDjXkY8Wq8iFnPO4wJo8Es3hPlUJ8iCyo','2024-03-19 17:29:11.701398'),('j8h75xrj0ni9ubj41iqds02ao140z25a','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rrgmz:8JO97cPJm1iowqAJpuatpTn1WoVmgJYtD6OJVl-FaUs','2024-04-16 16:15:09.471368'),('j92bt2tpfa1s3nbi0c95jfb85bknnv1m','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rrgyg:6xvlsl_FunZ4Sq5jAdtEunO6xsQFV2kNPfG6MYPcVCk','2024-04-16 16:27:14.595787'),('jk3iwvhbginsety02oumrcvl23b0dw07','.eJxVjDsOwjAQBe_iGln-20tJzxms3bVDAiiW4qRC3B0ipYD2zcx7iYzbOuat1yVPRZyFEaffjZAfdd5BueN8a5LbvC4TyV2RB-3y2kp9Xg7372DEPn7rIREUXxJRsNoyBFWrchiCA8MAGKM3JUJIQwSrICKxZYOsjSMNzov3B95BN10:1rha6T:Ew_4QTRow_rTmmTkF11rozm2KJ2hwi3u-CxG-AKCT-E','2024-03-19 19:05:29.709863'),('kdyjuqh44gor0dkitxzkna7ghsbjke06','.eJxVjDsOwjAQBe_iGll24sS7lPQ5g7XrDw4gW4qTCnF3EikFtG9m3ls42tbsthYXNwdxFSAuvxuTf8ZygPCgcq_S17IuM8tDkSdtcqohvm6n-3eQqeW9ZjY2aZ0Sj2D6iKh6GLreaASTEmkOlpjHAANGUhwAwaOiTrP1u0ji8wXq7zgV:1rhulZ:9V7a5U_7-f6JTVrn0wI-ofvnM0nZ2NKnKtA_0-q_2Bw','2024-03-20 17:09:17.436068'),('l1pyf76o1lexdum5qses8764gh2s5gjh','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rk7J0:u1gv9uwy1t28xuXHB6q1etWk-qtPBWAKkvdN48014QI','2024-03-26 18:56:54.722330'),('nk4nlrc9odqg6eqz1ualps2u6aiedhw2','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rnewq:ifJhEcBN4lFznYosA4qfgrCymhTWEG1FX3wdC2_Ud_w','2024-04-05 13:28:40.080111'),('oadus5c6egh6tcvtaubrm850b35nezpx','e30:1rhYlv:AtW37OCaW5JF_UloP-3T79NTzS3HJLZljtwa2vV4sVI','2024-03-19 17:40:11.744843'),('pqanw88s3hb585x1manvxswq5a3jyaok','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rnIVV:VYT-aSo-6b2BVZDp5pI8RTgzPPQJoo5CjMfmR8a36BU','2024-04-04 13:30:57.591602'),('qqpwjqrq6alw5abz8lknztb9ohk7vmrs','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rmxOw:lZllBpO4C9T3zFhTzmQdWjPWaFJX21QlH-8CpMhbPSA','2024-04-03 14:58:46.347279'),('rtbqng6v1tt6lycwnfbh2ovjp3d0dhlu','.eJxVjDsOwjAQBe_iGll24sS7lPQ5g7XrDw4gW4qTCnF3EikFtG9m3ls42tbsthYXNwdxFSAuvxuTf8ZygPCgcq_S17IuM8tDkSdtcqohvm6n-3eQqeW9ZjY2aZ0Sj2D6iKh6GLreaASTEmkOlpjHAANGUhwAwaOiTrP1u0ji8wXq7zgV:1ribRP:PCXJ5_TgKSqXsCjl3SkO5L-kgf88y6GIwItRSqFMbvA','2024-03-22 14:43:19.599565'),('s3z9lxlrfbviiw6uwe2oat8zpnnvmi10','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rkp1h:V408TyGBmaOEU3UPoGaB-CA-Gt5rUR6gGypa-lNqpxM','2024-03-28 17:37:57.934735'),('seljj1flf3cprnr729zn7xo51etl2ona','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rkTGU:9vXLWSprb4WWLU9paIGH4uZmbUJNtmLvE8-OK3pOV5o','2024-03-27 18:23:46.701767'),('sygvql9jilkvsj9br3gp1c07gq0r64co','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rlAHR:ytbUKiZwJbm77TU4_KSqqTdPPPhm8dM1FILXooY-wpE','2024-03-29 16:19:37.036666'),('t1jrkziyjngcles4zkbo5baxl9p5rnfh','.eJxVjDsOwjAQBe_iGll24sS7lPQ5g7XrDw4gW4qTCnF3EikFtG9m3ls42tbsthYXNwdxFSAuvxuTf8ZygPCgcq_S17IuM8tDkSdtcqohvm6n-3eQqeW9ZjY2aZ0Sj2D6iKh6GLreaASTEmkOlpjHAANGUhwAwaOiTrP1u0ji8wXq7zgV:1rhumi:jhIJdQrWzyoG1oFWlFKtimLQcWcd0FFV5KQa8sThfxc','2024-03-20 17:10:28.876160'),('t6wy269a4dg07yi3qpjqdaz0tmlayp43','.eJxVjDsOwjAQBe_iGll2FnsTSnrOEO0PEkC2lE-FuDtESgHtm5n3cj2ty9Cvs039qO7kwB1-NyZ5WNmA3qncqpdalmlkvyl-p7O_VLXneXf_Dgaah2-NwgAQFbt4bDFQDoGzKQoYGSdNzO01QiaE3CUJptIoMWCK0LQo7v0B4uA39w:1rhZgt:tyacDK1rEXsH4rAHd7QF59B4i-9BksA4QdKJg-tkfAk','2024-03-19 18:39:03.122234'),('tds5icw1bd10u8qvaex29jqaxe67s4ts','.eJxVjMsOwiAQRf-FtSHQUh4u3fsNZGYYpGogKe3K-O_apAvd3nPOfYkI21ri1nmJcxJnMQzi9Dsi0IPrTtId6q1JanVdZpS7Ig_a5bUlfl4O9--gQC_fOkMwE5EmQkCtNCkiQ04nbRR6tAZMyJlGZs8OTRqzY3TWTQyeggXx_gA85zl9:1rkRHC:n5ijAHBSFo6lqWeBV8J71wqFvEn78Dp9cOypk7VzaJ0','2024-03-27 16:16:22.959837'),('uragm1zpz3rd0u6o3xg8dco7xh3sbid7','.eJxVjMsOwiAQRf-FtSFAGQZcuvcbyPCSqoGktCvjv2uTLnR7zzn3xTxta_XbyIufEzszZdjpdwwUH7ntJN2p3TqPva3LHPiu8IMOfu0pPy-H-3dQadRvDcoiYcpAKII0NgkRp8lhMMUVgChRg8g6KAKNxWTCSRQhjbJWRgmOvT_ySDcd:1ronPM:VJOP6RiybVxOBTeXF51ydtBWtGwlg5UJiTYEcmvYrrY','2024-04-08 16:42:48.756689'),('vli4h2xsgat8s5wg39u5mgmeg416nt35','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rmysi:GuLTrw3GjR8X1-yaCYkdTb_EW8bWYqMKRMWhkVI9QuU','2024-04-03 16:33:36.863013'),('vzstd3q9sug71d6yufiirpdyc51mbjs8','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rkTFT:NyMDYLiDIjRI63XUlP1u6uQyxS7iDgX6Hsn36M399qk','2024-03-27 18:22:43.609137'),('xkw5er36rarr93998xbarikc7z5r0q89','.eJxVjMsOwiAQRf-FtSEwyEOX7vsNZGAGqRqalHZl_HfbpAvd3nPOfYuI61Lj2nmOI4mrgCBOv2PC_OS2E3pgu08yT22ZxyR3RR60y2Eift0O9--gYq9bnRMnoGJU8uCMK6qAD3gpAchbfU6FtLFBOTCAdiOcLTOY7L1CbS2JzxcVeDgE:1rnfvU:cuxEOuVoWKXc_3SbgTMOZx7hB8r73PxBN01Q7PiWrfU','2024-04-05 14:31:20.996756'),('yfooic14jwmlo22g9hzvffgvn3iad5k4','.eJxVjMEOwiAQRP-FsyFQ7AIevfcbyLILUjU0Ke3J-O9K0oMe5jLvzbxEwH0rYW9pDTOLi9Di9NtFpEeqHfAd622RtNRtnaPsijxok9PC6Xk93L-Dgq18184ggM_GZ0wANmkHHDXFnMl7IEtZj-wGpbDHGH9WI9tIlu3glHfi_QHt3ze2:1rmwgX:O5TBt3q9BqOg1xTQAkkvZ_uXbUwq-nILqpsGpvBwkmI','2024-04-03 14:12:53.565561'),('yku2jndoyan2n8y95cpljenipgz7wpcz','.eJxVjDsOwyAQBe9CHSG-BlKm9xkQ7C7BSYQlY1dR7h5bcpG0b2bem8W0rTVunZY4IbsyJdjld8wJntQOgo_U7jOHua3LlPmh8JN2Ps5Ir9vp_h3U1Ote-5R1wQKWvMQgExmQOUinnC46kAvgEQH0oIQJUBwVjzZoYb3a0WDY5wspDzha:1rl8X5:qH7Bymst1FgzFPu2kuuqDdHdt4oRcVCJzvfKGYozCyM','2024-03-29 14:27:39.038957'),('z2plnkdwm3rsrfbfnhsdrrtq26me0bb1','.eJxVjDsOwjAQBe_iGll2FnsTSnrOEO0PEkC2lE-FuDtESgHtm5n3cj2ty9Cvs039qO7kwB1-NyZ5WNmA3qncqpdalmlkvyl-p7O_VLXneXf_Dgaah2-NwgAQFbt4bDFQDoGzKQoYGSdNzO01QiaE3CUJptIoMWCK0LQo7v0B4uA39w:1rhaGC:kVCdLr7LlEhfGA8dl9x-bSThH1TwjntHpwc19-7X7Bc','2024-03-19 19:15:32.432506');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'bd_agendamentos'
--

--
-- Dumping routines for database 'bd_agendamentos'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-10 13:43:58
