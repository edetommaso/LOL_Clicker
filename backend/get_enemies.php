<?php
	
	require_once('db.php');
	
	$query = 'SELECT * FROM Enemy';
	$params = [];
	
	if (!empty($_GET['level'])) {
	    $level = filter_var($_GET['level'], FILTER_VALIDATE_INT);
	    if ($level !== false) {
		$query .= ' AND level = :level';
		$params[':level'] = $level;
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
	

	
	try {
	    $statement = $db->prepare($query);
	    $statement->execute($params);
	    $rows = $statement->fetchAll(PDO::FETCH_ASSOC);
	    
	    echo json_encode($rows);
	} catch (Exception $e) {
	    http_response_code(500);
	    echo json_encode(["error" => "Erreur serveur : " . $e->getMessage()]);
	}

