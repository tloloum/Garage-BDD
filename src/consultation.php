<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Modèles de véhicules par Année</title>
    <link href="./style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <header>
        <div class="barre">
            <ul>
                <li><a href="./index.php">Home</a></li>
                <li><a href="./client.php">Clients</a></li>
                <li class="courant"><a href="consultation.php">Consultation</a></li>
                <li><a href="./statistiques.php">Statistiques</a></li>
            </ul>
        </div>
    </header>

    <div class="page-consult">
        <div class="vehicule">
            <h2>Modèles de véhicules par Année</h1>
            <div class="recherche-consult">
                <div class="menu">
                    <?php
                    include "connect_pg.php"; 

                    for($i = 2017; $i <= date("Y"); $i++){
                        echo '<form method="POST" action="">';
                        echo '<input type="hidden" name="annee" value="' . $i . '">';
                        echo '<button type="submit" class="menu-item">' . $i . '</button>';
                        echo '</form>';
                    }
                    ?>
                </div>
            </div>

            <div class="resultats_consult" id="modele-info">
                <?php
                if (isset($_POST['annee'])) {
                    $annee = $_POST['annee'];
                    $requete = "SELECT DISTINCT tv.modele
                                FROM type_vehicule tv
                                JOIN vehicules v ON v.no_type_vehicule = tv.no_type_vehicule
                                JOIN mettre_au_garage mg ON v.no_vehicule = mg.no_vehicule
                                JOIN prise_en_charge pec ON mg.no_prise_en_charge = pec.no_prise_en_charge
                                WHERE EXTRACT(YEAR FROM pec.debut_prise_en_charge) = $annee";

                    $res = pg_query($connection, $requete);

                    if ($res && pg_num_rows($res) > 0) {
                        echo "<ul>";
                        while ($modele = pg_fetch_assoc($res)) {
                            echo "<li>" . $modele['modele'] . "</li>";
                        }
                        echo "</ul>";
                    } else {
                        echo "Aucun modèle trouvé pour l'année sélectionnée.";
                    }
                }

                pg_close($connection);
                ?>
            </div>
        </div>

        <div class="interventions">
            <h2>Liste des interventions</h2>
            <div class="recherche-consult">
                <form method="POST" action="">
                    <label for="date_debut">Date de début:</label>
                    <input type="date" id="date_debut" name="date_debut">
                    <label for="date_fin">Date de fin:</label>
                    <input type="date" id="date_fin" name="date_fin">
                    <button type="submit" class="btn-consult">Voir les interventions</button>
                </form>
            </div>

            <!-- Affichage des résultats -->
            <div class="resultats_consult">
                <?php
                if (isset($_POST['date_debut']) && isset($_POST['date_fin'])) {
                    $date_debut = $_POST['date_debut'];
                    $date_fin = $_POST['date_fin'];

                    if (!empty($date_debut) && !empty($date_fin)) {

                        include "connect_pg.php";

                        // Modifiez cette requête pour inclure le nom du garage
                        $requete = "SELECT i.*, g.nom_garage FROM interventions i
                                    JOIN garage g ON i.garage = g.no_garage
                                    WHERE date_intervention BETWEEN '$date_debut' AND '$date_fin'";

                        $res = pg_query($connection, $requete);


                        if ($res && pg_num_rows($res) > 0) {
                            echo "<ul>";
                            while ($intervention = pg_fetch_assoc($res)) {
                                echo "<li>" . $intervention['nature_intervention'] . " - " . $intervention['date_intervention'] . " - Garage: " . $intervention['nom_garage'] . "</li>";
                            }
                            echo "</ul>";
                        } else {
                            echo "Aucune intervention trouvée pour cette période.";
                        }

                        pg_close($connection);
                    } else {
                        echo "<p>Veuillez sélectionner des dates de début et de fin.</p>";
                    }
                    
                }
                ?>
            </div>
        </div>
    </div>
</body>
</html>
