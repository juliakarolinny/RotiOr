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
-- Table structure for table `lancamento`
--

DROP TABLE IF EXISTS `lancamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lancamento` (
  `id_lancamento` int NOT NULL AUTO_INCREMENT,
  `id_conta` int NOT NULL,
  `id_categoria` int NOT NULL,
  `id_tarefa` int DEFAULT NULL,
  `descricao` varchar(120) NOT NULL,
  `valor` decimal(12,2) NOT NULL,
  `tipo_lancamento` enum('RECEITA','DESPESA') NOT NULL,
  `data_vencimento` date NOT NULL,
  `data_pagamento` date DEFAULT NULL,
  `status_lancamento` enum('PENDENTE','PAGO','ATRASADO') NOT NULL DEFAULT 'PENDENTE',
  PRIMARY KEY (`id_lancamento`),
  KEY `fk_lancamento_conta` (`id_conta`),
  KEY `fk_lancamento_categoria` (`id_categoria`),
  KEY `fk_lancamento_tarefa` (`id_tarefa`),
  KEY `idx_lancamento_vencimento` (`data_vencimento`),
  CONSTRAINT `fk_lancamento_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_lancamento_conta` FOREIGN KEY (`id_conta`) REFERENCES `conta` (`id_conta`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lancamento_tarefa` FOREIGN KEY (`id_tarefa`) REFERENCES `tarefa` (`id_tarefa`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lancamento`
--

LOCK TABLES `lancamento` WRITE;
/*!40000 ALTER TABLE `lancamento` DISABLE KEYS */;
INSERT INTO `lancamento` VALUES (1,1,6,NULL,'Salário de outubro',3200.00,'RECEITA','2026-10-05','2026-10-05','PAGO'),(2,1,8,4,'Aluguel de outubro',1100.00,'DESPESA','2026-10-09','2026-10-09','PAGO'),(3,1,9,NULL,'Supermercado semanal',285.40,'DESPESA','2026-10-03','2026-10-03','PAGO'),(4,1,9,NULL,'Almoço delivery',42.90,'DESPESA','2026-10-07','2026-10-07','PAGO'),(5,1,10,NULL,'Recarga do bilhete único',150.00,'DESPESA','2026-10-02','2026-10-02','PAGO'),(6,1,11,NULL,'Assinatura de streaming',39.90,'DESPESA','2026-10-25',NULL,'PENDENTE'),(7,1,12,1,'Curso online de SQL',197.00,'DESPESA','2026-10-08','2026-10-08','PAGO'),(8,3,6,NULL,'Salário de outubro',4500.00,'RECEITA','2026-10-05','2026-10-05','PAGO'),(9,3,9,NULL,'Feira do mês',180.00,'DESPESA','2026-10-10','2026-10-10','PAGO'),(10,3,13,NULL,'Mensalidade da academia',119.90,'DESPESA','2026-10-05','2026-10-05','PAGO'),(11,3,10,NULL,'Combustível',220.00,'DESPESA','2026-10-09','2026-10-09','PAGO'),(12,4,7,NULL,'Projeto de identidade visual',800.00,'RECEITA','2026-10-06','2026-10-08','PAGO'),(13,4,12,9,'Mensalidade da faculdade',650.00,'DESPESA','2026-10-10','2026-10-10','PAGO'),(14,4,9,NULL,'Lanche na faculdade',25.50,'DESPESA','2026-10-06','2026-10-06','PAGO'),(15,5,6,NULL,'Salário de outubro',6000.00,'RECEITA','2026-10-05','2026-10-05','PAGO'),(16,5,8,NULL,'Condomínio',480.00,'DESPESA','2026-10-10',NULL,'ATRASADO'),(17,5,9,NULL,'Compras no mercado',320.75,'DESPESA','2026-10-04','2026-10-04','PAGO'),(18,5,10,NULL,'Corrida de aplicativo',38.50,'DESPESA','2026-10-08','2026-10-08','PAGO'),(19,6,14,NULL,'Rendimento mensal',1200.00,'RECEITA','2026-10-15','2026-10-15','PAGO'),(20,6,11,NULL,'Viagem de fim de semana',900.00,'DESPESA','2026-10-17','2026-10-17','PAGO'),(21,2,14,NULL,'Rendimento da poupança',14.20,'RECEITA','2026-10-01','2026-10-01','PAGO'),(22,7,13,NULL,'Consulta odontológica',250.00,'DESPESA','2026-09-28','2026-09-28','PAGO'),(23,1,8,4,'Aluguel de setembro',1100.00,'DESPESA','2026-09-09','2026-09-09','PAGO');
/*!40000 ALTER TABLE `lancamento` ENABLE KEYS */;
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
