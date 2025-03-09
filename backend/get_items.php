<?php
	
	require_once('db.php');
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Methods: GET");
	header("Access-Control-Allow-Headers: Content-Type, Accept");
	header("Content-Type: application/json");
	
	$query = 'SELECT * FROM Items WHERE 1=1';
	$params = [];
	
	if (!empty($_GET['id'])) {
	    $query .= ' AND id = :id';
	    $params[':id'] = $_GET['id'];
	}

	if (!empty($_GET['name'])) {
	    $name = htmlspecialchars(strip_tags($_GET['name']));
	    $query .= ' AND name = :name';
	    $params[':name'] = $name;
	}

	if (!empty($_GET['description'])) {
	    $description = filter_var($_GET['description'], FILTER_VALIDATE_INT);
	    if ($description !== false) {
		$query .= ' AND description = :description';
		$params[':description'] = $description;
	    }
	}
	
	if (!empty($_GET['price'])) {
	    $query .= ' AND price = :price';
	    $params[':price'] = $_GET['price'];
	}
	
	if (!empty($_GET['image'])) {
	    $image = htmlspecialchars(strip_tags($_GET['image']));
	    $query .= ' AND image = :image';
	    $params[':image'] = $image;
	}
	
	try {
	    $statement = $db->prepare($query);
	    $statement->execute($params);
	    $rows = $statement->fetchAll(PDO::FETCH_ASSOC);
	    
	    echo json_encode($rows);
	} catch (Exception $e) {
	    http_response_code(500);
	    echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
	}

