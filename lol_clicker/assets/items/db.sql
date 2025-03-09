CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    imagePath VARCHAR(255) NOT NULL
);

INSERT INTO items (id, name, description, price, imagePath) VALUES
(1, 'Long Sword', 'aaa', 350.00, 'assets/items/LongSword.png'),
(2, 'Caulfield`s Warhammer', 'aaa', 10500.00, 'assets/items/warhammer.png'),
(3, 'Last Whisper', 'aaa', 30000.00, 'assets/items/whisper.png'),
(4, 'B. F. Sword', 'aaa', 55000.00, 'assets/items/BFSword.png'),
(5, 'Kraken Slayer', 'aaa', 700000.00, 'assets/items/kraken.png'),
(6, 'Infinity Edge', 'aaa', 999000.00, 'assets/items/infinity.png'),
(7, 'The Collector', 'aaa', 10000000.00, 'assets/items/collector.png');

