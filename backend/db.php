<?php

    $dns = 'mysql:host=localhost;dbname=test';
    $user = 'root';
    $password = 'Azerty123_Mdp';

    try {
        $db = new PDO($dns, $user, $password);
    } catch (PDOException $e) {
        $error = $e->getMessage();
        echo $error;
    }
