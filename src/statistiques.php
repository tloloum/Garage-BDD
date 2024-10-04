<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Statistiques</title>
    <link href="./style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <header>
        <div class="barre">
            <ul>
                <li><a href="./index.php">Home</a></li>
                <li><a href="./client.php">Clients</a></li>
                <li><a href="./consultation.php">Consultation</a></li>
                <li class="courant"><a href="statistiques.php">Statistiques</a></li>
            </ul>
        </div>
    </header>

    <div class="page-stat">
        <h1>Inteventions majoritaires selon le type de véhicule</h1>
        <div class="statistiques">
            <?php
            include "connect_pg.php"; 

            $sql = "SELECT tv.modele, COUNT(i.nature_intervention) AS nombre, MAX(i.nature_intervention) AS intervention_majoritaire
                    FROM type_vehicule tv
                    JOIN vehicules v ON tv.no_type_vehicule = v.no_type_vehicule
                    JOIN interventions i ON v.no_vehicule = i.no_vehicule
                    GROUP BY tv.modele
                    ORDER BY nombre DESC";
            
            $result = pg_query($connection, $sql);

            if ($result && pg_num_rows($result) > 0) {
                echo "<ul>";
                while ($row = pg_fetch_assoc($result)) {
                    echo "<li>" . $row['modele'] . " - Intervention majoritaire: " . $row['intervention_majoritaire'] . "</li>";
                }
                echo "</ul>";
            } else {
                echo "Aucune statistique disponible.";
            }

            pg_close($connection);
            ?>
            <h1>Total facturés par mois</h1>

            <!-- Section pour sélectionner le mois -->
            <div class="selection-mois">
                <form action="statistiques.php" method="post">
                    <label for="mois">Mois :</label>
                    <select name="mois" id="mois">
                        <?php
                        for ($i = 1; $i <= 12; $i++) {
                            echo "<option value=\"$i\">$i</option>";
                        }
                        ?>
                    </select>
                    <label for="annee">Année :</label>
                    <select name="annee" id="annee">
                        <?php
                        $currentYear = date("Y");
                        for ($i = 2017; $i <= $currentYear; $i++) {
                            echo "<option value=\"$i\">$i</option>";
                        }
                        ?>
                    </select>
                    <input type="submit" value="Voir les heures facturées">
                </form>
            </div>

            <!-- Section pour afficher les heures facturées -->
            <div class="heures-facturees">
                <?php
                include "connect_pg.php";
                if (isset($_POST['mois']) && isset($_POST['annee'])) {
                    $mois = $_POST['mois'];
                    $annee = $_POST['annee'];

                    $sql_heures_facturees = "SELECT 
                                                SUM(duree_intervention) AS total_heures_facturees
                                            FROM interventions
                                            WHERE EXTRACT(MONTH FROM date_intervention) = $1
                                            AND EXTRACT(YEAR FROM date_intervention) = $2
                                            GROUP BY EXTRACT(MONTH FROM date_intervention), EXTRACT(YEAR FROM date_intervention)";
                    $params_heures_facturees = array($mois, $annee);
                    $result_heures_facturees = pg_query_params($connection, $sql_heures_facturees, $params_heures_facturees);

                    if ($result_heures_facturees && pg_num_rows($result_heures_facturees) > 0) {
                        $heures_facturees_info = pg_fetch_assoc($result_heures_facturees);
                        echo "<p>Heures facturées pour $mois/$annee : " . $heures_facturees_info['total_heures_facturees'] . " heures</p>";
                    } else {
                        echo "<p>Aucune heure facturée pour $mois/$annee.</p>";
                    }
                }
                pg_close($connection);
                ?>
        </div>
    </div>
</body>
</html>
