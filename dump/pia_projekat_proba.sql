-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 09, 2020 at 02:05 AM
-- Server version: 8.0.2-dmr-log
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pia_projekat_proba`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `povacaj_br_proizvoda_u_magacinu` (`porId` BIGINT(20), `magId` BIGINT(20))  BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE proizvodId  BIGINT(20);
	DECLARE kol  INT;
    DECLARE cnt  INT;
	DECLARE kursor CURSOR FOR SELECT proizvod_id, kolicina from proizvod_porudzbina where porudzbina_id=porId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN kursor;

  read_loop: LOOP
    FETCH kursor INTO proizvodId, kol;
   
    IF done THEN
      LEAVE read_loop;
    END IF;
    set cnt = (select count(*)  from magacin_proizvod where magacin_id=magId and proizvod_id=proizvodId);
    if cnt>0 then
		update magacin_proizvod set kolicina = kolicina+kol where proizvod_id=proizvodId;    
	else
		insert into magacin_proizvod(magacin_id, proizvod_id, kolicina) values (magId,proizvodId, kol);
    end if;
  END LOOP;

  CLOSE kursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `progres_sadnica` ()  BEGIN
    
  UPDATE sadnice SET progres = progres + 1/vek where (progres+1/vek)<=1;
   UPDATE sadnice SET progres = 1 where (progres+1/vek)>1;
  INSERT INTO messages(message,created_at)
  VALUES('Sadnice obavile dnevni progres',NOW());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sadnica_izvadjena` ()  BEGIN
	update sadnice set cnt = cnt-1 where uklonjena=true;
    delete from sadnice where cnt=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `smanji_br_proizvoda` (`porId` BIGINT(20))  BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE proizvodId  BIGINT(20);
	DECLARE kol  INT;
	DECLARE kursor CURSOR FOR SELECT proizvod_id, kolicina from proizvod_porudzbina where porudzbina_id=porId;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN kursor;

  read_loop: LOOP
    FETCH kursor INTO proizvodId, kol;
   
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    update proizvodi set kolicina = kolicina-kol where id=proizvodId and (kolicina-kol)>=0;
      update proizvodi set kolicina = 0 where id=proizvodId and (kolicina-kol)<0;
  END LOOP;

  CLOSE kursor;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_kuriri` ()  BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE kurirId  BIGINT(20);
	DECLARE porId  BIGINT(20);
    DECLARE vi  datetime;
	DECLARE kursor CURSOR FOR SELECT kurir_id, porudzbina_id, vreme_isporuke from je_dodeljen;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN kursor;

  read_loop: LOOP
    FETCH kursor INTO kurirId, porId, vi;
   
    IF done THEN
      LEAVE read_loop;
    END IF;
    
    if now()>=vi then
		update porudzbine set status = 'isporucena' where id=porId and status<>'isporucena'; 
        update kuriri set slobodan=true where id = kurirId;
    end if;
  END LOOP;

  CLOSE kursor;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `je_dodeljen`
--

CREATE TABLE `je_dodeljen` (
  `kurir_id` bigint(20) NOT NULL,
  `porudzbina_id` bigint(20) NOT NULL,
  `udaljenost` decimal(10,2) DEFAULT NULL,
  `vreme` decimal(10,2) DEFAULT NULL,
  `vreme_preuzimanja` datetime DEFAULT NULL,
  `vreme_isporuke` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `je_dodeljen`
--

INSERT INTO `je_dodeljen` (`kurir_id`, `porudzbina_id`, `udaljenost`, `vreme`, `vreme_preuzimanja`, `vreme_isporuke`) VALUES
(1, 74, '6.00', '800.00', '2020-07-08 22:55:18', '2020-07-08 22:57:38'),
(22, 75, '6.00', '776.00', '2020-07-08 23:43:42', '2020-07-08 23:56:38'),
(22, 76, '6.00', '776.00', '2020-07-09 00:01:29', '2020-07-09 00:14:25');

--
-- Triggers `je_dodeljen`
--
DELIMITER $$
CREATE TRIGGER `je_dodeljen_AFTER_INSERT` AFTER INSERT ON `je_dodeljen` FOR EACH ROW BEGIN

 update kuriri set slobodan=false where id=NEW.kurir_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `je_ocenio`
--

CREATE TABLE `je_ocenio` (
  `user_id` bigint(20) NOT NULL,
  `proizvod_id` bigint(20) NOT NULL,
  `komentar` varchar(450) DEFAULT NULL,
  `ocena` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `je_ocenio`
--

INSERT INTO `je_ocenio` (`user_id`, `proizvod_id`, `komentar`, `ocena`) VALUES
(3, 1, 'ok', 4),
(3, 2, 'ok', 4),
(3, 3, 'ok', 4),
(3, 10, 'ok', 4),
(3, 11, 'ok', 4),
(3, 12, 'ok', 4),
(3, 65, 'okej', 4),
(90, 1, 'Dobar beli luk hehe', 5),
(90, 2, 'onako', 3),
(90, 3, 'osrednje', 3),
(90, 4, 'Ljut ko pašče', 4),
(90, 10, 'okej', 3),
(90, 11, 'fino', 4),
(90, 12, 'nije lose', 4);

--
-- Triggers `je_ocenio`
--
DELIMITER $$
CREATE TRIGGER `je_ocenio_AFTER_INSERT` AFTER INSERT ON `je_ocenio` FOR EACH ROW BEGIN
 UPDATE  proizvodi SET ocena = (ocena*br_ocena + NEW.ocena)/(br_ocena+1) WHERE id = NEW.proizvod_id;
 UPDATE proizvodi SET br_ocena = br_ocena + 1  WHERE id = NEW.proizvod_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kuriri`
--

