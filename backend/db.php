<?php

    $dns = 'mysql:host=localhost;dbname=lol_clicker';
    $user = 'root';
    $password = '';

    try {
        $db = new PDO($dns, $user, $password);
    } catch (PDOException $e) {
        $error = $e->getMessage();
        echo $error;
    }
