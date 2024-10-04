<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajout Client - Garage</title>
    <link href="./style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <header>
        <div class="barre">
            <ul>
                <li><a class="courant" href="./index.php">Home</a></li>
                <li><a href="./client.php">Clients</a></li>
                <li><a href="consultation.php">Consultation</a></li>
                <li><a href="./statistiques.php">Statistiques</a></li>
            </ul>
        </div>
    </header>
    <div class="page-index">
        <h1>Ajouter un nouveau client et ses informations</h1>
        <form action="process_ajout_client.php" method="post">
            <!-- Informations du client -->
            <label>Nom: <input type="text" pattern="[A-Za-zÀ-ÖØ-öø-ÿ]{1,15}" maxlength="15" name="nom" required></label><br>
            <label>Prénom: <input type="text" pattern="[A-Za-zÀ-ÖØ-öø-ÿ]{1,15}" maxlength="15" name="prenom" required></label><br>
            <label>Adresse: <input type="text" maxlength="45" name="adresse" required></label><br>
            <label>Téléphone: <input type="tel" pattern="[0-9]{10}" name="telephone" required></label><br>
            <label>Email: <input type="email" maxlength="30" name="email" required></label><br>

            <!-- Informations du véhicule -->
            <label>Modèle: <select name="modele" required>
                <?php
                include "connect_pg.php";
                $result = pg_query($connection, "SELECT no_type_vehicule, modele FROM type_vehicule");
                while ($row = pg_fetch_assoc($result)) {
                    echo "<option value='" . $row['no_type_vehicule'] . "'>" . $row['modele'] . "</option>";
                }
                ?>
            </select></label><br>
                <!-- Options du modèle de véhicule -->
                <label>Date de mise en circulation: <input type="date" name="date_mise_circulation" max="<?php echo date('Y-d-m'); ?>" required></label><br>

                <label>Immatriculation (prendre le format sur l'exemple:AA-000-AA): <input type="text" name="immatriculation" pattern="[A-Za-z]{2}-[0-9]{3}-[A-Za-z]{2}" title="Veuillez entrer une immatriculation valide." required></label><br>


            <!-- Informations de l'intervention -->
            <label>Début prise en charge: <input type="date" name="debut_prise_en_charge" required></label><br>
            <label>Fin prise en charge: <input type="date" name="fin_prise_en_charge" required></label><br>
            <label>Devis annoncé: <input type="number" name="devis_annonce" required></label><br>
            <label>Kilométrage: <input type="number" name="kilometrage" required></label><br>
            <label>Nature intervention: <select name="nature_intervention" required>
                <?php
                // Supposons que vous avez une table pour les natures d'interventions
                $result = pg_query($connection, "SELECT DISTINCT nature_intervention FROM interventions");
                while ($row = pg_fetch_assoc($result)) {
                    echo "<option value='" . $row['nature_intervention'] . "'>" . $row['nature_intervention'] . "</option>";
                }
                ?>
            </select></label><br>
            <label>Durée intervention (en heures): <input type="number" name="duree_intervention" required></label><br>
            <!-- Informations des pièces -->
            <label>Nom de la pièce: <select name="nom_piece">
                <option value="">Aucune</option>
                <?php
                $result = pg_query($connection, "SELECT no_piece, nom_piece FROM pieces");
                while ($row = pg_fetch_assoc($result)) {
                    echo "<option value='" . $row['no_piece'] . "'>" . $row['nom_piece'] . "</option>";
                }
                ?>
            </select></label><br>
            <label>Type de pièce: <select name="type_piece">
                <option value="">Sélectionner</option>
                <?php
                $result_type_piece = pg_query($connection, "SELECT no_type_piece, nom_type_piece FROM type_piece");
                while ($row_type_piece = pg_fetch_assoc($result_type_piece)) {
                    echo "<option value='" . $row_type_piece['no_type_piece'] . "'>" . $row_type_piece['nom_type_piece'] . "</option>";
                }
                ?>
            </select></label><br>

            <input type="submit" value="Ajouter">
            
        </form>
    </div>
</body>
</html>