CREATE TABLE `kuriri` (
  `id` bigint(20) NOT NULL,
  `preduzece_id` bigint(20) DEFAULT NULL,
  `ime` varchar(45) DEFAULT NULL,
  `slobodan` bit(1) DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kuriri`
--

INSERT INTO `kuriri` (`id`, `preduzece_id`, `ime`, `slobodan`) VALUES
(1, 1, 'Marko', b'1'),
(2, 1, 'Ivan', b'1'),
(3, 1, 'Nikola', b'1'),
(5, 1, 'Djordje', b'1'),
(6, 1, 'Uros', b'1'),
(7, 2, 'Marko', b'1'),
(8, 2, 'Ivan', b'1'),
(9, 2, 'Nikola', b'1'),
(10, 2, 'Djordje', b'1'),
(11, 2, 'Uros', b'1'),
(12, 3, 'Marko', b'1'),
(13, 3, 'Ivan', b'1'),
(14, 3, 'Nikola', b'1'),
(15, 3, 'Djordje', b'1'),
(16, 3, 'Uros', b'1'),
(22, 7, 'Marko', b'1'),
(23, 7, 'Ivan', b'1'),
(24, 7, 'Nikola', b'1'),
(25, 7, 'Djordje', b'1'),
(26, 7, 'Uros', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `magacini`
--

CREATE TABLE `magacini` (
  `id` bigint(20) NOT NULL,
  `rasadnik_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `magacini`
--

INSERT INTO `magacini` (`id`, `rasadnik_id`) VALUES
(1, 1),
(2, 2),
(25, 29),
(32, 36);

-- --------------------------------------------------------

--
-- Table structure for table `magacin_proizvod`
--

CREATE TABLE `magacin_proizvod` (
  `magacin_id` bigint(20) NOT NULL,
  `proizvod_id` bigint(20) NOT NULL,
  `naziv` varchar(45) DEFAULT NULL,
  `proizvodjac` varchar(45) DEFAULT NULL,
  `kolicina` int(11) DEFAULT NULL,
  `dani` int(11) DEFAULT NULL,
  `kategorija` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `magacin_proizvod`
--

INSERT INTO `magacin_proizvod` (`magacin_id`, `proizvod_id`, `naziv`, `proizvodjac`, `kolicina`, `dani`, `kategorija`) VALUES
(1, 1, 'Beli luk bosut 25g', 'LukovicaPro', 16, 200, 'sadnica'),
(1, 2, 'Beli luk bosut 100 000s', 'LukovicaPro', 23, 200, 'sadnica'),
(1, 3, 'Crni luk holandski zuti 25g', 'LukovicaPro', 33, 180, 'sadnica'),
(1, 10, 'Luk Fiamma F1 100 000s', 'LukovicaPro', 18, 180, 'sadnica'),
(1, 11, 'Srebrenjak Kosma F1 100g', 'LukovicaPro', 4, 180, 'sadnica'),
(1, 12, 'Praziluk Lancelot F1 10 000s', 'LukovicaPro', 15, 190, 'sadnica'),
(1, 28, 'Puterica Baglin 5000s', 'Libis', 3, 150, 'sadnica'),
(1, 29, 'Puterica Daguan 5000s', 'Libis', 5, 150, 'sadnica'),
(1, 30, 'Puterica Julian  5000s', 'Libis', 4, 155, 'sadnica'),
(1, 51, 'Anis 10g', 'Herbis', 4, 160, 'sadnica'),
(1, 52, 'Bosiljak 10', 'Herbis', 4, 100, 'sadnica'),
(1, 53, 'Kamilica 5g', 'Herbis', 3, 110, 'sadnica'),
(1, 54, 'Korijander  10g', 'Herbis', 4, 115, 'sadnica'),
(1, 64, 'Calcinit 2 kg', 'Yara', 3, 10, 'preparat'),
(1, 66, 'Ferticare I 14-11-25 10g', 'Yara', 3, 25, 'preparat'),
(1, 67, 'Ferticare II 24-8-16 2kg', 'Yara', 4, 2, 'preparat'),
(1, 70, 'Fitofert Ferro Max 11', 'Fitofert', 4, 5, 'preparat'),
(1, 71, 'Fitofert Combivit 20', 'Fitofert', 5, 2, 'preparat'),
(1, 72, 'Fitofert Humisuper plus', 'Fitofert', 4, 7, 'preparat'),
(2, 1, 'Beli luk bosut 25g', 'LukovicaPro', 16, 200, 'sadnica'),
(2, 4, 'Crni luk holandski zuti 100 000s', 'LukovicaPro', 54, 180, 'sadnica'),
(2, 5, 'Crni luk Elenka F1 100 000s', 'LukovicaPro', 5, 170, 'sadnica'),
(2, 13, 'Praziluk Lincoln F1 10 000s', 'LukovicaPro', 5, 210, 'sadnica'),
(2, 31, 'Puterica Mafalda 10 000s', 'Libis', 5, 145, 'sadnica'),
(2, 55, 'Lavanda 5 g', 'Herbis', 5, 105, 'sadnica'),
(2, 56, 'Majčina dušica 5 g', 'Herbis', 5, 110, 'sadnica'),
(2, 57, 'Mirođija 10 g', 'Herbis', 5, 100, 'sadnica'),
(2, 58, 'Origano 5 g', 'Herbis', 5, 120, 'sadnica'),
(2, 64, 'Calcinit 2 kg', 'Yara', 4, 10, 'preparat'),
(2, 65, 'Cropcare 11-11-21 5kg', 'Yara', 5, 15, 'preparat'),
(2, 66, 'Ferticare I 14-11-25 10g', 'Yara', 5, 25, 'preparat'),
(2, 67, 'Ferticare II 24-8-16 2kg', 'Yara', 5, 2, 'preparat'),
(2, 71, 'Fitofert Combivit 20', 'Fitofert', 5, 2, 'preparat'),
(25, 1, 'Beli luk bosut 25g', 'LukovicaPro', 15, 200, 'sadnica'),
(25, 10, 'Luk Fiamma dzak', 'LukovicaPro', 3, 180, 'sadnica'),
(32, 1, 'Beli luk bosut 25g', 'LukovicaPro', 2, 200, 'sadnica'),
(32, 10, 'Luk Fiamma dzak', 'LukovicaPro', 2, 180, 'sadnica'),
(32, 12, 'Praziluk Lancelot', 'LukovicaPro', 2, 190, 'sadnica'),
(32, 64, 'Calcinit 2 kg', 'Fitofert', 2, 10, 'preparat'),
(32, 65, 'Cropcare 11-11-21 ', 'Fitofert', 1, 15, 'preparat');

--
-- Triggers `magacin_proizvod`
--
DELIMITER $$
CREATE TRIGGER `magacin_proizvod_dani_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW SET NEW.dani =  (SELECT dani FROM `pia_projekat_proba`.`proizvodi` WHERE NEW.proizvod_id = id)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `magacin_proizvod_kategorija_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW SET NEW.kategorija = (SELECT kategorija FROM `pia_projekat_proba`.`proizvodi` WHERE id = NEW.proizvod_id )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `magacin_proizvod_naziv_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW SET NEW.naziv = (SELECT naziv FROM `pia_projekat_proba`.`proizvodi` WHERE id = NEW.proizvod_id )
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `magacin_proizvod_pro_BEFORE_INSERT` BEFORE INSERT ON `magacin_proizvod` FOR EACH ROW SET NEW.proizvodjac =  (SELECT proizvodjac.naziv FROM `pia_projekat_proba`.`preduzeca` proizvodjac, `pia_projekat_proba`.`proizvodi` proizvod 
								WHERE NEW.proizvod_id = proizvod.id AND proizvod.preduzece_id = proizvodjac.id)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `message`, `created_at`) VALUES
(25, 'Sadnice obavile dnevni progres', '2020-07-08 20:30:32'),
(26, 'Sadnice obavile dnevni progres', '2020-07-08 20:31:02'),
(27, 'Sadnice obavile dnevni progres', '2020-07-08 20:31:32'),
(28, 'Sadnice obavile dnevni progres', '2020-07-08 20:32:03'),
(29, 'Sadnice obavile dnevni progres', '2020-07-08 20:32:32'),
(30, 'Sadnice obavile dnevni progres', '2020-07-08 20:33:02'),
(31, 'Sadnice obavile dnevni progres', '2020-07-08 20:33:32'),
(32, 'Sadnice obavile dnevni progres', '2020-07-08 20:34:03'),
(33, 'Sadnice obavile dnevni progres', '2020-07-08 20:34:32'),
(34, 'Sadnice obavile dnevni progres', '2020-07-08 20:35:02'),
(35, 'Sadnice obavile dnevni progres', '2020-07-08 20:35:32'),
(36, 'Sadnice obavile dnevni progres', '2020-07-08 20:36:02'),
(37, 'Temperatura smanjena za pola stepena', '2020-07-08 20:36:24'),
(38, 'Kolicina vode smanjena za litar', '2020-07-08 20:36:24'),
(39, 'Sadnice obavile dnevni progres', '2020-07-08 20:36:32'),
(40, 'Sadnice obavile dnevni progres', '2020-07-08 20:37:02'),
(41, 'Sadnice obavile dnevni progres', '2020-07-08 20:37:32'),
(42, 'Sadnice obavile dnevni progres', '2020-07-08 20:38:04'),
(43, 'Sadnice obavile dnevni progres', '2020-07-08 20:38:32'),
(44, 'Sadnice obavile dnevni progres', '2020-07-08 20:39:03'),
(45, 'Sadnice obavile dnevni progres', '2020-07-08 20:39:33'),
(46, 'Sadnice obavile dnevni progres', '2020-07-08 20:40:02'),
(47, 'Sadnice obavile dnevni progres', '2020-07-08 20:40:32'),
(48, 'Sadnice obavile dnevni progres', '2020-07-08 20:41:02'),
(49, 'Sadnice obavile dnevni progres', '2020-07-08 20:41:33'),
(50, 'Sadnice obavile dnevni progres', '2020-07-08 20:42:02'),
(51, 'Sadnice obavile dnevni progres', '2020-07-08 20:42:32'),
(52, 'Sadnice obavile dnevni progres', '2020-07-08 20:43:02'),
(53, 'Sadnice obavile dnevni progres', '2020-07-08 20:43:32'),
(54, 'Sadnice obavile dnevni progres', '2020-07-08 20:44:03'),
(55, 'Sadnice obavile dnevni progres', '2020-07-08 20:44:32'),
(56, 'Sadnice obavile dnevni progres', '2020-07-08 20:45:02'),
(57, 'Sadnice obavile dnevni progres', '2020-07-08 20:45:32'),
(58, 'Sadnice obavile dnevni progres', '2020-07-08 20:46:02'),
(59, 'Sadnice obavile dnevni progres', '2020-07-08 20:46:33'),
(60, 'Sadnice obavile dnevni progres', '2020-07-08 20:47:02'),
(61, 'Sadnice obavile dnevni progres', '2020-07-08 20:47:32'),
(62, 'Sadnice obavile dnevni progres', '2020-07-08 20:48:03'),
(63, 'Sadnice obavile dnevni progres', '2020-07-08 20:48:34'),
(64, 'Sadnice obavile dnevni progres', '2020-07-08 20:49:02'),
(65, 'Sadnice obavile dnevni progres', '2020-07-08 20:49:32'),
(66, 'Sadnice obavile dnevni progres', '2020-07-08 20:50:03'),
(67, 'Sadnice obavile dnevni progres', '2020-07-08 20:50:33'),
(68, 'Sadnice obavile dnevni progres', '2020-07-08 20:51:02'),
(69, 'Sadnice obavile dnevni progres', '2020-07-08 20:51:32'),
(70, 'Sadnice obavile dnevni progres', '2020-07-08 20:52:02'),
(71, 'Sadnice obavile dnevni progres', '2020-07-08 20:52:32'),
(72, 'Sadnice obavile dnevni progres', '2020-07-08 20:53:02'),
(73, 'Sadnice obavile dnevni progres', '2020-07-08 20:53:32'),
(74, 'Sadnice obavile dnevni progres', '2020-07-08 20:54:02'),
(75, 'Sadnice obavile dnevni progres', '2020-07-08 20:54:32'),
(76, 'Sadnice obavile dnevni progres', '2020-07-08 20:55:02'),
(77, 'Sadnice obavile dnevni progres', '2020-07-08 20:55:32'),
(78, 'Sadnice obavile dnevni progres', '2020-07-08 20:56:02'),
(79, 'Sadnice obavile dnevni progres', '2020-07-08 20:56:32'),
(80, 'Sadnice obavile dnevni progres', '2020-07-08 20:57:02'),
(81, 'Sadnice obavile dnevni progres', '2020-07-08 20:57:32'),
(82, 'Sadnice obavile dnevni progres', '2020-07-08 20:58:02'),
(83, 'Sadnice obavile dnevni progres', '2020-07-08 20:58:33'),
(84, 'Sadnice obavile dnevni progres', '2020-07-08 20:59:02'),
(85, 'Sadnice obavile dnevni progres', '2020-07-08 20:59:32'),
(86, 'Sadnice obavile dnevni progres', '2020-07-08 21:00:02'),
(87, 'Sadnice obavile dnevni progres', '2020-07-08 21:00:32'),
(88, 'Sadnice obavile dnevni progres', '2020-07-08 21:01:03'),
(89, 'Sadnice obavile dnevni progres', '2020-07-08 21:01:32'),
(90, 'Sadnice obavile dnevni progres', '2020-07-08 21:02:02'),
(91, 'Sadnice obavile dnevni progres', '2020-07-08 21:02:32'),
(92, 'Sadnice obavile dnevni progres', '2020-07-08 21:03:02'),
(93, 'Sadnice obavile dnevni progres', '2020-07-08 21:03:32'),
(94, 'Sadnice obavile dnevni progres', '2020-07-08 21:04:03'),
(95, 'Sadnice obavile dnevni progres', '2020-07-08 21:04:32'),
(96, 'Sadnice obavile dnevni progres', '2020-07-08 21:05:02'),
(97, 'Sadnice obavile dnevni progres', '2020-07-08 21:05:32'),
(98, 'Sadnice obavile dnevni progres', '2020-07-08 21:06:02'),
(99, 'Sadnice obavile dnevni progres', '2020-07-08 21:06:32'),
(100, 'Sadnice obavile dnevni progres', '2020-07-08 21:07:03'),
(101, 'Sadnice obavile dnevni progres', '2020-07-08 21:07:32'),
(102, 'Sadnice obavile dnevni progres', '2020-07-08 21:08:02'),
(103, 'Sadnice obavile dnevni progres', '2020-07-08 21:08:32'),
(104, 'Sadnice obavile dnevni progres', '2020-07-08 21:09:02'),
(105, 'Sadnice obavile dnevni progres', '2020-07-08 21:09:33'),
(106, 'Sadnice obavile dnevni progres', '2020-07-08 21:10:02'),
(107, 'Sadnice obavile dnevni progres', '2020-07-08 21:10:32'),
(108, 'Sadnice obavile dnevni progres', '2020-07-08 21:11:03'),
(109, 'Sadnice obavile dnevni progres', '2020-07-08 21:11:33'),
(110, 'Sadnice obavile dnevni progres', '2020-07-08 21:12:02'),
(111, 'Sadnice obavile dnevni progres', '2020-07-08 21:12:32'),
(112, 'Sadnice obavile dnevni progres', '2020-07-08 21:13:02'),
(113, 'Sadnice obavile dnevni progres', '2020-07-08 21:13:32'),
(114, 'Sadnice obavile dnevni progres', '2020-07-08 21:14:03'),
(115, 'Sadnice obavile dnevni progres', '2020-07-08 21:14:32'),
(116, 'Sadnice obavile dnevni progres', '2020-07-08 21:15:02'),
(117, 'Sadnice obavile dnevni progres', '2020-07-08 21:15:32'),
(118, 'Sadnice obavile dnevni progres', '2020-07-08 21:16:03'),
(119, 'Sadnice obavile dnevni progres', '2020-07-08 21:16:32'),
(120, 'Sadnice obavile dnevni progres', '2020-07-08 21:17:02'),
(121, 'Sadnice obavile dnevni progres', '2020-07-08 21:17:32'),
(122, 'Sadnice obavile dnevni progres', '2020-07-08 21:18:02'),
(123, 'Sadnice obavile dnevni progres', '2020-07-08 21:18:32'),
(124, 'Sadnice obavile dnevni progres', '2020-07-08 21:19:03'),
(125, 'Sadnice obavile dnevni progres', '2020-07-08 21:19:32'),
(126, 'Sadnice obavile dnevni progres', '2020-07-08 21:20:02'),
(127, 'Sadnice obavile dnevni progres', '2020-07-08 21:20:32'),
(128, 'Sadnice obavile dnevni progres', '2020-07-08 21:21:02'),
(129, 'Sadnice obavile dnevni progres', '2020-07-08 21:21:33'),
(130, 'Sadnice obavile dnevni progres', '2020-07-08 21:22:02'),
(131, 'Sadnice obavile dnevni progres', '2020-07-08 21:22:32'),
(132, 'Sadnice obavile dnevni progres', '2020-07-08 21:23:02'),
(133, 'Sadnice obavile dnevni progres', '2020-07-08 21:23:32'),
(134, 'Sadnice obavile dnevni progres', '2020-07-08 21:24:02'),
(135, 'Sadnice obavile dnevni progres', '2020-07-08 21:24:33'),
(136, 'Sadnice obavile dnevni progres', '2020-07-08 21:25:02'),
(137, 'Sadnice obavile dnevni progres', '2020-07-08 21:25:32'),
(138, 'Sadnice obavile dnevni progres', '2020-07-08 21:26:02'),
(139, 'Sadnice obavile dnevni progres', '2020-07-08 21:26:32'),
(140, 'Sadnice obavile dnevni progres', '2020-07-08 21:27:03'),
(141, 'Sadnice obavile dnevni progres', '2020-07-08 21:27:33'),
(142, 'Sadnice obavile dnevni progres', '2020-07-08 21:28:02'),
(143, 'Sadnice obavile dnevni progres', '2020-07-08 21:28:32'),
(144, 'Sadnice obavile dnevni progres', '2020-07-08 21:29:02'),
(145, 'Sadnice obavile dnevni progres', '2020-07-08 21:29:32'),
(146, 'Sadnice obavile dnevni progres', '2020-07-08 21:30:03'),
(147, 'Sadnice obavile dnevni progres', '2020-07-08 21:30:32'),
(148, 'Sadnice obavile dnevni progres', '2020-07-08 21:31:02'),
(149, 'Sadnice obavile dnevni progres', '2020-07-08 21:31:32'),
(150, 'Sadnice obavile dnevni progres', '2020-07-08 21:31:38');

-- --------------------------------------------------------

--
-- Table structure for table `poljoprivrednici`
--

CREATE TABLE `poljoprivrednici` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `ime` varchar(45) DEFAULT NULL,
  `prezime` varchar(45) DEFAULT NULL,
  `datum_rodjenja` date DEFAULT NULL,
  `mesto_rodjenja` varchar(45) DEFAULT NULL,
  `telefon` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `poljoprivrednici`
--

INSERT INTO `poljoprivrednici` (`id`, `user_id`, `ime`, `prezime`, `datum_rodjenja`, `mesto_rodjenja`, `telefon`, `email`) VALUES
(1, 90, 'Marko', 'Maric', '1985-02-12', 'Beograd', '0655050505', 'alexstan220196@gmail.com'),
(2, 3, 'Milan', 'Milic', '1971-06-09', 'Uzice ', '0655050444', 'alexstan220196@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `polj_zahtevi`
--

CREATE TABLE `polj_zahtevi` (
  `id` bigint(20) NOT NULL,
  `ime` varchar(45) DEFAULT NULL,
  `prezime` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `datum_rodjenja` date DEFAULT NULL,
  `mesto_rodjenja` varchar(45) DEFAULT NULL,
  `telefon` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `prihvacen` bit(1) DEFAULT b'0',
  `nije_prihvacen` bit(1) DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `polj_zahtevi`
--

INSERT INTO `polj_zahtevi` (`id`, `ime`, `prezime`, `username`, `password`, `datum_rodjenja`, `mesto_rodjenja`, `telefon`, `email`, `prihvacen`, `nije_prihvacen`) VALUES
(2, 'Marko', 'Stanojevic', 'mare123', 'mare123', '1938-02-27', 'Karan', '+381655050555', 'mare@gmail.com', b'1', b'0'),
(10, 'Aleksandra', 'Stanojevic', 'alex123', 'a2aA@assd', '2020-05-15', 'Uzice', '123', 'alex@gamil.com', b'0', b'1'),
(17, 'Aleksa', 'Stojic', 'aleksa123', 'Aleksa123@', '1995-07-18', 'Kragujevac', '0655050500', 'aleksa123@gmail.com', b'0', b'0');

--
-- Triggers `polj_zahtevi`
--
DELIMITER $$
CREATE TRIGGER `polj_zahtevi_AFTER_UPDATE` AFTER UPDATE ON `polj_zahtevi` FOR EACH ROW BEGIN
	IF OLD.prihvacen = 1 THEN
    INSERT INTO poljoprivrednici(ime,prezime,datum_rodjenja,mesto_rodjenja,telefon,email) 
		VALUES (OLD.ime, OLD.prezime, OLD.datum_rodjenja, OLD.mesto_rodjenja, OLD.telefon, OLD.email);
		INSERT INTO users(username, password, role) VALUES (OLD.username, OLD.PASSWORD,"ROLE_POLJOPRIVREDNIK");
			END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `porudzbine`
--

CREATE TABLE `porudzbine` (
  `id` bigint(20) NOT NULL,
  `preduzece_id` bigint(20) DEFAULT NULL,
  `polj_id` bigint(20) DEFAULT NULL,
  `rasadnik_id` bigint(20) DEFAULT NULL,
  `cena` decimal(13,0) DEFAULT '0',
  `status` varchar(45) DEFAULT 'kreirana',
  `datum_kreiranja` datetime DEFAULT NULL,
  `datum_prihvatanja` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `porudzbine`
--

INSERT INTO `porudzbine` (`id`, `preduzece_id`, `polj_id`, `rasadnik_id`, `cena`, `status`, `datum_kreiranja`, `datum_prihvatanja`) VALUES
(2, 1, 1, 1, '152500', 'isporucena', '2020-06-23 16:33:39', NULL),
(26, 1, 1, 2, '1100', 'kreirana', '2020-06-24 21:29:42', NULL),
(27, 2, 1, 2, '7200', 'kreirana', '2020-06-25 21:29:42', NULL),
(50, 2, 2, 29, '7319', 'kreirana', '2020-05-24 22:11:47', NULL),
(51, 3, 2, 29, '188', 'kreirana', '2020-06-24 22:11:47', NULL),
(52, 1, 2, 29, '3720', 'kreirana', '2020-06-26 22:14:41', NULL),
(53, 2, 2, 29, '10800', 'kreirana', '2020-06-24 22:14:41', NULL),
(54, 3, 2, 29, '10500', 'kreirana', '2020-06-24 22:14:41', NULL),
(55, 7, 1, 1, '3020', 'kreirana', '2020-06-30 20:17:39', NULL),
(58, 2, 1, 1, '3600', 'otkazana', '2020-06-01 00:07:15', NULL),
(65, 3, 1, 2, '210', 'kreirana', '2020-07-08 15:01:25', NULL),
(68, 1, 1, 2, '250', 'kreirana', '2020-07-08 15:39:09', NULL),
(72, 1, 1, 2, '14400', 'isporucena', '2020-07-08 18:01:00', NULL),
(74, 1, 2, 36, '18420', 'isporucena', '2020-07-08 22:51:15', NULL),
(75, 7, 2, 36, '421', 'isporucena', '2020-07-08 23:42:05', NULL),
(76, 7, 2, 36, '635', 'isporucena', '2020-07-09 00:00:19', NULL);

--
-- Triggers `porudzbine`
--
DELIMITER $$
CREATE TRIGGER `porudzbine_AFTER_UPDATE` AFTER UPDATE ON `porudzbine` FOR EACH ROW BEGIN
	if(NEW.status='prihvacena')then
		call smanji_br_proizvoda(NEW.id);
    end if; 
    if(NEW.status='isporucena')then
		call povacaj_br_proizvoda_u_magacinu(
			NEW.id,
            (select id  from magacini where rasadnik_id=NEW.rasadnik_id)
        );
        
    end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `preduzeca`
--

CREATE TABLE `preduzeca` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `naziv` varchar(45) DEFAULT NULL,
  `datum_osnivanja` date DEFAULT NULL,
  `mesto_osnivanja` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `preduzeca`
--

INSERT INTO `preduzeca` (`id`, `user_id`, `naziv`, `datum_osnivanja`, `mesto_osnivanja`, `email`) VALUES
(1, 10, 'LukovicaPro', '2001-01-11', 'Beograd', 'lukovicapro@gmail.com'),
(2, 11, 'Libis', '2003-01-11', 'Beograd', 'libis@gmail.com'),
(3, 12, 'Herbis', '2005-01-11', 'Novi Sad', 'herbis@gmail.com'),
(7, 16, 'Fitofert', '2004-01-11', 'Kraljevo', 'fitofert@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `pred_zahtevi`
--

CREATE TABLE `pred_zahtevi` (
  `id` bigint(20) NOT NULL,
  `naziv` varchar(45) DEFAULT NULL,
  `skracenica` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `datum_osnivanja` date DEFAULT NULL,
  `mesto_osnivanja` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `prihvacen` bit(1) DEFAULT b'0',
  `nije_prihvacen` bit(1) DEFAULT b'0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pred_zahtevi`
--

INSERT INTO `pred_zahtevi` (`id`, `naziv`, `skracenica`, `password`, `datum_osnivanja`, `mesto_osnivanja`, `email`, `prihvacen`, `nije_prihvacen`) VALUES
(4, 'Lipa', 'lpa', 'lpa123', '2020-05-08', 'Beograd', 'lpa@gmail.com', b'1', b'0');

--
-- Triggers `pred_zahtevi`
--
DELIMITER $$
CREATE TRIGGER `pred_zahtevi_AFTER_UPDATE` AFTER UPDATE ON `pred_zahtevi` FOR EACH ROW BEGIN
	IF OLD.prihvacen = 1 THEN
    INSERT INTO preduzeca(naziv,datum_osnivanja,mesto_osnivanja,email) 
		VALUES (OLD.naziv, OLD.datum_osnivanja, OLD.mesto_osnivanja, OLD.email);
		INSERT INTO users(username, password, role) VALUES (OLD.skracenica, OLD.PASSWORD,"ROLE_PREDUZECE");
			END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `proizvodi`
--

CREATE TABLE `proizvodi` (
  `id` bigint(20) NOT NULL,
  `preduzece_id` bigint(20) DEFAULT NULL,
  `naziv` varchar(45) DEFAULT NULL,
  `info` varchar(1500) DEFAULT NULL,
  `cena` decimal(13,2) DEFAULT NULL,
  `kolicina` int(11) DEFAULT NULL,
  `slika_url` varchar(10000) DEFAULT 'assets\\images\\logo.png',
  `kategorija` varchar(45) DEFAULT NULL,
  `dani` int(11) DEFAULT NULL,
  `ocena` decimal(2,1) DEFAULT '0.0',
  `br_ocena` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proizvodi`
--

INSERT INTO `proizvodi` (`id`, `preduzece_id`, `naziv`, `info`, `cena`, `kolicina`, `slika_url`, `kategorija`, `dani`, `ocena`, `br_ocena`) VALUES
(1, 1, 'Beli luk bosut 25g', 'Jesenja sorta.\nLukovice kompaktne, bele boje, težine oko 60 g.\nČenovi ujednačeni, težine iznad 5 g.\nVisok sadržaj suve materije do 35%.', '300.00', 293, 'https://nsseme.com/wp-content/uploads/2019/04/bosut-400x274.jpg', 'sadnica', 200, '4.7', 3),
(2, 1, 'Beli luk bosut dzak', 'Jesenja sorta.\nLukovice kompaktne, bele boje, težine oko 60 g.\nČenovi ujednačeni, težine iznad 5 g.\nVisok sadržaj suve materije do 35%', '15000.00', 10, 'https://nsseme.com/wp-content/uploads/2019/04/bosut-400x274.jpg', 'sadnica', 200, '3.5', 2),
(3, 1, 'Crni luk holandski 25g', 'Lukovica je pljosnato-okrugla, mase 80-120 g.\nSuvi ovojni listovi su čvrsti i dobro obavijaju lukovicu, slamastožute boje.\nTo je poluljuta sorta sa 12% suve materije.\nGaji se iz arpadžika, koji je okruglog oblika.', '250.00', 84, 'https://nsseme.com/wp-content/uploads/2019/03/crni-luk-holandski-zuti-600x449.jpg', 'sadnica', 180, '3.5', 2),
(4, 1, 'Crni luk holandski dzak', 'Lukovica je pljosnato-okrugla, mase 80-120 g.\nSuvi ovojni listovi su čvrsti i dobro obavijaju lukovicu, slamastožute boje.\nTo je poluljuta sorta sa 12% suve materije.\nGaji se iz arpadžika, koji je okruglog oblika.', '14400.00', 696, 'https://nsseme.com/wp-content/uploads/2019/03/crni-luk-holandski-zuti-600x449.jpg', 'sadnica', 180, '4.5', 2),
(5, 1, 'Crni luk Elenka dzak', 'Novi, izuzetno prinosan hibrid (preko 90 t/ha) namenjen za najduži lager - čuvanje i do 10 meseci nakon vađenja, sa atraktivnim lukovicama sjajne tamno-bronzane boje. Biljka je brzog i snažnog porasta, tolerantna na plamenjaču. \nKultura: \nLuk\nPakovanje: \n100 000 s\nNamena: \nProfesionalna\nF1/sorta: \nF1', '14400.00', 560, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/209-elenka.jpg?itok=tITWHjuy', 'sadnica', 170, '0.0', 0),
(10, 1, 'Luk Fiamma dzak', 'Vrlo prinosan hibrid sa najatraktivnijom, sjajnom ljubičastom bojom, ujednačenih krupnih i okruglih lukovica, sa nekoliko čvrstih ovojnih listova od kojih svaki ima visoki sjaj bez obzira na vreme i način čišćenja. Ovaj hibrid luka, za razliku od sličnih, nema problema sa mašinskim vađenjem, zato što su glavice veoma čvrste i otporne na mehanička habanja\nKultura: \nLuk\nPakovanje: \n100 000 s\nNamena: \nProfesionalna\nF1/sorta: \nF1', '14400.00', 654, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/215-fiamma.jpg?itok=SPovuGp5', 'sadnica', 180, '3.5', 2),
(11, 1, 'Srebrenjak Kosma ', 'Prezimljavajući luk u tipu srebrenjaka. Koristi se za mladi luk ili kad sazre za svežu potrošnju. Lukovice su slatke, hrskave, veoma ukusne. Setva može biti krajem avgusta ili u rano proleće.\n\nKultura: \nLuk\nPakovanje: \n100 g\nNamena: \nProfesionalna\nF1/sorta: \nF1\nIzvor: \nUvozni', '1612.00', 7600, 'http://www.agromaxshop.rs/sites/default/files/styles/product-zoom/public/images/products/1-014-0359-kosma.jpg?itok=4QfeezM5', 'sadnica', 180, '4.0', 2),
(12, 1, 'Praziluk Lancelot', 'Ovaj plavo-zeleni tip praziluka namenjen je kasnoj letnjoj i jesenjoj proizvodnji. Vrlo je rodan. Ima lepe, dugačke stabljike, bez okruglih zadebljanja. Formira mnogo tamno zelenog lišća. Dobro podnosi napad virusa. U povoljnim uslovima proizvodnje ova je sorta dala prinos od 56 t/ha. 90 dana vegetacije.\n\nKultura: \nPraziluk\nPakovanje: \n10 000 s\nNamena: \nProfesionalna\nF1/sorta: \nF1\nIzvor: \nUvozni', '3720.00', 858, 'assets\\images\\praziluk.jpg', 'sadnica', 190, '4.0', 2),
(13, 1, 'Praziluk Lincoln ', 'Ova je sorta u tipu dugačkih bugarskih praziluka za letnju proizvodnju. Formira vrlo duge, bele, čvrste, izdužene lukovice, bez okruglastog zadebljanja. Uspravnog je i vrlo visokog rasta. Vrlo rana sorta, s visokim prinosom. 75 dana vegetacije.\n\nKultura: \nPraziluk\nPakovanje: \n10 000 s\nNamena: \nProfesionalna\nF1/sorta: \nF1\nIzvor: \nUvozni', '3720.00', 840, 'assets\\images\\praziluk.jpg', 'sadnica', 210, '4.0', 2),
(28, 2, 'Puterica Baglin ', 'Zimska puterica najotpornija na hladnoću. Proizvodnja od jeseni do ranog proleća. Preporučuje se proizvodnju u plastenicima i staklenicima. Svetlo zelena boja listova. Brzo rastuća sorta. Vrlo fleksibilna na različite sklopove sadnje. Tolerantna na promene temperature.\nVisoka otpornost (HR) = Plamenjača Bl 1-25, 27.\n\n*Zatvorena proizvodnja\n*Težina glave: 0,4-3 kg\nKultura: \nSalata\nPakovanje: \n5000 s\nNamena: \nProfesionalna\nF1/sorta: \nSorta', '3600.00', 500, 'http://www.agromaxshop.rs/sites/default/files/styles/product_thumb/public/images/products/1-014-0285-baglin.jpg?itok=8NdiKlUF', 'sadnica', 150, '0.0', 0),
(29, 2, 'Puterica Daguan F2', 'Puterica za letnju proizvodnju od proleća do jeseni na otvorenom polju. Formira vrlo krupne glavice prosečne mase 550-600 g. Listovi svetlo zelene boje. Otporna na prorastanje tokom leta. Otporna na vršnu trulež listova (nedostatak Ca). Srednje rana sorta, vrlo robusna, lagana i sigurna za proizvodnju. Ne traži previše intenzivnu proizvodnju. \n*Otvorena proizvodnja\n*Težina glave: 0,5-0,6 kg\nKultura: \nSalata\nPakovanje: \n5000 s\nNamena: \nProfesionalna\nF1/sorta: \nSorta', '3600.00', 900, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/1-014-0281-daguan.jpg?itok=WdH6urSw', 'sadnica', 150, '0.0', 0),
(30, 2, 'Puterica Julian  F3', 'Puterica za leto. Preporučujemo za proizvodnju na otvorenom polju tokom leta zbog izrazito visoke otpornosti na prorastanje. Glavice su kompaktne i dobro zbijene. Listovi su uspravnog položaja svetlo zelene boje. Unutrašnja boja listova je svetložuta. Dobro se drži nakon dozrevanja u polju i kasnije na pultu nakon berbe.\nVisoka otpornost (HR) = Plamenjača Bl 16-24, 27-28, 30-32 /NR: 0. Srednja otpornost (IR) = Virus mozaika salate LMV1.\n\n*Otvorena proizvodnja\n*Težina glave: 0,5-0,6 kg\nKultura: \nSalata\nPakovanje: \n5000 s\nNamena: \nProfesionalna\nF1/sorta: \nSorta', '3600.00', 700, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/171-tizian.jpg?itok=AjArl-o2', 'sadnica', 155, '0.0', 0),
(31, 2, 'Puterica Mafalda ', 'Kultura: \nSalata\nPakovanje: \n10 000 s\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nUvozni', '6944.00', 600, 'http://www.agromaxshop.rs/sites/default/files/styles/product_thumb/public/images/products/187-mafalda.jpg?itok=csBmrDSu', 'sadnica', 145, '0.0', 0),
(32, 2, 'Puterica Majska kraljica ', 'Kultura: \nSalata\nPakovanje: \n25 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nDomaći', '125.00', 1500, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/1-014-1110-majskakraljica_0.jpg?itok=YeqiWoWM', 'sadnica', 160, '0.0', 0),
(33, 2, 'Rukola Celebris FFF', 'U pitanju je nova Corina selekcija rukole, namenjena pre svega za zimski ciklus proizvodnje. Odlikuju je brzi porast, čvrsti i uspravni listovi i dobra tolerancija na niže temperature u hladnijim periodima godine. Tamno zeleni listovi su takođe veoma kovrdžavi već kod prvog branja.\n\nKultura: \nRukola\nPakovanje: \n500 g\nNamena: \nProfesionalna\nF1/sorta: \nF1\nIzvor: \nUvozni', '823.00', 5000, 'http://www.agromaxshop.rs/sites/default/files/styles/product_thumb/public/images/products/196-celebris.jpg?itok=GSv4Or85', 'sadnica', 160, '0.0', 0),
(34, 2, 'Rukola Corastar FRF', 'Standardna sorta rukole koja se radi u svim proizvodnim regijama i zastupljena je kod svih većih proizvođača rukole i drugog Baby leaf programa. CORASTAR se odlikuje, po veličini i obliku, ujednačenim listovima tamno zelene boje i veoma kovrdžavim već kod prvog branja. Pogodnaje ca celogodišnju proizvodnju.\n\nKultura: \nRukola\nPakovanje: \n50 g\nNamena: \nProfesionalna\nF1/sorta: \nF1\nIzvor: \nUvozni', '780.00', 0, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/194-corastar.jpg?itok=9hFw_6fC', 'sadnica', 165, '0.0', 0),
(51, 3, 'Anis 10g', 'Anis je jednogodišnja zeljasta biljka. Lekoviti deo biljke su plod i zrelo seme. Seme anisa rešava nadimanje, jača probavne organe i pospešuje varenje. Čisti krv i sluz iz pluća, želuca, bubrega i jača nervni sistem. Efikasan je sekretolik, spazmolitik, ekspetorans i karminativ. Upotrebljava se u konditorskoj industriji, kozmetičkoj industriji i proizvodnji likera. Seme sadrži eterično ulje (1,5-4,0%), masna ulja (10%), proteine (20%) i uglenje hidrate. Dominantna komponenta eteričnog ulja je trans-anetol (85-90%).\n\nSeje se u proleće na stalnom mestu.\n\nKultura: \nZačin\nPakovanje: \n10 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta', '105.00', 500, 'data:image/jpeg;base64,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', 'sadnica', 160, '0.0', 0),
(52, 3, 'Bosiljak 10', 'Bosiljak je jednogodišnja biljka jakog prijatnog mirisa, visine 30 cm sa razgranatom stabljikom. U tradicionalnoj medicini koristi kao jak antioksidant i protiv svih upalnih procesa. Rešava problem kašlja, bubrežnih bolesti, glavobolje, depresije i kardiovaskularnih bolesti. U kulinarstvu, pored prijatnog aromatičnog svojstva deluje kao antiseptični sastojak koji uništava štetne bakterije u hrani. Koristi se sušen i u svežem stanju. Listovi bosiljka koriste se kako u svežem tako i suvom stanju u industrijske svrhe koristi se etrično ulje.\n\nKultura: \nZačin\nPakovanje: \n10 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta', '105.00', 6000, 'assets\\images\\logo.png', 'sadnica', 100, '0.0', 0),
(53, 3, 'Kamilica 5g', 'Kamilica je jedna od najpoznatijih lekovitih biljaka na našim prostorima i prisutna je u svakom domaćinstvu. Glavna lekovitost ove biljke ogleda se u lečenju želudačno crevnih bolesti. Spoljnom upotrebom reguliše se upala kože i sluzokože, prave se različite kupke jer poseduje dobro antibakterijsko, virusno i fungicidno dejtsvo. Eterična ulja kamilice koriste se u farmaceutskoj industriji i za izradu kozmetičkih proizvoda. Seje se u proleće na stalnom mestu.\n\nKultura: \nZačin\nPakovanje: \n5 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nUvozni', '175.00', 6000, 'assets\\images\\logo.png', 'sadnica', 110, '0.0', 0),
(54, 3, 'Korijander  10g', 'Korijander je biljka koja potiče iz Južne Evrope i sa Srednjeg istoka. Veoma lekovita biljka koja čisti organizam od toksina i teških metala, koristi se kao lek protiv anemije, jer sadrži gvožđe koje se lekao usvaja, smanjuje holesterol i šećer. Koristi se u kulinarstvu zbog svoje veoma prijatne arome, u supama i varivima od povrća. Veoma pozitivno utiče na lečenje anemije, na smanjenje holesterola i šećera, upalnih procesa i kožnih bolesti kao i za lečenje reume. Seje se tokom proleća i leta na otvorenom polju i u saksijama.\n\nKultura: \nZačin\nPakovanje: \n10 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nUvozni', '83.00', 6000, 'assets\\images\\logo.png', 'sadnica', 115, '0.0', 0),
(55, 3, 'Lavanda 5 g', 'Lavanda je višegodišnja mediteranska biljka. Zbog svog prijatnog mirisa koristi se u farmaceutskoj i kozmetičkoj industriji, a gaji se i kao dekorativna biljka u dvorištima. Koristi se kao antiseptik i antispazmatik i kao sredstvo protiv raznih infekcija grla i ždrela. Lavanda veoma dobro uspeva i u kontinentalnim krajevima i na nadmorskim visinama preko 1000 m. Dobro podnosi i niske temperature, do -20C. Lavanda je višegodišnja polugrmolika biljka visine od 50-70 cm. Seje se od proleća direktnom setvom na otvorenom ili u saksijama.\n\nKultura: \nZačin\nPakovanje: \n5 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nUvozni', '170.00', 6000, 'assets\\images\\logo.png', 'sadnica', 105, '0.0', 0),
(56, 3, 'Majčina dušica 5 g', 'Lekovito dejstvo majčine dušice je veoma cenjeno u narodnoj medicini, a njena primena je takođe značajna i u farmaceutskoj industriji. Koristi se za ublažavanje kašlja, lečenje želudačnih smetnjih, bolesti pluća, organa za disanje, malokrvnosti i bolesti bubrega. Zbog izraženog antiseptičkog, antibaketrijskog i dezinfekcionog delovanja koristi se za spravljanje mnogih farmaceutskih medikamenta. Najvažniji sastojak ove lekovite biljke je eterično ulje smeđe crvene boje, aromatičnog blago ljutog ukusa. Eterično ulje sadrži do 55% timola, borneola, linalola i fenolna jedinjena.\n\nSeje se tokom proleća i leta na otvorenom i u saksijama.\n\nKultura: \nZačin\nPakovanje: \n5 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nUvozni', '105.00', 6000, 'assets\\images\\logo.png', 'sadnica', 110, '0.0', 0),
(57, 3, 'Mirođija 10 g', 'Začinska aromatična biljka prijatnog mirisa. Blagotvorno deluje protiv stomačnih tegoba, nadimanja i pomaže pri varenju hrane. Koristi se kao začinska biljka u kulinarstvu gde njenom upotrebom hrana dobija prijatan i aromatična ukus. Semenke mirođije sadrže vitamine, minerale i eterična ulja koja povoljno deluju na zdravlje. Najveća koncentracija lekovitih i aromatičnih materija nalazi se u plodovima biljke, ali ima ih i u listovima i cvetovima. Pored primene u kulinarstuv eterično ulje se koristi u farmaciji. Seje se tokom proleća i leta.\n\nKultura: \nZačin\nPakovanje: \n10 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nUvozni', '83.00', 6000, 'assets\\images\\logo.png', 'sadnica', 100, '0.0', 0),
(58, 3, 'Origano 5 g', 'Origano je višegodišnja zeljasta biljka sa veoma izraženim lekovitim dejstvom. Blagotvorno deluje na unutrašnje organe: jetru, slezinu, bubrege, bešiku i pluća. Takođe se koristi za lečenje organa za varenje i disanje, kao i protiv upale kože i sluzokože. U kulinarstvu je veoma zastupljena kao začinska biljka široke primene. Sadrži eterično ulje (timol, cimol, karvakrol...), flavonoide, tanine, askorbinsku kiselinu. Sadrži gvožđe, molibden i selen. Seje se tokom proleća i leta direktno u zemljište i u saksijama.\n\nKultura: \nZačin\nPakovanje: \n5 g\nNamena: \nProfesionalna\nF1/sorta: \nSorta\nIzvor: \nUvozni', '170.00', 6000, 'assets\\images\\logo.png', 'sadnica', 120, '0.0', 0),
(64, 7, 'Calcinit 2 kg', 'YaraLiva Calcinit – kalcijum nitrat – 100% vodotopivo đubrivo\n\nCalcinit je đubrivo u obliku belih kristalnih granula, rastvorljivo je u vodi bez ostataka i namenjeno je za prevenciju i otklanjanje simptoma nedostatka kalcijuma. Calcinit je glavni izvor kalcijuma za sve useve koji su osetljivi na nedostatak kalcijuma (povrće, voće, cveće…). Azot i kalcijum su lako pristupačni i odmah dostupni biljci. Amonijum nitrat pomaže u stabilizaciji pH vrednosti prilikom ishrane kod hidroponskog načina proizvodnje. Upotrebom YaraLiva Calcinit sprečavate pojavu gorkih pega kod jabuke, suve truleži vrha ploda kod paprike, rubne paleži lista salate i kupusnjača.\n\nKultura: \nĐubrivo\nPakovanje: \n2 kg\nIzvor: \nUvozni', '210.50', 1298, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/calcinit2.jpg?itok=O3Jbv_s_', 'preparat', 10, '0.0', 0),
(65, 7, 'Cropcare 11-11-21 ', 'Veoma kvalitetno osnovno, startno đurivo ali i đubrivo za prihranu. Sa podjednakim uspehom se primenjuje u proizvodnji na otvorenom polju i u zaštićenom prostoru (plastenici, staklenici). Preporučuje se za korišćenje kod svih intenzivnih kultura (povrće, voće, vinova loza, cveće, ukrasne biljke). Zbog svog idealnog sastava pogodno je i za upotrebu u rasadničkoj proizvodnji. Maksimalni rezultati se postižu kod povrtarske kulture koje se navodnjavaju tokom vegetacije, u intenzivnom voćarstvu i vinogradarstvu, profesionalnom cvećarstvu. Idealno za sve tipove travnjaka i sportskih terena. Pogodno za dodavanje zemljišnim smešama i supstratima namenjenim za proizvodnju ukrasnog, balkonskog i saksijsko cveće.\n\nPRIMENA: Koristi se kao osnovno i startno đubrivo za voće, povrće, grožđe, cveće i travnjake u količini od 300 do 500 kg/ha, kao i za prihrane (2 do 3 puta) u količini od 100 do 300 kg/ha.\n\nKultura: \nĐubrivo\nPakovanje: \n5 kg\nIzvor: \nUvozni', '635.40', 1299, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/cropcare_11-11-21.jpg?itok=crRe0QlT', 'preparat', 15, '4.0', 1),
(66, 7, 'Ferticare I 10g', 'Pogodan za ishranu svih vrsta biljaka tokom cele vegetacije zbog idealnog odnosa NPK elemenata. Značajno ubrzava cvetanje i poboljšava zametanje plodova. Idealan je za folijarnu prihranu svih ratarskih, povrtarskih, voćarskih kultura, vinove loze, cveća i ukrasnog bilja.\n\nKultura: \nĐubrivo\nPakovanje: \n10 g\nNamena: \nProfesionalna/Hobi\nIzvor: \nUvozni', '575.00', 2300, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferticare1_14-11-25.jpg?itok=EwberyRJ', 'preparat', 25, '0.0', 0),
(67, 7, 'Ferticare II 24-8-16 ', 'FERTICARE II 24-8-16 – bogat azotom, za rast i razvoj vegetativnih organa\n\nMineralno đubrivo sa visokim sadržajem azota. Upotrebljava se nakon ukorenjavanja, tokom intenzivnog porasta i razvoja svih intenzivnih kultura. Odlično đubrivo za korekciju ishrane useva koji zaostaju u porastu i imaju slabiju bujnost i vegetativnost. Preporučuje se i za folijarne tretmane za povrtarske, voćarske i ratarske kulture tokom intenzivnog porasta.\n\nKultura: \nĐubrivo\nPakovanje: \n2 kg\nNamena: \nProfesionalna/Hobi\nIzvor: \nUvozni', '460.00', 1300, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferticare_ii_24-8-16-2kg.jpg?itok=PQmGl8pv', 'preparat', 2, '0.0', 0),
(68, 7, 'Ferticare III 10-5-26 ', 'FERTICARE III 10-5-26 – posle cvetanja, za plodonošenje\n\nMineralno đubrivo sa višim sadržajem kalijuma i idealnim odnosom hraniva za period plodonošenja. Preporučuje se kod kultura koje zahtevaju veću količinu kalijuma u drugom periodu vegetacije. Obezbeđuje lepšu boju plodovima, poboljšava kvalitet i mogućnost dugotrajnijeg skladištenja.\n\nKultura: \nĐubrivo\nPakovanje: \n2 kg\nNamena: \nProfesionalna/Hobi\nIzvor: \nUvozni', '437.00', 1300, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferticare_iii_10-5-26.jpg?itok=y64oFtFe', 'preparat', 2, '0.0', 0),
(69, 7, 'FitoFert Kristal 4:10:40', 'FitoFert za brzo sazrevanje plodova\n\nFitoFert Kristal 4:10:40+3MgO+ME namenjen je za brzo sazrevanje plodova (voća, povrća, i ratarskih kultura), kvalitetnu pigmentaciju plodova i sadržaj suve materije u plodovima. Prisutni fosfor ubrzava zrenje, dok visok sadržaj kalijuma garantuje kvalitetnu pigmentaciju i visok sadržaj šećera u plodu. Broj tretiranja 1 – 3 puta, neposredno pred berbu i u toku berbe. Kompatibilan je sa većinom preparata za zaštitu bilja, osim alkalnih bakarnih preparata.\n\nPrimena:\n\nfolijarno konc. 0,3% -0,8%\nfertigac. konc. 0.08-0.1%.\n\nKultura: \nĐubrivo\nPakovanje: \n2 kg\nNamena: \nProfesionalna/Hobi', '565.00', 1200, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/4-10-40.jpg?itok=0LlG3jlK', 'preparat', 5, '0.0', 0),
(70, 7, 'Fitofert Ferro Max 11', 'FitoFert FERRO MAX 11 je đubrivo na bazi helata gvožđa u obliku DTPA kompleksa. Predstavlja visoko koncentrovani izvor gvožđa, stabilnog u opsegu pH 3-8. Zbog svoje lake rastvorljivosti pogodno je za sve oblike primene, folijarnim ili fertigacionim putem. Fertigaciono se primenjuje u svim biljnim kulturama gde je moguće kontrolisati pH zalivnih voda i gde pH zemljišta ne prelazi 7,5. Kompatibilan je sa svim kiselim đubrivima i sredstvima za zaštitu bilja, osim sa alkalnim, bakarnim preparatima.\n\nPrimena:\n\nfolijarno konc. 0.2% – 0.3%\nfertigaciono 10 do 20 kg/ha\n\nKultura: \nĐubrivo\nPakovanje: \n200 g\nNamena: \nProfesionalna/Hobi', '500.00', 1500, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/ferro-max-11.jpg?itok=D-ZoGYFC', 'preparat', 5, '0.0', 0),
(71, 7, 'Fitofert Combivit ', '\nFITOFERT COMBIVIT 20 je proizvod na bazi mikroelemenata, namenjen za folijarni tretman ratarskih, povrtarskih i voćarskih useva. Univerzalni helatni AFP kompleks jako visokog sadržaja mikroelemenata. Preporučuju se preventivni tretmani na usevima osetljivim na nedostatke mikroelemenata ili na zemljištima na kojima postoji deficit mikroelemenata, visok sadržaj organske materije, karbonata, fosfata I pH>6,5. Preporučuje se primena početkom vegetacije jer niska temperatura tla onemogućuje pravilan rad korena i lučenje materija koje utiču na usvajanje mikroelemenata. U zasadima voća preporučuje se i tretman nakon berbe.\n\nPrimenjuje se folijarno u količini od 1kg/ha.\n\nKultura: \nĐubrivo\nPakovanje: \n1 kg\nNamena: \nProfesionalna/Hobi', '1260.00', 700, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/combivit20.jpg?itok=qg39AhB1', 'preparat', 2, '0.0', 0),
(72, 7, 'Fitofert Humisuper plus', 'Za intenzivan rast\n\nFITOFERT HUMISUPER PLUS 8:4:8 je đubrivo u obliku koncentrovane suspenzije, koje pored organski aktivnih komponenata sadrži huminske i fulvinske kiseline, kao i ugljenehidrate, betaine i lignosulfonate. U odnosu na stariju verziju ovog preparata (HUMISUPER 10:5:10), HUMISUPER PLUS sadrži povećan broj mikroelemenata a smanjen sadržaj NPK elemenata, što rezultira boljom rastvorljivošću proizvoda na niskim temperaturama. Organske materije prirodnog porekla stimulišu niz pozitivnih biohemijskih procesa u ćelijama biljaka, pojačavaju asimilaciju hraniva i čine useve vitalnijim i otpornijim na stres i bolesti. Sprovedeni ogledi potvrdili su izuzetnu efikasnost ovog preparata, kontrolu stresa i uvećanje prinosa.\n\nPrimena: Primenjuje se folijarno u kombinaciji sa različitim sredstvima za ishranu biljaka. Doze primene po tretmanu se kreću od 3- 5 litara/ha.\n\nKultura: \nĐubrivo\nPakovanje: \n1 l\nNamena: \nProfesionalna\nIzvor: \nDomaći', '436.00', 700, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/fitofert-humisuper-plus-qudal.jpg?itok=2KivRkQF', 'preparat', 7, '0.0', 0),
(73, 7, 'Fitofert CINK Org', 'ZA ENZIMSKE FUNKCIJE\n\nFitoFert CINK ORGANO 14 je mikroelementarno đubrivo na bazi ЕDTA helatnog kompleksa. Nedostatak cinka se uglavnom manifestuje nekrozom na mlađem i starijem lišću. U slučajevima nedostatka ćelije biljke za enzimske molekule vezuju druge metalne komponente, koje često mogu biti fitotoksične.  Preparat se koristi preventivno ali se može primeniti i po pojavi simptoma nedostatka.\n\nPrimena:\n\nfolijarno konc. 0.2% – 0.3%\n\nfertigaciono 10 do 20 kg/ha\n\nKultura: \nĐubrivo\nPakovanje: \n1 kg\nIzvor: \nDomaći', '1260.00', 900, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/cinkorgano14.jpg?itok=bGw7s3cV', 'preparat', 15, '0.0', 0),
(74, 7, 'Fitofert Calcium Org', '\nZA ČVRSTINU PLODOVA\n\nFitofert CALCIUM ORGANO 30 je preparat u obliku vodotopivih kristala, sa maksimalnih 30% cao. Namenjen je za folijarni tretman useva. Kalcijum je u potpunosti helatiziran i lako transportabilan kroz list do plodova a iskorišćenje je potpuno. Ono što ga u potpunosti izdvaja od drugih preparata na bazi kalcijuma je potpuno odsustvo nitrata i hlorida.Takođe fertigacionom primenom kalcijum nitrata dolazi do blokiranja kalijuma i fosfata u zemljištu što je još jedan od negativnih efekata. U slučaju tretiranja sa kalcijum hloridom dolazi do fitotoksičnih reakcija.\n\nPrimena:\n\nfolijarno konc. 0,3% -0,6%\n\nKultura: \nĐubrivo\nPakovanje: \n1 kg\nNamena: \nProfesionalna/Hobi', '610.00', 1000, 'http://www.agromaxshop.rs/sites/default/files/styles/product-zoom/public/images/products/calcium-organo-30.jpg?itok=1eVD0o_H', 'preparat', 10, '0.0', 0),
(75, 7, 'Fitofert Bor Max ', 'ZA OPLODNJU I DIGESTIJU\n\nFitoFert BOR MAX 20 je đubrivo u obliku vodotopivog praha namenjeno za folijarni tretman useva sa povećanom asimilacijom bora, ili na borom siromašnim zemljištima. Sadrži visoku koncentraciju bora od 20%, u obliku lako pristupačnog boratnog anjona. Njegov nedostatak može da prouzrokuje mnogobrojne anomalije na usevima koje se ogledaju u vidu smanjene oplodnosti, truljenja korena korenastih useva, neujednačenih plodova i slabe asimilacije šećera. FitoFert BOR MAX 20 se najčešće primenjuje u usevima šećerne repe, soje, suncokreta, vinove loze, voća (jabuka, višnja) i kupusastog povrća (brokoli, kelj, karfiol).\n\nPrimena:\n\nfolijarno konc. 0,1% – 0,5%\n\nKultura: \nĐubrivo\nPakovanje: \n1 kg\nNamena: \nProfesionalna/Hobi', '650.00', 900, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/bormax-20.jpg?itok=1zQZyy3f', 'preparat', 10, '0.0', 0),
(76, 7, 'SUBSTRAL mineralno tečno', 'Tekuće mineralno đubrivo za sve vrste balkonskih biljaka, takođe i drugih biljaka u saksijama i žardinjerama. Specijalan sastav prilagođen potrebama biljaka sa Substral Aktivom omogućuje zdrav rast, razvoj lepih zelenih listova kao i bujno cvetanje. Kod redovne upotrebe đubriva možete očekivati bujno cvetanje tokom celog leta sve do kasne jeseni.', '435.00', 1400, 'http://www.agromaxshop.rs/sites/default/files/styles/product/public/images/products/45137771_638153833248906_804993080200527872_n.jpg?itok=-jG9v1a3', 'preparat', 7, '0.0', 0),
(78, 1, 'Cvekla special', 'Cvekla divne crvene boje, 100 semenki u 25g.', '100.00', 50, 'assets\\images\\logo.png', 'sadnica', 110, '0.0', 0),
(83, 1, 'Sargarepa', 'Saragarepa, pakovanje od 1000 semenki.', '5000.00', 50, 'assets\\images\\logo.png', 'sadnica', 120, '0.0', 0),
(84, 1, 'Paprika', 'Paprika silja crvena, pakovanje od 5000 semenki.', '10000.00', 34, 'assets\\images\\logo.png', 'sadnica', 150, '0.0', 0);

-- --------------------------------------------------------

--
-- Table structure for table `proizvod_porudzbina`
--

CREATE TABLE `proizvod_porudzbina` (
  `porudzbina_id` bigint(20) NOT NULL,
  `proizvod_id` bigint(20) NOT NULL,
  `kolicina` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `proizvod_porudzbina`
--

INSERT INTO `proizvod_porudzbina` (`porudzbina_id`, `proizvod_id`, `kolicina`) VALUES
(2, 2, 10),
(2, 3, 10),
(26, 1, 2),
(26, 3, 2),
(27, 28, 2),
(50, 31, 1),
(50, 32, 3),
(51, 51, 1),
(51, 57, 1),
(52, 12, 1),
(53, 28, 3),
(54, 52, 100),
(55, 70, 1),
(55, 71, 2),
(58, 28, 1),
(65, 51, 2),
(68, 3, 1),
(72, 4, 1),
(74, 1, 1),
(74, 10, 1),
(74, 12, 1),
(75, 64, 2),
(76, 65, 1);

--
-- Triggers `proizvod_porudzbina`
--
DELIMITER $$
CREATE TRIGGER `proizvod_porudzbina_AFTER_INSERT` AFTER INSERT ON `proizvod_porudzbina` FOR EACH ROW BEGIN
UPDATE porudzbine SET cena = cena + NEW.kolicina*(
    SELECT cena FROM proizvodi p where p.id = NEW.proizvod_id ) WHERE id =NEW.porudzbina_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rasadnici`
--

CREATE TABLE `rasadnici` (
  `id` bigint(20) NOT NULL,
  `poljoprivrednik_id` bigint(20) DEFAULT NULL,
  `naziv` varchar(45) DEFAULT NULL,
  `mesto` varchar(45) DEFAULT NULL,
  `kapacitet` int(11) DEFAULT NULL,
  `br_sadnica` int(11) DEFAULT '0',
  `br_slobodnih` int(11) DEFAULT NULL,
  `voda` int(11) DEFAULT '200',
  `temperatura` double DEFAULT '18',
  `duzina` int(11) DEFAULT NULL,
  `sirina` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rasadnici`
--

INSERT INTO `rasadnici` (`id`, `poljoprivrednik_id`, `naziv`, `mesto`, `kapacitet`, `br_sadnica`, `br_slobodnih`, `voda`, `temperatura`, `duzina`, `sirina`) VALUES
(1, 1, 'R1_1', 'Rogacica', 100, 18, 82, 183, 14, 10, 10),
(2, 1, 'R1_2', 'Baranda', 90, 17, 73, 190, 13, 9, 10),
(29, 2, 'R2_1', 'Lunovo selo', 100, 0, 100, 184, 16, 10, 10),
(36, 2, 'R2_3', 'Dragoslava Srejovica 76 Beograd', 100, 0, 100, 184, 16, 10, 10);

--
-- Triggers `rasadnici`
--
DELIMITER $$
CREATE TRIGGER `rasadnici_AFTER_INSERT` AFTER INSERT ON `rasadnici` FOR EACH ROW BEGIN
 INSERT INTO magacini SET rasadnik_id = NEW.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sadnice`
--

CREATE TABLE `sadnice` (
  `id` bigint(20) NOT NULL,
  `rasadnik_id` bigint(20) DEFAULT NULL,
  `naziv` varchar(45) DEFAULT NULL,
  `progres` double(4,3) DEFAULT '0.000',
  `vek` int(11) DEFAULT NULL,
  `br_polja` int(11) DEFAULT NULL,
  `uklonjena` bit(1) DEFAULT b'0',
  `proizvodjac` varchar(45) DEFAULT NULL,
  `cnt` int(11) DEFAULT '1440'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sadnice`
--

INSERT INTO `sadnice` (`id`, `rasadnik_id`, `naziv`, `progres`, `vek`, `br_polja`, `uklonjena`, `proizvodjac`, `cnt`) VALUES
(72, 1, 'Beli luk bosut 100 000s', 0.820, 200, 2, b'0', 'LukovicaPro', 1440),
(76, 1, 'Kamilica 5g', 1.000, 110, 18, b'0', 'Herbis', 1440),
(78, 1, 'Anis 10g', 0.822, 160, 20, b'0', 'Herbis', 1440),
(79, 1, 'Praziluk Lancelot F1 10 000s', 0.685, 190, 5, b'0', 'LukovicaPro', 1440),
(81, 1, 'Beli luk bosut 100 000s', 0.790, 200, 12, b'0', 'LukovicaPro', 1440),
(82, 1, 'Luk Fiamma F1 100 000s', 0.881, 180, 11, b'0', 'LukovicaPro', 1440),
(84, 1, 'Luk Fiamma F1 100 000s', 0.798, 180, 14, b'0', 'LukovicaPro', 1440),
(85, 2, 'Crni luk holandski zuti 25g', 0.798, 180, 1, b'0', 'LukovicaPro', 1440),
(86, 2, 'Crni luk holandski zuti 100 000s', 0.854, 180, 2, b'0', 'LukovicaPro', 1440),
(87, 2, 'Puterica Majska kraljica 25 g', 0.798, 160, 3, b'0', 'Libis', 1440),
(88, 2, 'Crni luk holandski zuti 100 000s', 0.798, 180, 4, b'0', 'LukovicaPro', 1440),
(89, 1, 'Puterica Julian  5000s', 0.774, 155, 3, b'0', 'Libis', 1440),
(90, 1, 'Beli luk bosut 100 000s', 0.620, 200, 21, b'0', 'LukovicaPro', 1440),
(91, 1, 'Luk Fiamma F1 100 000s', 0.744, 180, 22, b'0', 'LukovicaPro', 1440),
(92, 1, 'Puterica Baglin 5000s', 0.868, 150, 31, b'0', 'Libis', 1440),
(94, 1, 'Beli luk bosut 100 000s', 0.595, 200, 33, b'0', 'LukovicaPro', 1440),
(95, 1, 'Beli luk bosut 25g', 0.590, 200, 34, b'0', 'LukovicaPro', 1440),
(96, 1, 'Beli luk bosut 100 000s', 0.590, 200, 35, b'0', 'LukovicaPro', 1440),
(97, 1, 'Beli luk bosut 25g', 0.590, 200, 36, b'0', 'LukovicaPro', 1440),
(98, 1, 'Beli luk bosut 25g', 0.590, 200, 41, b'0', 'LukovicaPro', 1440),
(99, 1, 'Beli luk bosut 25g', 0.590, 200, 42, b'0', 'LukovicaPro', 1440),
(100, 1, 'Beli luk bosut 25g', 0.590, 200, 43, b'0', 'LukovicaPro', 1440),
(101, 2, 'Beli luk bosut 25g', 0.000, 200, 11, b'0', 'LukovicaPro', 1440),
(102, 2, 'Beli luk bosut 25g', 0.000, 200, 12, b'0', 'LukovicaPro', 1440),
(103, 2, 'Beli luk bosut 25g', 0.000, 200, 13, b'0', 'LukovicaPro', 1440),
(104, 2, 'Beli luk bosut dzak', 0.000, 200, 21, b'0', 'LukovicaPro', 1440),
(105, 2, 'Beli luk bosut dzak', 0.000, 200, 22, b'0', 'LukovicaPro', 1440),
(106, 2, 'Beli luk bosut dzak', 0.000, 200, 23, b'0', 'LukovicaPro', 1440),
(107, 2, 'Beli luk bosut dzak', 0.000, 200, 24, b'0', 'LukovicaPro', 1440),
(108, 2, 'Beli luk bosut dzak', 0.000, 200, 25, b'0', 'LukovicaPro', 1440),
(109, 2, 'Beli luk bosut dzak', 0.000, 200, 26, b'0', 'LukovicaPro', 1440),
(110, 2, 'Beli luk bosut dzak', 0.000, 200, 27, b'0', 'LukovicaPro', 1440),
(111, 2, 'Beli luk bosut dzak', 0.000, 200, 28, b'0', 'LukovicaPro', 1440),
(112, 2, 'Beli luk bosut dzak', 0.000, 200, 29, b'0', 'LukovicaPro', 1440),
(113, 2, 'Beli luk bosut dzak', 0.000, 200, 30, b'0', 'LukovicaPro', 1440);

--
-- Triggers `sadnice`
--
DELIMITER $$
CREATE TRIGGER `sadnice_BEFORE_DELETE` BEFORE DELETE ON `sadnice` FOR EACH ROW BEGIN
	update rasadnici set br_sadnica=br_sadnica-1, br_slobodnih=br_slobodnih+1 where id=OLD.rasadnik_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(2, 'aleks123', 'Admin123@', 'ROLE_ADMIN'),
(3, 'milan123', '123', 'ROLE_POLJOPRIVREDNIK'),
(10, 'alka', '111', 'ROLE_PREDUZECE'),
(11, 'libis', 'Preduzece123@', 'ROLE_PREDUZECE'),
(12, 'herbis', '111', 'ROLE_PREDUZECE'),
(16, 'zdravka', '111', 'ROLE_PREDUZECE'),
(90, 'mare123', 'Mare123@', 'ROLE_POLJOPRIVREDNIK');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	IF NEW.role = "ROLE_POLJOPRIVREDNIK" THEN
		UPDATE poljoprivrednici SET user_id = NEW.id WHERE user_id IS NULL;
	END IF;	
	IF NEW.role = "ROLE_PREDUZECE" THEN
		UPDATE preduzeca SET user_id=NEW.id WHERE user_id IS NULL;
	END IF;
	
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `je_dodeljen`
--
ALTER TABLE `je_dodeljen`
  ADD PRIMARY KEY (`kurir_id`,`porudzbina_id`),
  ADD KEY `id_por_idx` (`porudzbina_id`);

--
-- Indexes for table `je_ocenio`
--
ALTER TABLE `je_ocenio`
  ADD PRIMARY KEY (`user_id`,`proizvod_id`),
  ADD KEY `id_proizovd_idx` (`proizvod_id`);

--
-- Indexes for table `kuriri`
--
ALTER TABLE `kuriri`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_preduzecekurir_idx` (`preduzece_id`);

--
-- Indexes for table `magacini`
--
ALTER TABLE `magacini`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rasadnika1_idx` (`rasadnik_id`);

--
-- Indexes for table `magacin_proizvod`
--
ALTER TABLE `magacin_proizvod`
  ADD PRIMARY KEY (`magacin_id`,`proizvod_id`),
  ADD KEY `id_proizvod_idx` (`proizvod_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `poljoprivrednici`
--
ALTER TABLE `poljoprivrednici`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_poljoprivrednik` (`user_id`);

--
-- Indexes for table `polj_zahtevi`
--
ALTER TABLE `polj_zahtevi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `porudzbine`
--
ALTER TABLE `porudzbine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pred_idx` (`preduzece_id`),
  ADD KEY `id_polj_idx` (`polj_id`),
  ADD KEY `id_rasadnik_idx` (`rasadnik_id`);

--
-- Indexes for table `preduzeca`
--
ALTER TABLE `preduzeca`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_preduzece` (`user_id`);

--
-- Indexes for table `pred_zahtevi`
--
ALTER TABLE `pred_zahtevi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proizvodi`
--
ALTER TABLE `proizvodi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_preduzece_idx` (`preduzece_id`);

--
-- Indexes for table `proizvod_porudzbina`
--
ALTER TABLE `proizvod_porudzbina`
  ADD PRIMARY KEY (`porudzbina_id`,`proizvod_id`),
  ADD KEY `id_proizvod_idx` (`proizvod_id`);

--
-- Indexes for table `rasadnici`
--
ALTER TABLE `rasadnici`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_poljoprivrednika_idx` (`poljoprivrednik_id`);

--
-- Indexes for table `sadnice`
--
ALTER TABLE `sadnice`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rasadnika_idx` (`rasadnik_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kuriri`
--
ALTER TABLE `kuriri`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `magacini`
--
ALTER TABLE `magacini`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `poljoprivrednici`
--
ALTER TABLE `poljoprivrednici`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `polj_zahtevi`
--
ALTER TABLE `polj_zahtevi`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `porudzbine`
--
ALTER TABLE `porudzbine`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `preduzeca`
--
ALTER TABLE `preduzeca`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pred_zahtevi`
--
ALTER TABLE `pred_zahtevi`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `proizvodi`
--
ALTER TABLE `proizvodi`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `rasadnici`
--
ALTER TABLE `rasadnici`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `sadnice`
--
ALTER TABLE `sadnice`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `je_dodeljen`
--
ALTER TABLE `je_dodeljen`
  ADD CONSTRAINT `id_kurir` FOREIGN KEY (`kurir_id`) REFERENCES `kuriri` (`id`),
  ADD CONSTRAINT `id_por` FOREIGN KEY (`porudzbina_id`) REFERENCES `porudzbine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `je_ocenio`
--
ALTER TABLE `je_ocenio`
  ADD CONSTRAINT `id_proizovd` FOREIGN KEY (`proizvod_id`) REFERENCES `proizvodi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `id_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `kuriri`
--
ALTER TABLE `kuriri`
  ADD CONSTRAINT `id_preduzecekurir` FOREIGN KEY (`preduzece_id`) REFERENCES `preduzeca` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `magacini`
--
ALTER TABLE `magacini`
  ADD CONSTRAINT `id_rasadnika1` FOREIGN KEY (`rasadnik_id`) REFERENCES `rasadnici` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `magacin_proizvod`
--
ALTER TABLE `magacin_proizvod`
  ADD CONSTRAINT `id_magacin` FOREIGN KEY (`magacin_id`) REFERENCES `magacini` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_proizvod` FOREIGN KEY (`proizvod_id`) REFERENCES `proizvodi` (`id`);

--
-- Constraints for table `poljoprivrednici`
--
ALTER TABLE `poljoprivrednici`
  ADD CONSTRAINT `id_poljoprivrednik` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `preduzeca`
--
ALTER TABLE `preduzeca`
  ADD CONSTRAINT `id_preduzece` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proizvodi`
--
ALTER TABLE `proizvodi`
  ADD CONSTRAINT `id_preduzece1` FOREIGN KEY (`preduzece_id`) REFERENCES `preduzeca` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `proizvod_porudzbina`
--
ALTER TABLE `proizvod_porudzbina`
  ADD CONSTRAINT `id_porudzbina` FOREIGN KEY (`porudzbina_id`) REFERENCES `porudzbine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_proizvod1` FOREIGN KEY (`proizvod_id`) REFERENCES `proizvodi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rasadnici`
--
ALTER TABLE `rasadnici`
  ADD CONSTRAINT `id_poljoprivrednika` FOREIGN KEY (`poljoprivrednik_id`) REFERENCES `poljoprivrednici` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sadnice`
--
ALTER TABLE `sadnice`
  ADD CONSTRAINT `id_rasadnika` FOREIGN KEY (`rasadnik_id`) REFERENCES `rasadnici` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `rasadnik_update` ON SCHEDULE EVERY 1 HOUR STARTS '2020-07-08 20:36:24' ON COMPLETION NOT PRESERVE ENABLE DO UPDATE rasadnici SET temperatura = temperatura - 0.5, voda = voda - 1$$

CREATE DEFINER=`root`@`localhost` EVENT `sadnica_update` ON SCHEDULE EVERY 5 HOUR STARTS '2020-07-08 21:31:38' ON COMPLETION NOT PRESERVE ENABLE DO CALL progres_sadnica()$$

CREATE DEFINER=`root`@`localhost` EVENT `sadnica_izvadjena` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-07-08 22:12:08' ON COMPLETION NOT PRESERVE ENABLE DO CALL sadnica_izvadjena()$$

CREATE DEFINER=`root`@`localhost` EVENT `refresh_kuriri` ON SCHEDULE EVERY 3 MINUTE STARTS '2020-07-08 22:59:21' ON COMPLETION NOT PRESERVE ENABLE DO call update_kuriri()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
