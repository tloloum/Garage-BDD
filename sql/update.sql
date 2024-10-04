-- Mettre à jour le email du client dont l'ID est 1
UPDATE clients
SET email = 'nouvel_email@gmail.com'
WHERE ID = 1;

-- Effacer toutes les données du client John Doe
UPDATE clients
SET email = NULL, nom = NULL, prenom = NULL, age = NULL
WHERE nom = 'Doe' AND prenom = 'John';

-- Repousser d'un jour toutes les interventions prévues pour le 1er janvier 2018
UPDATE interventions
SET date_intervention = date_intervention + INTERVAL '1 day'
WHERE date_intervention = '2018-01-01';