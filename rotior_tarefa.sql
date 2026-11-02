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
-- Table structure for table `tarefa`
--

DROP TABLE IF EXISTS `tarefa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarefa` (
  `id_tarefa` int NOT NULL AUTO_INCREMENT,
  `id_rotina` int NOT NULL,
  `id_categoria` int NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `horario_previsto` time DEFAULT NULL,
  `duracao_min` int DEFAULT NULL,
  `prioridade` enum('BAIXA','MEDIA','ALTA') NOT NULL DEFAULT 'MEDIA',
  PRIMARY KEY (`id_tarefa`),
  KEY `fk_tarefa_rotina` (`id_rotina`),
  KEY `fk_tarefa_categoria` (`id_categoria`),
  CONSTRAINT `fk_tarefa_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_tarefa_rotina` FOREIGN KEY (`id_rotina`) REFERENCES `rotina` (`id_rotina`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarefa`
--

LOCK TABLES `tarefa` WRITE;
/*!40000 ALTER TABLE `tarefa` DISABLE KEYS */;
INSERT INTO `tarefa` VALUES (1,1,1,'Estudar SQL','Praticar consultas e modelagem','07:00:00',60,'ALTA'),(2,1,2,'Alongamento','Alongamento matinal','06:30:00',15,'MEDIA'),(3,1,4,'Planejar o dia','Listar prioridades do dia','08:00:00',10,'MEDIA'),(4,2,5,'Pagar aluguel','Pagar o aluguel via PIX','09:00:00',10,'ALTA'),(5,2,5,'Conferir extrato','Conferir saldo e lançamentos','20:00:00',15,'MEDIA'),(6,3,2,'Treino de perna','Treino de força na academia','18:00:00',60,'ALTA'),(7,3,2,'Corrida leve','Corrida de 5 km','06:00:00',40,'MEDIA'),(8,4,1,'Estudar Cálculo','Lista de exercícios','19:00:00',90,'ALTA'),(9,4,1,'Entregar trabalho de Banco de Dados','Subir o projeto no classroom','22:00:00',120,'ALTA'),(10,5,3,'Limpar a casa','Limpeza geral','10:00:00',120,'BAIXA'),(11,6,4,'Reunião de equipe','Alinhamento semanal','09:30:00',45,'ALTA'),(12,7,5,'Revisar orçamento do mês','Comparar gastos com o planejado','21:00:00',30,'MEDIA');
/*!40000 ALTER TABLE `tarefa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-28 11:44:28
