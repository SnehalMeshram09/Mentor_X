-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: mentorx
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `extra`
--

DROP TABLE IF EXISTS `extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extra` (
  `hackathon_id` varchar(10) NOT NULL,
  `hackathon_name` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `deadline` datetime DEFAULT NULL,
  `mode` varchar(100) DEFAULT NULL,
  `participants` int DEFAULT NULL,
  `prizes` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`hackathon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extra`
--

LOCK TABLES `extra` WRITE;
/*!40000 ALTER TABLE `extra` DISABLE KEYS */;
INSERT INTO `extra` VALUES ('H104','CodeFest 2025','Mumbai','2025-01-30 23:59:59','Online',200,'₹1,00,000 and Internship Opportunities'),('H105','AI Challenge','Delhi','2025-02-15 23:59:59','Hybrid',150,'₹50,000 and Certificates'),('H106','Web Innovators Hack','Chennai','2025-03-10 23:59:59','Offline',120,'₹75,000 and Gadgets'),('H107','Data Wizards','Hyderabad','2025-01-25 23:59:59','Online',300,'₹1,50,000 and Job Offers'),('H108','Startup Sprint','Pune','2025-04-20 23:59:59','Offline',100,'₹1,00,000 and Startup Funding'),('H109','Hack4Good','Kolkata','2025-03-05 23:59:59','Hybrid',250,'₹2,00,000 and Mentorship Programs'),('H110','CryptoBuild','Bangalore','2025-01-20 23:59:59','Online',180,'₹75,000 and NFTs'),('H111','GreenTech Hackathon','Ahmedabad','2025-02-28 23:59:59','Offline',90,'₹1,00,000 and Awards'),('H112','NextGen Coders','Trivandrum','2025-03-15 23:59:59','Online',210,'₹1,25,000 and Scholarships'),('H113','Robotics Hack','Bhopal','2025-04-10 23:59:59','Hybrid',300,'₹2,50,000 and Equipment');
/*!40000 ALTER TABLE `extra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hackathons`
--

DROP TABLE IF EXISTS `hackathons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hackathons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `dates` varchar(255) DEFAULT NULL,
  `prize` varchar(255) DEFAULT NULL,
  `participants` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `categories` text,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hackathons`
--

LOCK TABLES `hackathons` WRITE;
/*!40000 ALTER TABLE `hackathons` DISABLE KEYS */;
INSERT INTO `hackathons` VALUES (1,'dvhacks','jan 31 - feb 02, 2025','$18,073','41','online','beginner friendly, social good, web',NULL,NULL),(2,'exscore winter hackathon 2025','feb 01 - 07, 2025','$225','10','online','productivity, social good, web',NULL,NULL),(3,'makerhacks','feb 01 - 02, 2025','$5,444','1','sentry hq','beginner friendly, design, iot',NULL,NULL),(4,'pearai hackathon','jan 31 - feb 04, 2025','$10,000','449','online','machine learning/ai, productivity, web',NULL,NULL),(5,'crimsoncode hackathon','feb 15 - 16, 2025','$3,600','7','the spark: academic innovation hub','beginner friendly, open ended',NULL,NULL),(6,'scrapyard i̇stanbul','mar 15 - 16, 2025','$0','2','konumumuz en kısa sürede açıklanacak!','gaming, mobile, web',NULL,NULL),(7,'geesehacks','jan 25 - 26, 2025','$cad12,245','21','waterloo, canada','beginner friendly, machine learning/ai, open ended',NULL,NULL),(8,'tamuhack 2025','jan 25 - 26, 2025','$11,922','9','texas a&m - memorial student center','beginner friendly, design, open ended',NULL,NULL),(9,'hackeminds 2025','feb 08 - 09, 2025','$300','13','online','beginner friendly, productivity, social good',NULL,NULL),(10,'qhacks 2025','jan 24 - 26, 2025','$13,464','30','queen\'s university','beginner friendly, education, open ended',NULL,NULL),(11,'lg hacks','mar 23, 2025','$83,240','3','leigh high school','beginner friendly, design, web',NULL,NULL),(12,'hoya hacks 2025 presented by microsoft','jan 24 - 26, 2025','$1,866','256','healey family student center','beginner friendly, social good',NULL,NULL),(13,'devfest 2025','feb 08 - 09, 2025','$8,300','149','new york, ny, usa','beginner friendly, databases, social good',NULL,NULL),(14,'launchhacks iv','jun 08 - 09, 2025','$20,000','430','online','beginner friendly, education, open ended',NULL,NULL),(15,'hack the future: ai & open source hackathon','jan 23 - 26, 2025','$4,515','222','online','social good, machine learning/ai, open ended',NULL,NULL),(16,'deishacks 2025','jan 24 - 26, 2025','$2,500','3','waltham, ma, usa','beginner friendly, education, social good',NULL,NULL),(17,'mindthegap challenge','mar 15 - 21, 2025','$288','56','online','beginner friendly, social good',NULL,NULL),(18,'hack_ncstate 2025','feb 08 - 09, 2025','$3,458','13','hunt library/engineering building ii','beginner friendly, education, productivity',NULL,NULL),(19,'makeharvard 2025: the largest engineering hardware makeathon','feb 08 - 09, 2025','$7,000','8','harvard science and engineering complex','design, education, open ended',NULL,NULL),(20,'solution hackathon','feb 17 - 19, 2025','£6,000','13','ucl & kfupm','education, social good, health',NULL,NULL),(21,'hack downtown 2025 @ uva','feb 22 - 23, 2025','$695','27','rice hall','beginner friendly, education, productivity',NULL,NULL),(22,'brickhack 11','feb 22 - 23, 2025','$2,669','6','rit shed','iot, machine learning/ai, web',NULL,NULL),(23,'hackspace international #2','feb 14 - 17, 2025','$0','89','online','beginner friendly, education, machine learning/ai',NULL,NULL),(24,'road to start hack','feb 21, 2025','$4,000','4','epn quito - espol guayaquil','enterprise, education',NULL,NULL),(25,'irvinehacks 2025','jan 24 - 26, 2025','$7,409','3','uci student center pacific ballroom','open ended',NULL,NULL),(26,'hackattack','feb 14, 2025','₹ 8,000','16','online','beginner friendly, machine learning/ai, web',NULL,NULL),(27,'gunnhacks 11.0','jan 26, 2025','$1,500','1','henry m gunn high school - gunn library','open ended',NULL,NULL),(28,'hackcwru 2025','jan 24 - 26, 2025','$5,250','81','millis schmitt auditorium','beginner friendly, machine learning/ai',NULL,NULL),(29,'innohacks 2025 spring','feb 14 - 16, 2025','$220','5','online','beginner friendly, low/no code, social good',NULL,NULL),(30,'blossomhack 2025','mar 22 - 23, 2025','$5,225','68','online','beginner friendly, cybersecurity, open ended',NULL,NULL),(31,'vital hacks','mar 29, 2025','$0','9','online','beginner friendly, health, social good',NULL,NULL),(32,'hackhers 2025','feb 08 - 09, 2025','$0','1','college ave student center, rutgers','fintech, social good, machine learning/ai',NULL,NULL),(33,'rice datathon 2025','jan 30 - feb 02, 2025','$300','9','rice university - duncan hall','databases, machine learning/ai, social good',NULL,NULL),(34,'uwb hacks: save the world!','apr 25 - 27, 2025','$0','4','activities & recreation center (arc)','social good, beginner friendly, low/no code',NULL,NULL),(35,'seit hackathon','mar 22 - 23, 2025','$cad1,000','61','oshawa north campus - cir 102','beginner friendly, social good',NULL,NULL),(36,'(hatch) hudsonalpha tech challenge 2025','mar 01 - 02, 2025','$5,000','38','hudsonalpha institute for biotechnology','cybersecurity, education, health',NULL,NULL),(37,'mega hackathon 2025','mar 15 - 16, 2025','$374,325','461','online','beginner friendly, open ended, social good',NULL,NULL),(38,'[live ai ivy plus] harvard-duke hackathon','feb 22 - 23, 2025','$10,000','185','duke university and harvard university','blockchain, fintech, machine learning/ai',NULL,NULL),(39,'longhorn hacks','mar 08, 2025','$3,200','1','leigh high school - cafeteria','beginner friendly, open ended',NULL,NULL),(40,'mcit hackathon 2025','jan 22 - 26, 2025','$150','5','active learning room','education',NULL,NULL),(41,'kent hack enough 2025','feb 15 - 16, 2025','$2,672','13','kent state university','beginner friendly, open ended',NULL,NULL),(42,'hexinox gen.ai hackathon','jan 25 - 26, 2025','₹ 50,000','12','online','machine learning/ai, health, productivity',NULL,NULL),(43,'bisonhacks','feb 22 - 23, 2025','$7,575','2','howard university school of business','machine learning/ai, social good, beginner friendly',NULL,NULL),(44,'yash kulkarni\'s annual hackathon','mar 15 - 21, 2025','$100','51','online','beginner friendly, devops, machine learning/ai',NULL,NULL),(45,'hacknyu 2025','feb 08 - 09, 2025','$10,000','62','brooklyn, ny, usa','beginner friendly, fintech, machine learning/ai',NULL,NULL),(46,'united hacks v5','jul 11 - 13, 2025','$102,500','25','online','beginner friendly, open ended, social good',NULL,NULL),(47,'winghacks 2025','feb 07 - 09, 2025','$2,096','58','university of florida - newell hall','ar/vr, beginner friendly, open ended',NULL,NULL),(48,'volunteertech','jan 31 - feb 03, 2025','$0','19','online','machine learning/ai, social good, web',NULL,NULL),(49,'code4hope hackathon \'25','mar 31, 2025','$0','4','microsoft office @ times square','beginner friendly, machine learning/ai, social good',NULL,NULL),(50,'mistral ai hackathon: gaming edition','jan 24 - 26, 2025','€5,000','10','paris','gaming, machine learning/ai',NULL,NULL),(51,'scaleu + pia: ai agents in education','mar 11 - 13, 2025','$9,000','3','memorial union','education, enterprise',NULL,NULL),(52,'ugahacks x','feb 07 - 09, 2025','$0','54','zell b. miller learning center','beginner friendly, machine learning/ai, music/art',NULL,NULL),(53,'ghacks - 2025','feb 22 - 23, 2025','$cad2,500','2','university of calgary - eng 207','beginner friendly',NULL,NULL),(54,'rice design-a-thon 2025','jan 31 - feb 02, 2025','$4,390','196','online','design, low/no code, social good',NULL,NULL),(55,'rockethacks 2025','mar 15 - 16, 2025','$800','7','university of toledo - nitschke hall','beginner friendly, machine learning/ai, education',NULL,NULL),(56,'hackuncp 2025','mar 22 - 23, 2025','$3,000','17','pembroke, nc, usa','beginner friendly, machine learning/ai',NULL,NULL),(57,'datathon 2025: dataorbit','feb 22 - 23, 2025','$3,640','2','ucsb - loma pelona center','databases, machine learning/ai, open ended',NULL,NULL),(58,'iata one record hackathon','feb 24 - 25, 2025','$12,000','54','the convention centre dublin','iot, machine learning/ai, ar/vr',NULL,NULL),(59,'hack for hope','feb 01 - 02, 2025','$200','48','online','beginner friendly, health, machine learning/ai',NULL,NULL),(60,'gdgc x aic tech tournament #1: frontend','jan 22 - 29, 2025','$0','31','university center room 1225','design, web',NULL,NULL),(61,'the africa hack','feb 03 - 09, 2025','$15,000','3','workstation','blockchain, machine learning/ai, design',NULL,NULL),(62,'the climate change-makers challenge: 2025','feb 21 - 23, 2025','$cad2,140','73','online','beginner friendly, low/no code, social good',NULL,NULL),(63,'smathhacks 2025','feb 08 - 09, 2025','$194','8','online','beginner friendly, open ended, social good',NULL,NULL),(64,'decthon aiml competition','feb 02, 2025','$0','2','online','machine learning/ai',NULL,NULL),(65,'the fourth edition of icube(icube 4.0)','feb 06 - 07, 2025','₹ 100,000','14','sri venkateswara college of engineering','blockchain, iot, machine learning/ai',NULL,NULL),(66,'rose hack 2025','jan 25 - 26, 2025','$78','2','winston chung hall','beginner friendly, education',NULL,NULL),(67,'hack@davidson 2025','jan 31 - feb 02, 2025','$500','3','hurt hub@davidson','beginner friendly, machine learning/ai, web',NULL,NULL),(68,'swamphacks x','jan 25 - 26, 2025','$5,000','252','online','beginner friendly, machine learning/ai',NULL,NULL),(69,'calgaryhacks 2025','feb 15 - 16, 2025','$cad4,125','48','university of calgary','beginner friendly, gaming, web',NULL,NULL);
/*!40000 ALTER TABLE `hackathons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentor`
--

DROP TABLE IF EXISTS `mentor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `expertise` varchar(255) DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `github_id` varchar(255) DEFAULT NULL,
  `linkedin_id` varchar(255) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentor`
--

LOCK TABLES `mentor` WRITE;
/*!40000 ALTER TABLE `mentor` DISABLE KEYS */;
INSERT INTO `mentor` VALUES (12,'Dr. Rajeev Menon','rajeev.menon@example.com','AI/ML',15,'9876543210','rajeevmenon1','linkedin.com/in/rajeevmenon1','Mumbai'),(13,'Ms. Priya Desai','priya.desai@example.com','Web Development',10,'9874561230','priyadesai2','linkedin.com/in/priyadesai2','Delhi'),(14,'Mr. Karan Kapoor','karan.kapoor@example.com','Cybersecurity',8,'7896541230','karankapoor3','linkedin.com/in/karankapoor3','Bangalore'),(15,'Ms. Anjali Verma','anjali.verma@example.com','Data Science',12,'9638527410','anjaliverma4','linkedin.com/in/anjaliverma4','Hyderabad'),(16,'Dr. Mohit Sharma','mohit.sharma@example.com','Cloud Computing',9,'8529637410','mohitsharma5','linkedin.com/in/mohitsharma5','Chennai'),(17,'Ms. Kavita Reddy','kavita.reddy@example.com','Blockchain',7,'9517538520','kavitareddy6','linkedin.com/in/kavitareddy6','Pune'),(18,'Mr. Arjun Nair','arjun.nair@example.com','UI/UX Design',11,'7894561230','arjunnair7','linkedin.com/in/arjunnair7','Mumbai'),(19,'Ms. Sneha Ghosh','sneha.ghosh@example.com','DevOps',6,'7418529630','snehaghosh8','linkedin.com/in/snehaghosh8','Kolkata'),(20,'Dr. Vivek Gupta','vivek.gupta@example.com','Robotics',18,'9516247830','vivekgupta9','linkedin.com/in/vivekgupta9','Delhi'),(21,'Ms. Richa Jain','richa.jain@example.com','Big Data',13,'7891234560','richajain10','linkedin.com/in/richajain10','Bangalore');
/*!40000 ALTER TABLE `mentor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teams` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `skills` text,
  `hackathon_id` varchar(10) DEFAULT NULL,
  `members` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `hackathon_id` (`hackathon_id`),
  CONSTRAINT `teams_ibfk_1` FOREIGN KEY (`hackathon_id`) REFERENCES `extra` (`hackathon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
INSERT INTO `teams` VALUES (1,'Alpha Coders','Backend Development, Data Analysis','H104','Rahul Sharma, Sanya Kapoor, Priya Singh'),(2,'Beta Designers','UI/UX Design, Frontend Development','H105','Ananya Verma, Ishita Pandey'),(3,'Gamma Gurus','Machine Learning, Data Science','H106','Abhishek Rao, Manisha Gupta, Vikram Joshi, Harsh Vardhan'),(4,'Delta Developers','Cloud Computing, DevOps','H107','Rohan Deshmukh, Kavita Reddy'),(5,'Epsilon Experts','Cybersecurity, Full Stack','H108','Sneha Ghosh, Vivek Gupta, Richa Jain'),(6,'Zeta Innovators','AI/ML Engineering, Natural Language Processing','H109','Dr. Rajeev Menon, Ms. Priya Desai, Mr. Karan Kapoor'),(7,'Eta Visionaries','Blockchain Development, Cryptography','H110','Ms. Anjali Verma, Dr. Mohit Sharma'),(8,'Theta Technologists','Robotics, Data Engineering','H111','Dr. Vivek Gupta, Ms. Richa Jain'),(9,'Iota Pioneers','Big Data, AI/ML','H112','Mr. Arjun Nair, Ms. Priya Desai, Dr. Rajeev Menon'),(10,'Kappa Collaborators','Robotics, Software Engineering','H113','Ms. Kavita Reddy, Dr. Mohit Sharma');
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `name` varchar(100) DEFAULT NULL,
  `phone_no` varchar(15) DEFAULT NULL,
  `college_name` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `skills` varchar(200) DEFAULT NULL,
  `password_hash` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `github_id` varchar(50) DEFAULT NULL,
  `linkedin_id` varchar(100) DEFAULT NULL,
  `last_active` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--
---changes
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('Rahul Sharma','9123456789','IIT Bombay','Mumbai','Backend Developer','hashed_password_here',NULL,'vikramjoshi345','linkedin.com/in/vikramjoshi345','2025-01-13 03:17:31'),('Sanya Kapoor','9876543210','Delhi Technological University','Delhi','Data Scientist','hashed_password_here',NULL,'sanyakapoor456','linkedin.com/in/sanyakapoor456','2025-01-13 03:17:31'),('Abhishek Rao','7894561230','BITS Pilani','Hyderabad','Full Stack Developer','hashed_password_here',NULL,'abhishekrao567','linkedin.com/in/abhishekrao567','2025-01-13 03:17:31'),('Priya Singh','9517538524','Anna University','Chennai','UI/UX Designer','hashed_password_here',NULL,'priyasingh678','linkedin.com/in/priyasingh678','2025-01-13 03:17:31'),('Manisha Gupta','8529637410','IIT Kharagpur','Kolkata','AI/ML Engineer','hashed_password_here',NULL,'manishagupta789','linkedin.com/in/manishagupta789','2025-01-13 03:17:31'),('Rohan Deshmukh','9638527410','IIT Madras','Chennai','Cloud Engineer','hashed_password_here',NULL,'rohandeshmukh890','linkedin.com/in/rohandeshmukh890','2025-01-13 03:17:31'),('Ananya Verma','7418529630','Manipal Institute of Technology','Bangalore','Frontend Developer','hashed_password_here',NULL,'ananyaverma901','linkedin.com/in/ananyaverma901','2025-01-13 03:17:31'),('Harsh Vardhan','7891234560','NIT Trichy','Tiruchirappalli','DevOps Engineer','hashed_password_here',NULL,'harshvardhan123','linkedin.com/in/harshvardhan123','2025-01-13 03:17:31'),('Ishita Pandey','9516247830','University of Hyderabad','Hyderabad','Cybersecurity Specialist','hashed_password_here',NULL,'ishitapandey234','linkedin.com/in/ishitapandey234','2025-01-13 03:17:31'),('Vikram Joshi','7896541230','IIM Ahmedabad','Ahmedabad','Data Analyst','hashed_password_here',NULL,'vikramjoshi345','linkedin.com/in/vikramjoshi345','2025-01-13 03:17:31'),('John Doe','1234567890','ABC University','CityName','Python, SQL','hashedpassword123',NULL,'john_doe_github','john_doe_linkedin','2025-01-13 03:17:31'),('Snehal Meshram','123456789','CBA University','Nagpur','Java, SQL','psqd123',NULL,'snehal_github','snehal_linkedin','2025-01-13 03:17:31'),('rani','8989','hdj','hguikjdm','hdjk','8989',NULL,'ffcmn ','djkdm','2025-01-13 03:17:31'),('d','1111111111','ds','Delhi','dd','0909090','usidhhi@gmail.com','bb','cc','2025-01-13 03:18:36'),('abs','1234567891','ds','Mumbai','dd','898989','rtyu@gmail.com','bb','11','2025-01-13 05:20:15'),('Siddhi Uttarwar','0820838064','MKSSS\'s Cummins College of Engineering for Women Pune','Chennai','java','676767','siddhi197uttarwar@gmail.com','h','nn','2025-01-13 06:20:01'),('Siddhi Uttarwar','8208380641','abcd','Kolkata','ddg','121212','siddhi197uttarwar@gmail.com','dsb','ds','2025-01-13 06:48:44');
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

-- Dump completed on 2025-01-24 22:33:23
