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
  `id_enhancement` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `buy`
--

INSERT INTO `buy` (`id_player`, `id_enhancement`) VALUES
(1, 1),
(2, 1);

-- --------------------------------------------------------

--
-- Structure de la table `enemy`
--

CREATE TABLE `enemy` (
  `id` serial PRIMARY KEY,
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
(2,'Red Buff', 30, 18, 'assets/red.png'),
(2,'Grubs', 40, 22, 'assets/grubs.png'),
(3,'Captain Teemo', 50, 30, 'assets/teemo.png');

-- --------------------------------------------------------

--
-- Structure de la table `enhancement`
--

CREATE TABLE `enhancement` (
  `id_enhancement` int(11) NOT NULL,
  `experience_cost` int(11) NOT NULL,
  `boost_value` int(11) NOT NULL,
  `id_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `enhancement`
--

INSERT INTO `enhancement` (`id_enhancement`, `experience_cost`, `boost_value`, `id_type`) VALUES
(1, 0, 1, 1),
(2, 50, 2, 1),
(3, 0, 1, 2),
(4, 50, 2, 2);

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
-- Structure de la table `type_enhancement`
--

CREATE TABLE `type_enhancement` (
  `id_type` int(11) NOT NULL,
  `name_type` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `type_enhancement`
--

INSERT INTO `type_enhancement` (`id_type`, `name_type`) VALUES
(1, 'dps'),
(2, 'exp');

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
  ADD PRIMARY KEY (`id_player`,`id_enhancement`),
  ADD KEY `buy_Enhancement0_FK` (`id_enhancement`);


--
-- Index pour la table `enhancement`
--
ALTER TABLE `enhancement`
  ADD PRIMARY KEY (`id_enhancement`),
  ADD KEY `Enhancement_Type_enhancement_FK` (`id_type`);

--
-- Index pour la table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`id_player`),
  ADD KEY `Player_id_ennemy_FK` (`id_ennemy`);

--
-- Index pour la table `type_enhancement`
--
ALTER TABLE `type_enhancement`
  ADD PRIMARY KEY (`id_type`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT pour les tables déchargées
--



--
-- AUTO_INCREMENT pour la table `enhancement`
--
ALTER TABLE `enhancement`
  MODIFY `id_enhancement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `player`
--
ALTER TABLE `player`
  MODIFY `id_player` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `type_enhancement`
--
ALTER TABLE `type_enhancement`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `buy`
--
ALTER TABLE `buy`
  ADD CONSTRAINT `buy_Enhancement0_FK` FOREIGN KEY (`id_enhancement`) REFERENCES `enhancement` (`id_enhancement`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `buy_Player_FK` FOREIGN KEY (`id_player`) REFERENCES `player` (`id_player`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `enhancement`
--
ALTER TABLE `enhancement`
  ADD CONSTRAINT `Enhancement_Type_enhancement_FK` FOREIGN KEY (`id_type`) REFERENCES `type_enhancement` (`id_type`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
