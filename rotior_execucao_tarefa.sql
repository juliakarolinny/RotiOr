-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: rotior
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `execucao_tarefa`
--

DROP TABLE IF EXISTS `execucao_tarefa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `execucao_tarefa` (
  `id_execucao` int NOT NULL AUTO_INCREMENT,
  `id_tarefa` int NOT NULL,
  `data_execucao` date NOT NULL,
  `status_execucao` enum('PENDENTE','CONCLUIDA','ADIADA','CANCELADA') NOT NULL DEFAULT 'PENDENTE',
  `hora_conclusao` time DEFAULT NULL,
  `observacao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_execucao`),
  KEY `fk_execucao_tarefa` (`id_tarefa`),
  KEY `idx_execucao_data` (`data_execucao`),
  CONSTRAINT `fk_execucao_tarefa` FOREIGN KEY (`id_tarefa`) REFERENCES `tarefa` (`id_tarefa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `execucao_tarefa`
--

LOCK TABLES `execucao_tarefa` WRITE;
/*!40000 ALTER TABLE `execucao_tarefa` DISABLE KEYS */;
INSERT INTO `execucao_tarefa` VALUES (1,1,'2026-10-05','CONCLUIDA','07:55:00','Estudou joins'),(2,1,'2026-10-07','CONCLUIDA','08:02:00',NULL),(3,1,'2026-10-09','ADIADA',NULL,'Reunião inesperada'),(4,2,'2026-10-05','CONCLUIDA','06:45:00',NULL),(5,2,'2026-10-06','CONCLUIDA','06:44:00',NULL),(6,4,'2026-10-09','CONCLUIDA','09:10:00','Aluguel pago via PIX'),(7,5,'2026-10-11','PENDENTE',NULL,NULL),(8,6,'2026-10-05','CONCLUIDA','19:05:00',NULL),(9,6,'2026-10-08','CANCELADA',NULL,'Dor no joelho'),(10,7,'2026-10-06','CONCLUIDA','06:50:00',NULL),(11,8,'2026-10-06','CONCLUIDA','20:30:00',NULL),(12,9,'2026-10-09','CONCLUIDA','23:40:00','Entregue no prazo'),(13,10,'2026-10-10','CONCLUIDA','12:00:00',NULL),(14,11,'2026-10-07','CONCLUIDA','10:15:00',NULL),(15,12,'2026-10-11','ADIADA',NULL,'Fica para a próxima semana');
/*!40000 ALTER TABLE `execucao_tarefa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-28 11:44:25
