-- Modèles de véhicules par Année
SET annee = 2018;

SELECT DISTINCT tv.modele
FROM type_vehicule tv
JOIN vehicules v ON v.no_type_vehicule = tv.no_type_vehicule
JOIN mettre_au_garage mg ON v.no_vehicule = mg.no_vehicule
JOIN prise_en_charge pec ON mg.no_prise_en_charge = pec.no_prise_en_charge
WHERE EXTRACT(YEAR FROM pec.debut_prise_en_charge) = @annee;

-- Liste des interventions
SET date_debut = '2018-01-01';
SET date_fin = '2018-12-31';

SELECT i.*, g.nom_garage FROM interventions i
JOIN garage g ON i.garage = g.no_garage
WHERE date_intervention BETWEEN @date_debut AND @date_fin;

-- Les types de véhicules et les interventions majoritaires
SELECT tv.modele, COUNT(i.nature_intervention) AS nombre, MAX(i.nature_intervention) AS intervention_majoritaire
FROM type_vehicule tv
JOIN vehicules v ON tv.no_type_vehicule = v.no_type_vehicule
JOIN interventions i ON v.no_vehicule = i.no_vehicule
GROUP BY tv.modele
ORDER BY nombre DESC;

-- Liste des interventions prévues dans les deux mois.
SELECT * 
FROM interventions
WHERE date_intervention < CURRENT_DATE + INTERVAL '2 months';

-- Liste des clients avec le nombre de véhicules qu’ils ont confiés au garage.
SELECT
    c.no_client,
    c.nom,
    c.prenom,
    COUNT(v.no_vehicule) AS nombre_vehicules_confies
FROM
    clients c
JOIN
    vehicules v 
    ON c.no_client = v.no_client
GROUP BY
    c.no_client, c.nom, c.prenom
ORDER BY
    nombre_vehicules_confies 
    DESC;

-- Liste des modèles de véhicule pris en charge lors de l’année écoulée.
SELECT DISTINCT
    tv.nom_modele
FROM
    vehicules v
JOIN
    type_vehicule tv 
    ON v.no_type_vehicule = tv.no_type_vehicule
WHERE
    v.date_mise_circulation >= CURRENT_DATE - INTERVAL '1 year'
    AND v.date_mise_circulation < CURRENT_DATE;

-- La liste des clients, avec le total des sommes facturées à chacun.

SELECT 
    c.no_client, 
    c.nom, 
    c.prenom, 
    SUM(g.tarif_horaire * i.duree_intervention + p.prix_unitaire_piece) AS total_facture
FROM clients c
JOIN vehicules v ON c.no_client = v.no_client
JOIN interventions i ON v.no_vehicule = i.no_vehicule
JOIN garage g ON i.garage = g.no_garage
JOIN pieces p ON i.no_intervention = p.no_intervention
GROUP BY c.no_client, c.nom, c.prenom;

-- Le nombre d’heures facturées par mois.

SELECT 
    EXTRACT(MONTH FROM date_intervention) AS mois,
    EXTRACT(YEAR FROM date_intervention) AS annee,
    SUM(duree_intervention) AS total_heures_facturees
FROM interventions
GROUP BY EXTRACT(MONTH FROM date_intervention), EXTRACT(YEAR FROM date_intervention)
ORDER BY annee, mois;
