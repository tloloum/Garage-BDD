<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Recherche de Clients</title>
    <link href="./style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <header>
        <div class="barre">
            <ul>
                <li><a href="./index.php">Home</a></li>
                <li class="courant"><a href="client.php">Clients</a></li>
                <li><a href="consultation.php">Consultation</a></li>
                <li><a href="statistiques.php">Statistiques</a></li>
            </ul>
        </div>
    </header>

    <div class="page">
        <h1>Recherche de Clients</h1>
        <div class="recherche">
            <div class="menu" id="client-menu">
                <?php
                include "connect_pg.php"; 
                
                $requete = "SELECT no_client, nom, prenom FROM clients ORDER BY nom, prenom";
                $res = pg_query($connection, $requete);

                if ($res) {
                    while ($client = pg_fetch_assoc($res)) {
                        echo '<form method="POST" action="">';
                        echo '<input type="hidden" name="client_id" value="' . $client['no_client'] . '">';
                        echo '<button type="submit" class="menu-item">' . $client['nom'] . ' ' . $client['prenom'] . '</button>';
                        echo '</form>';
                    }
                }

                pg_close($connection);
                ?>
            </div>
        </div>

        <div class="resultats" id="client-info">
            <?php
                if (isset($_POST['client_id'])) {
                    $client_id = $_POST['client_id'];
                    include "connect_pg.php";
                    
                    $sql = "SELECT nom, prenom, adresse, telephone, email
                            FROM clients
                            WHERE no_client = $1";
                    $params = array($client_id);
                    $result = pg_query_params($connection, $sql, $params);
                    
                    if ($result && pg_num_rows($result) > 0) {
                        $client_info = pg_fetch_assoc($result);
                        echo "<h2>Informations du client :</h2>";
                        echo "<p><strong>Nom :</strong> " . $client_info['nom'] . "</p>";
                        echo "<p><strong>Prénom :</strong> " . $client_info['prenom'] . "</p>";
                        echo "<p><strong>Adresse :</strong> " . $client_info['adresse'] . "</p>";
                        echo "<p><strong>Téléphone :</strong> " . $client_info['telephone'] . "</p>";
                        echo "<p><strong>Email :</strong> " . $client_info['email'] . "</p>";

                        $sql_count_vehicles = "SELECT COUNT(*) AS nb_vehicules
                                            FROM vehicules
                                            WHERE no_client = $1";
                        $result_count_vehicles = pg_query_params($connection, $sql_count_vehicles, $params);

                        if ($result_count_vehicles && pg_num_rows($result_count_vehicles) > 0) {
                            $count_vehicles_info = pg_fetch_assoc($result_count_vehicles);
                            echo "<p><strong>Nombre de véhicules confiés aux garages :</strong> " . $count_vehicles_info['nb_vehicules'] . "</p>";
                        }
                        
                        $sql_total_facture = "SELECT 
                            SUM(g.tarif_horaire * i.duree_intervention + COALESCE(p.prix_unitaire_piece, 0)) AS total_facture
                            FROM clients c
                            JOIN vehicules v ON c.no_client = v.no_client
                            JOIN interventions i ON v.no_vehicule = i.no_vehicule
                            JOIN garage g ON i.garage = g.no_garage
                            LEFT JOIN pieces p ON i.no_intervention = p.no_intervention
                            WHERE c.no_client = $1
                            GROUP BY c.no_client";
                        $result_total_facture = pg_query_params($connection, $sql_total_facture, $params);

                        if ($result_total_facture && pg_num_rows($result_total_facture) > 0) {
                            $total_facture_info = pg_fetch_assoc($result_total_facture);
                            echo "<p><strong>Total des sommes facturées :</strong> " . $total_facture_info['total_facture'] . "€</p>";
                        } else {
                            echo "<p><strong>Total des sommes facturées :</strong> 0€</p>";
                        }


                    } else {
                        echo "Aucun résultat trouvé.";
                    }
                    
                    pg_close($connection);
                }
                ?>

        </div>
    </div>
</body>
</html>
