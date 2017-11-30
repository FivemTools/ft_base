/*
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
*/

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


DROP TABLE IF EXISTS `ft_players`;
CREATE TABLE `ft_players` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `pos_x` float NOT NULL DEFAULT '0',
  `model` varchar(255) DEFAULT NULL,
  `pos_y` float NOT NULL DEFAULT '0',
  `pos_z` float DEFAULT '0',
  `heading` float NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


ALTER TABLE `ft_players`
  ADD PRIMARY KEY (`id`),
  ADD KEY `identifier` (`identifier`);


ALTER TABLE `ft_players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
