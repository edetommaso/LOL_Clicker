CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    imagePath VARCHAR(255) NOT NULL
);

INSERT INTO items (id, name, description, price, imagePath) VALUES
(1, 'Long Sword', 'aaa', 35.00, 'assets/LongSword.png'),
(2, 'Caulfield`s Warhammer', 'aaa', 105.00, 'assets/warhammer.png'),
(3, 'Last Whisper', 'aaa', 300.00, 'assets/whisper.png'),
(4, 'B. F. Sword', 'aaa', 650.00, 'assets/BFSword.png'),
(5, 'Kraken Slayer', 'aaa', 800.00, 'assets/kraken.png'),
(6, 'Infinity Edge', 'aaa', 999.00, 'assets/infinity_edge.png'),
(7, 'The Collector', 'aaa', 1500.00, 'assets/collector.png');

