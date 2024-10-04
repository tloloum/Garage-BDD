<?php
// Inclure le fichier de connexion à la base de données
include "connect_pg.php";

// Vérifier si le formulaire a été soumis
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Récupérer les données du formulaire
    $nom = $_POST['nom'];
    $prenom = $_POST['prenom'];
    $adresse = $_POST['adresse'];
    $telephone = $_POST['telephone'];
    $email = $_POST['email'];
    $modele = $_POST['modele'];
    $date_mise_circulation = $_POST['date_mise_circulation'];
    $immatriculation = $_POST['immatriculation'];
    $garage = 1;
    $debut_prise_en_charge = $_POST['debut_prise_en_charge'];
    $fin_prise_en_charge = $_POST['fin_prise_en_charge'];
    $devis_annonce = $_POST['devis_annonce'];
    $kilometrage = $_POST['kilometrage'];
    $nature_intervention = $_POST['nature_intervention'];
    $duree_intervention = $_POST['duree_intervention'];
   
    $nom_piece = $_POST['nom_piece'];
    $type_piece = $_POST['type_piece'];

    // Insérer le client
    $sql_client = "INSERT INTO clients (nom, prenom, adresse, telephone, email) VALUES ($1, $2, $3, $4, $5) RETURNING no_client;";
    $params_client = array($_POST['nom'], $_POST['prenom'], $_POST['adresse'], $_POST['telephone'], $_POST['email']);

    $result_client = pg_query_params($connection, $sql_client, $params_client);
    if ($result_client) {
        $client_data = pg_fetch_assoc($result_client);
        $no_client = $client_data['no_client'];
    } else {
        echo "Erreur lors de l'insertion du client: " . pg_last_error($connection);
        exit;
    }


    // Insérer le véhicule
    $sql_vehicule = "INSERT INTO vehicules (date_mise_circulation, immatriculation, no_client, no_type_vehicule) VALUES ('$date_mise_circulation', '$immatriculation', $no_client, $modele) RETURNING no_vehicule";
    $res_vehicule = pg_query($connection, $sql_vehicule);
    $row_vehicule = pg_fetch_assoc($res_vehicule);
    $no_vehicule = $row_vehicule['no_vehicule'];

    // Insérer l'intervention
    $sql_intervention = "INSERT INTO interventions (nature_intervention, duree_intervention, date_intervention, no_vehicule, garage) VALUES ('$nature_intervention', $duree_intervention, '$fin_prise_en_charge', $no_vehicule, $garage)";
    $res_intervention = pg_query($connection, $sql_intervention);

    // Insérer la pièce si nécessaire
    if (!empty($nom_piece)) {
        $sql_piece = "INSERT INTO pieces (nom_piece, prix_unitaire_piece, no_type_piece, no_intervention) VALUES ('$nom_piece', 0, $type_piece, CURRVAL('interventions_no_intervention_seq'))";
        $res_piece = pg_query($connection, $sql_piece);
    }

    // Prise en charge
    $debut_prise_en_charge = $_POST['debut_prise_en_charge'];
    $fin_prise_en_charge = $_POST['fin_prise_en_charge'];
    $devis_annonce = $_POST['devis_annonce'];

    $sql_prise_en_charge = "INSERT INTO prise_en_charge (debut_prise_en_charge, fin_prise_en_charge, devis_annonce) VALUES ('$debut_prise_en_charge', '$fin_prise_en_charge', $devis_annonce) RETURNING no_prise_en_charge;";
    $result_prise_en_charge = pg_query($connection, $sql_prise_en_charge);
    $prise_en_charge_data = pg_fetch_assoc($result_prise_en_charge);
    $no_prise_en_charge = $prise_en_charge_data['no_prise_en_charge'];

    // Mettre au garage
    $kilometrage = $_POST['kilometrage'];
    $kilometrage = intval($kilometrage);

    $sql_mettre_au_garage = "INSERT INTO mettre_au_garage (no_vehicule, no_prise_en_charge, kilometrage) VALUES ($no_vehicule, $no_prise_en_charge, $kilometrage);";
    $result_mettre_au_garage = pg_query($connection, $sql_mettre_au_garage);

    // Vérifier si tout s'est bien passé et fermer la connexion
    if ($result_client && $res_vehicule && $res_intervention && $result_prise_en_charge && $result_mettre_au_garage) {
        pg_close($connection);
        // Rediriger vers une page de confirmation ou de succès
        header("Location: index.php");
    }
}

// Fermer la connexion
pg_close($connection);
?>
