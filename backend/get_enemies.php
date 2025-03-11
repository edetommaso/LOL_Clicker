<?php
	
	require_once('db.php');
	header("Access-Control-Allow-Origin: *");
	header("Access-Control-Allow-Methods: GET");
	header("Access-Control-Allow-Headers: Content-Type, Accept");
	header("Content-Type: application/json");
	
	$query = 'SELECT * FROM Enemy WHERE 1=1';
	$params = [];
	
	if (!empty($_GET['id'])) {
	    $query .= ' AND id = :id';
	    $params[':id'] = $_GET['id'];
	}
	
	if (!empty($_GET['categorie'])) {
	    $categorie = filter_var($_GET['categorie'], FILTER_VALIDATE_INT);
	    if ($categorie !== false) {
		$query .= ' AND categorie = :categorie';
		$params[':categorie'] = $categorie;
	    }
	}
	
	if (!empty($_GET['name'])) {
	    $name = htmlspecialchars(strip_tags($_GET['name']));
	    $query .= ' AND name = :name';
	    $params[':name'] = $name;
	}
	
	if (!empty($_GET['total_life'])) {
	    $total_life = filter_var($_GET['total_life'], FILTER_VALIDATE_INT);
	    if ($total_life !== false) {
		$query .= ' AND total_life = :total_life';
		$params[':total_life'] = $total_life;
	    }
	}
	
	if (!empty($_GET['experience'])) {
		$experience = filter_var($_GET['experience'], FILTER_VALIDATE_INT);
		if ($experience !== false) {
			$query .= ' AND experience = :experience';
			$params[':experience'] = $experience;
		}
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

