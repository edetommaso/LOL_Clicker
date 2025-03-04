<?php
	require_once('db.php');

	$query = 'SELECT * FROM users WHERE 1=1';
	$params = [];

	if (!empty($_GET['id'])) {
	    $query .= ' AND id_user = :id_user';
	    $params[':id_user'] = $_GET['id_user'];
	}

	if (!empty($_GET['lastname'])) {
	    $query .= ' AND lastname = :lastname';
	    $params[':lastname'] = $_GET['lastname'];
	}

	if (!empty($_GET['firstname'])) {
	    $query .= ' AND firstname = :firstname';
	    $params[':username'] = $_GET['firstname'];
	}

	if (!empty($_GET['age'])) {
	    $query .= ' AND age > :age';
	    $params[':age'] = $_GET['age'];
	}

	$statement = $db->prepare($query);
	$statement->execute($params);
	$rows = $statement->fetchAll(PDO::FETCH_ASSOC);

	echo json_encode($rows);
