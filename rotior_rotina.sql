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
-- Table structure for table `rotina`
--

DROP TABLE IF EXISTS `rotina`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rotina` (
  `id_rotina` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `nome_rotina` varchar(80) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `data_inicio` date NOT NULL,
  `ativa` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_rotina`),
  KEY `fk_rotina_usuario` (`id_usuario`),
  CONSTRAINT `fk_rotina_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rotina`
--

LOCK TABLES `rotina` WRITE;
/*!40000 ALTER TABLE `rotina` DISABLE KEYS */;
INSERT INTO `rotina` VALUES (1,1,'Manhã Produtiva','Estudo e planejamento antes do trabalho','2026-01-12',1),(2,1,'Finanças da Semana','Contas a pagar e conferência de extratos','2026-01-12',1),(3,2,'Rotina de Treino','Treinos de força e corrida durante a semana','2026-02-01',1),(4,3,'Semestre Letivo','Estudos e entregas da faculdade','2026-02-05',1),(5,4,'Casa em Ordem','Tarefas domésticas semanais','2026-03-01',1),(6,5,'Trabalho Remoto','Compromissos do home office','2026-03-02',1),(7,2,'Fechamento do Mês','Revisão do orçamento mensal','2026-02-01',1);
/*!40000 ALTER TABLE `rotina` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-28 11:44:24
