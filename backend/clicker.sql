-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 09 mars 2025 à 16:30
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `lol_clicker`
--

-- --------------------------------------------------------

--
-- Structure de la table `buy`
--

CREATE TABLE `buy` (
  `id_player` int(11) NOT NULL,
  `id_items` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `buy`
--


-- --------------------------------------------------------

--
-- Structure de la table `enemy`
--

CREATE TABLE `enemy` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `categorie` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `total_life` int(11) NOT NULL,
  `experience` int(11) NOT NULL,
  `image` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enemy`
--

INSERT INTO `enemy` (`categorie`, `name`, `total_life`, `experience`, `image`) VALUES
(1, 'Carapateur', 10, 11, 'assets/carap.png'),
(1, 'Baby Raptor', 20, 14, 'assets/braptor.png'),
(2, 'Red Buff', 30, 18, 'assets/red.png'),
(2, 'Grubs', 40, 22, 'assets/grubs.png'),
(3, 'Captain Teemo', 50, 30, 'assets/teemo.png');

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `price` INT(11) NOT NULL,
  `image` VARCHAR(500) NOT NULL,
  `id_type` INT(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `description`, `price`, `image`, `id_type`) VALUES
('Long Sword', 'aaa', 35, 'assets/items/LongSword.png', 1),
('Caulfield`s Warhammer', 'aaa', 105, 'assets/items/warhammer.png', 1),
('Last Whisper', 'aaa', 300, 'assets/items/whisper.png', 1),
('B. F. Sword', 'aaa', 650, 'assets/items/BFSword.png', 1),
('Kraken Slayer', 'aaa', 800, 'assets/items/kraken.png', 1),
('Infinity Edge', 'aaa', 999, 'assets/items/infinity.png', 1),
('The Collector', 'aaa', 1500, 'assets/items/collector.png', 1);

-- --------------------------------------------------------

--
-- Structure de la table `player`
--

CREATE TABLE `player` (
  `id_player` int(11) NOT NULL,
  `pseudo` varchar(50) NOT NULL,
  `total_experience` int(11) NOT NULL,
  `id_ennemy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `player`
--

INSERT INTO `player` (`id_player`, `pseudo`, `total_experience`, `id_ennemy`) VALUES
(1, 'OmegaZell', 0, 1),
(2, 'Sparadrap', 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `type_items`
--

CREATE TABLE `type_items` (
  `id_type` INT AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_items`
--

INSERT INTO `type_items` (`id_type`, `name`) VALUES
(1, 'damage'),
(2, 'experience');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `birthdate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `firstname`, `lastname`, `birthdate`) VALUES
(4, 'Bob', 'Durand', '2020-01-15'),
(5, 'Alice', 'Durand', '2021-05-29'),
(7, 'Alain', 'Duvent', '1987-02-04'),
(8, 'Aline', 'Duvent', '1987-05-04'),
(11, 'Quentin', 'Chanraud', '1994-04-13');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `buy`
--

ALTER TABLE `buy`
  ADD PRIMARY KEY (`id_player`, `id_items`),
  ADD KEY `buy_Items0_FK` (`id_items`);

--
-- Index pour la table `player`
--

ALTER TABLE `player`
  ADD PRIMARY KEY (`id_player`),
  ADD KEY `Player_id_ennemy_FK` (`id_ennemy`);

--
-- Index pour la table `users`
--

ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `player`
--

ALTER TABLE `player`
  MODIFY `id_player` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--

ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `items`
--

ALTER TABLE `items`
  ADD CONSTRAINT `items_typeItems_FK` FOREIGN KEY (`id_type`) REFERENCES `type_items` (`id_type`);

--
-- Contraintes pour la table `buy`
--

ALTER TABLE `buy`
  ADD CONSTRAINT `buy_Items0_FK` FOREIGN KEY (`id_items`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `buy_Player_FK` FOREIGN KEY (`id_player`) REFERENCES `player` (`id_player`) ON DELETE CASCADE ON UPDATE CASCADE;


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;