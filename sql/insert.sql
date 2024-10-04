-- ============================================================
--    suppression des donnees
-- ============================================================

TRUNCATE 
clients,
vehicules,
type_vehicule,
prise_en_charge,
interventions,
type_piece,
pieces,
utiliser,
garage,
mettre_au_garage 
RESTART IDENTITY;

-- ============================================================
--    creation des donnees
-- ============================================================

-- clients

--on compte 17 clients différents

INSERT INTO clients (nom, prenom, adresse, telephone, email)
VALUES 
    ('Doe', 'John', '123 Rue de la République', '0123456789', 'john.doe@email.com'),
    ('Smith', 'Jane', '456 Avenue des Fleurs', '0987654321', 'jane.smith@email.com'),
    ('Johnson', 'Robert', '789 Boulevard des Étoiles', '1122334455', 'robert.johnson@email.com'),
    ('Brown', 'Emily', '234 Rue du Soleil', '5544332211', 'emily.brown@email.com'),
    ('Miller', 'Michael', '567 Avenue de la Lune', '6677889900', 'michael.miller@email.com'),
    ('Garcia', 'Isabel', '890 Place des Montagnes', '2233445566', 'isabel.garcia@email.com'),
    ('Chen', 'David', '456 Rue des Océans', '7788990011', 'david.chen@email.com'),
    ('Taylor', 'William', '123 Avenue des Champs', '1122334455', 'william.taylor@email.com'),
    ('Lopez', 'Maria', '456 Rue des Roses', '3344556677', 'maria.lopez@email.com'),
    ('Wang', 'James', '789 Boulevard des Arbres', '5566778899', 'james.wang@email.com'),
    ('Anderson', 'Emma', '890 Avenue des Étoiles', '7788990011', 'emma.anderson@email.com'),
    ('Garcia', 'Daniel', '234 Rue des Montagnes', '9900112233', 'daniel.garcia@email.com'),
    ('Cohen', 'Sophie', '567 Avenue des Oiseaux', '1122334455', 'sophie.cohen@email.com'),
    ('Lee', 'Christopher', '890 Rue des Rivières', '3344556677', 'christopher.lee@email.com'),
    ('Nguyen', 'Hannah', '123 Boulevard des Nuages', '5566778899', 'hannah.nguyen@email.com'),
    ('Gomez', 'Anthony', '456 Rue du Vent', '7788990011', 'anthony.gomez@email.com'),
    ('White', 'Olivia', '789 Avenue de la Pluie', '9900112233', 'olivia.white@email.com'),
    ('Martinez', 'Lucas', '321 Rue des Anges', '9988776655', 'lucas.martinez@email.com'),
    ('Kumar', 'Anjali', '654 Avenue des Braves', '8877665544', 'anjali.kumar@email.com'),
    ('Dubois', 'Rene', '987 Boulevard des Héros', '7766554433', 'rene.dubois@email.com'),
    ('Moreau', 'Charlotte', '111 Allée des Cerisiers', '1234567890', 'charlotte.moreau@email.com'),
    ('Petit', 'Maxime', '222 Chemin des Pommiers', '2345678901', 'maxime.petit@email.com'),
    ('Roux', 'Clara', '333 Route des Poiriers', '3456789012', 'clara.roux@email.com'),
    ('Bernard', 'Alice', '101 Rue de l''Innovation', '9876543210', 'alice.bernard@email.com'),
    ('Fournier', 'Olivier', '202 Avenue de la Technologie', '8765432109', 'olivier.fournier@email.com'),
    ('Leroy', 'Sophia', '303 Boulevard de la Science', '7654321098', 'sophia.leroy@email.com'),
    ('Morel', 'Pierre', '404 Chemin de l''Avenir', '6543210987', 'pierre.morel@email.com'),
    ('Simon', 'Julie', '505 Allée de l''Évolution', '5432109876', 'julie.simon@email.com'),
    ('Dupont', 'Élise', '910 Rue des Lys', '9990001112', 'elise.dupont@email.com'),
    ('Leclerc', 'Bruno', '811 Avenue des Tulipes', '8881112223', 'bruno.leclerc@email.com'),
    ('Girard', 'Nathalie', '712 Boulevard des Roses', '7772223334', 'nathalie.girard@email.com'),
    ('Moulin', 'Patrick', '913 Rue des Coquelicots', '6667778889', 'patrick.moulin@email.com'),
    ('Riviere', 'Caroline', '814 Avenue des Marguerites', '5556667778', 'caroline.riviere@email.com'),
    ('Blanc', 'François', '615 Boulevard des Jonquilles', '4445556667', 'francois.blanc@email.com');




-- type_vehicule

INSERT INTO type_vehicule (modele)
VALUES 
    ('Berline'),
    ('VUS'),
    ('Camion'),
    ('Décapotable'),
    ('Hayon'),
    ('Coupé'),
    ('Fourgon'),
    ('Moto'),
    ('Voiture électrique'),
    ('Voiture hybride'),
    ('Minibus'),
    ('Camionnette'),
    ('SUV de luxe'),
    ('Roadster'),
    ('Limousine'),
    ('Fourgon aménagé'),
    ('Crossover'),
    ('Sportive');

-- vehicules

--on compte 24 véhicules

INSERT INTO vehicules (date_mise_circulation, immatriculation, no_client, no_type_vehicule)
VALUES 
    (TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'ABC123', 1, 1),
    (TO_DATE('2012-05-20', 'YYYY-MM-DD'), 'XYZ456', 2, 2),
    (TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'DEF789', 3, 1),
    (TO_DATE('2018-03-25', 'YYYY-MM-DD'), 'GHI012', 4, 3),
    (TO_DATE('2014-11-30', 'YYYY-MM-DD'), 'JKL345', 5, 2),
    (TO_DATE('2017-06-12', 'YYYY-MM-DD'), 'MNO678', 6, 1),
    (TO_DATE('2015-09-05', 'YYYY-MM-DD'), 'PQR901', 7, 3),
    (TO_DATE('2019-02-18', 'YYYY-MM-DD'), 'STU234', 8, 2),
    (TO_DATE('2021-12-03', 'YYYY-MM-DD'), 'VWX567', 9, 1),
    (TO_DATE('2018-07-28', 'YYYY-MM-DD'), 'YZA890', 10, 3),
    (TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'ABC123', 11, 1),
    (TO_DATE('2014-05-20', 'YYYY-MM-DD'), 'XYZ456', 12, 2),
    (TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'DEF789', 13, 1),
    (TO_DATE('2018-03-25', 'YYYY-MM-DD'), 'GHI012', 14, 3),
    (TO_DATE('2010-11-30', 'YYYY-MM-DD'), 'JKL345', 15, 2),
    (TO_DATE('2017-06-12', 'YYYY-MM-DD'), 'MNO678', 16, 1),
    (TO_DATE('2020-09-05', 'YYYY-MM-DD'), 'PQR901', 17, 3),
    (TO_DATE('2019-03-15', 'YYYY-MM-DD'), 'NOP234', 18, 4),
    (TO_DATE('2021-07-20', 'YYYY-MM-DD'), 'QRS567', 19, 5),
    (TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'TUV890', 20, 6),
    (TO_DATE('2012-04-15', 'YYYY-MM-DD'), 'LMN321', 21, 11), 
    (TO_DATE('2021-07-20', 'YYYY-MM-DD'), 'OPQ654', 22, 12), 
    (TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'RST987', 23, 13),
    (TO_DATE('2021-09-15', 'YYYY-MM-DD'), 'UVW147', 24, 14),
    (TO_DATE('2016-02-20', 'YYYY-MM-DD'), 'XYZ258', 25, 15),
    (TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'ABC369', 26, 16),
    (TO_DATE('2020-12-05', 'YYYY-MM-DD'), 'DEF471', 27, 17),
    (TO_DATE('2019-03-22', 'YYYY-MM-DD'), 'GHI572', 28, 18),
    (TO_DATE('2021-07-10', 'YYYY-MM-DD'), 'KLJ678', 29, 1),
    (TO_DATE('2020-09-15', 'YYYY-MM-DD'), 'ZXY321', 30, 2),
    (TO_DATE('2012-01-20', 'YYYY-MM-DD'), 'UTS456', 31, 5),
    (TO_DATE('2017-05-15', 'YYYY-MM-DD'), 'VBN678', 32, 3),
    (TO_DATE('2019-10-19', 'YYYY-MM-DD'), 'QWE321', 33, 4),
    (TO_DATE('2021-02-20', 'YYYY-MM-DD'), 'RTY456', 34, 6),
    (TO_DATE('2020-01-15', 'YYYY-MM-DD'), 'ABD123', 5, 1),
    (TO_DATE('2013-05-20', 'YYYY-MM-DD'), 'XYZ456', 8, 2),
    (TO_DATE('2021-08-10', 'YYYY-MM-DD'), 'DEF789', 11, 1),
    (TO_DATE('2018-03-25', 'YYYY-MM-DD'), 'GHI012', 2, 3),
    (TO_DATE('2016-11-30', 'YYYY-MM-DD'), 'JKL345', 14, 2),
    (TO_DATE('2017-06-12', 'YYYY-MM-DD'), 'MNO678', 7, 1),
    (TO_DATE('2020-09-05', 'YYYY-MM-DD'), 'PQR901', 17, 3); 




-- type_piece

INSERT INTO type_piece (nom_type_piece)
VALUES 
    ('Moteur'),
    ('Électronique'),
    ('Transmission'),
    ('Freinage'),
    ('Suspension'),
    ('Éclairage'),
    ('Filtre à air'),
    ('Batterie'),
    ('Pneumatique'),
    ('Échappement'),
    ('Direction'),
    ('Carrosserie'),
    ('Intérieur');


--garage

INSERT INTO garage (nom_garage, tarif_horaire) 
VALUES
    ('Notre garages', 70),
    ('Garage Express',NULL),
    ('Garage AutoService',NULL),
    ('Garage Mécanique Rapide',NULL);

--prise en charge

INSERT INTO prise_en_charge (debut_prise_en_charge, fin_prise_en_charge, devis_annonce)
VALUES 
    (TO_DATE('2020-02-01', 'YYYY-MM-DD'), TO_DATE('2020-02-15', 'YYYY-MM-DD'), 56),
    (TO_DATE('2019-06-01', 'YYYY-MM-DD'), TO_DATE('2019-06-15', 'YYYY-MM-DD'), 123),
    (TO_DATE('2021-09-01', 'YYYY-MM-DD'), TO_DATE('2021-09-15', 'YYYY-MM-DD'), 345),
    (TO_DATE('2018-04-01', 'YYYY-MM-DD'), TO_DATE('2018-04-15', 'YYYY-MM-DD'), 678),
    (TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 890),
    (TO_DATE('2017-07-01', 'YYYY-MM-DD'), TO_DATE('2017-07-15', 'YYYY-MM-DD'), 1123),
    (TO_DATE('2020-10-01', 'YYYY-MM-DD'), TO_DATE('2020-10-15', 'YYYY-MM-DD'), 1456),
    (TO_DATE('2019-03-01', 'YYYY-MM-DD'), TO_DATE('2019-03-15', 'YYYY-MM-DD'), 1678),
    (TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-01-15', 'YYYY-MM-DD'), 1890),
    (TO_DATE('2018-08-01', 'YYYY-MM-DD'), TO_DATE('2018-08-15', 'YYYY-MM-DD'), 345),
    (TO_DATE('2020-02-01', 'YYYY-MM-DD'), TO_DATE('2020-02-15', 'YYYY-MM-DD'), 567),
    (TO_DATE('2019-06-01', 'YYYY-MM-DD'), TO_DATE('2019-06-15', 'YYYY-MM-DD'), 789),
    (TO_DATE('2021-09-01', 'YYYY-MM-DD'), TO_DATE('2021-09-15', 'YYYY-MM-DD'), 1001),
    (TO_DATE('2018-04-01', 'YYYY-MM-DD'), TO_DATE('2018-04-15', 'YYYY-MM-DD'), 1234),
    (TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-15', 'YYYY-MM-DD'), 1456),
    (TO_DATE('2017-07-01', 'YYYY-MM-DD'), TO_DATE('2017-07-15', 'YYYY-MM-DD'), 234),
    (TO_DATE('2020-10-01', 'YYYY-MM-DD'), TO_DATE('2020-10-15', 'YYYY-MM-DD'), 456),
    (TO_DATE('2022-04-01', 'YYYY-MM-DD'), TO_DATE('2022-04-15', 'YYYY-MM-DD'), 678),
    (TO_DATE('2021-08-01', 'YYYY-MM-DD'), TO_DATE('2021-08-15', 'YYYY-MM-DD'), 1123),
    (TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-06-15', 'YYYY-MM-DD'), 1345),
    (TO_DATE('2021-04-01', 'YYYY-MM-DD'), TO_DATE('2021-04-15', 'YYYY-MM-DD'), 1567),
    (TO_DATE('2022-06-01', 'YYYY-MM-DD'), TO_DATE('2022-06-15', 'YYYY-MM-DD'), 1789),
    (TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-15', 'YYYY-MM-DD'), 2000),
    (TO_DATE('2021-09-01', 'YYYY-MM-DD'), TO_DATE('2021-09-15', 'YYYY-MM-DD'), 789),
    (TO_DATE('2022-02-10', 'YYYY-MM-DD'), TO_DATE('2022-02-20', 'YYYY-MM-DD'), 1011),
    (TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-10', 'YYYY-MM-DD'), 1889),
    (TO_DATE('2020-11-25', 'YYYY-MM-DD'), TO_DATE('2020-12-05', 'YYYY-MM-DD'), 1667),
    (TO_DATE('2019-03-12', 'YYYY-MM-DD'), TO_DATE('2019-03-22', 'YYYY-MM-DD'), 1223),
    (TO_DATE('2021-07-01', 'YYYY-MM-DD'), TO_DATE('2021-07-15', 'YYYY-MM-DD'), 201),
    (TO_DATE('2020-09-05', 'YYYY-MM-DD'), TO_DATE('2020-09-20', 'YYYY-MM-DD'), 303),
    (TO_DATE('2022-01-15', 'YYYY-MM-DD'), TO_DATE('2022-01-25', 'YYYY-MM-DD'), 404),
    (TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2022-05-15', 'YYYY-MM-DD'), 505),
    (TO_DATE('2019-10-10', 'YYYY-MM-DD'), TO_DATE('2019-10-20', 'YYYY-MM-DD'), 606),
    (TO_DATE('2021-02-15', 'YYYY-MM-DD'), TO_DATE('2021-02-25', 'YYYY-MM-DD'), 707);


--mettre au garage

INSERT INTO mettre_au_garage (no_vehicule, no_prise_en_charge, kilometrage)
VALUES 
    (1, 1, 50403),
    (2, 2, 60907),
    (3, 3, 35412),
    (4, 4, 80109),
    (5, 5, 30314),
    (6, 6, 70218),
    (7, 7, 45921),
    (8, 8, 55826),
    (9, 9, 40529),
    (10, 10, 90933),
    (11, 11, 52537),
    (12, 12, 62141),
    (13, 13, 48646),
    (14, 14, 75650),
    (15, 15, 27955),
    (16, 16, 68459),
    (17, 17, 42364),
    (18, 18, 60606),
    (19, 19, 70707),
    (20, 20, 80808),
    (21, 21, 12121),
    (22, 22, 23232),
    (23, 23, 34343),
    (24, 24, 40404),
    (25, 25, 50505),
    (26, 26, 60606),
    (27, 27, 70707),
    (28, 28, 80808),
    (29, 29, 20101),
    (30, 30, 30303),
    (31, 31, 40404),
    (32, 32, 50505),
    (33, 33, 60606),
    (34, 34, 70707);



--interventions
--chaque vehicule a au moins une intervention dans notre garage

INSERT INTO interventions (nature_intervention, duree_intervention, date_intervention, no_vehicule, garage)
VALUES 
    ('Changement d''huile', 2, TO_DATE('2020-02-15', 'YYYY-MM-DD'), 1, 1),
    ('Réparation moteur', 3, TO_DATE('2019-06-15', 'YYYY-MM-DD'), 2, 1),
    ('Changement de freins', 4, TO_DATE('2021-09-15', 'YYYY-MM-DD'), 3, 1),
    ('Révision générale', 5, TO_DATE('2018-04-15', 'YYYY-MM-DD'), 4, 1),
    ('Diagnostic électronique', 6, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 5, 1),
    ('Réparation carrosserie', 7, TO_DATE('2017-07-15', 'YYYY-MM-DD'), 6, 1),
    ('Entretien climatisation', 8, TO_DATE('2020-10-15', 'YYYY-MM-DD'), 7, 1),
    ('Changement de batterie', 9, TO_DATE('2019-03-15', 'YYYY-MM-DD'), 8, 1),
    ('Réparation transmission', 10, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 9, 1),
    ('Changement de pneus', 11, TO_DATE('2018-08-15', 'YYYY-MM-DD'), 10, 1),
    ('Changement d''huile', 2, TO_DATE('2020-02-15', 'YYYY-MM-DD'), 11, 1),
    ('Réparation moteur', 3, TO_DATE('2019-06-15', 'YYYY-MM-DD'), 12, 1),
    ('Changement de freins', 4, TO_DATE('2021-09-15', 'YYYY-MM-DD'), 13, 1),
    ('Révision générale', 5, TO_DATE('2018-04-15', 'YYYY-MM-DD'), 14, 1),
    ('Diagnostic électronique', 6, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 15, 1),
    ('Réparation carrosserie', 7, TO_DATE('2017-07-15', 'YYYY-MM-DD'), 16, 1),
    ('Entretien climatisation', 8, TO_DATE('2020-10-15', 'YYYY-MM-DD'), 17, 1),
    ('Changement de batterie', 9, TO_DATE('2020-03-15', 'YYYY-MM-DD'), 5, 1),
    ('Réparation transmission', 10, TO_DATE('2019-03-15', 'YYYY-MM-DD'), 8, 2),
    ('Changement de pneus', 11, TO_DATE('2021-09-15', 'YYYY-MM-DD'), 11, 1),
    ('Changement d''huile', 2, TO_DATE('2018-05-15', 'YYYY-MM-DD'), 2, 3),
    ('Réparation moteur', 3, TO_DATE('2022-02-15', 'YYYY-MM-DD'), 14, 2),
    ('Changement de freins', 4, TO_DATE('2017-10-15', 'YYYY-MM-DD'), 7, 1),
    ('Révision générale', 5, TO_DATE('2020-11-15', 'YYYY-MM-DD'), 17, 3),
    ('Contrôle antipollution', 3, TO_DATE('2022-04-15', 'YYYY-MM-DD'), 18, 1),
    ('Remplacement pare-brise', 2, TO_DATE('2021-08-15', 'YYYY-MM-DD'), 19, 1),
    ('Peinture complète', 5, TO_DATE('2023-06-15', 'YYYY-MM-DD'), 20, 1),
    ('Installation système GPS', 1, TO_DATE('2021-04-16', 'YYYY-MM-DD'), 21, 1),
    ('Réparation système électrique', 2, TO_DATE('2022-06-21', 'YYYY-MM-DD'), 22, 1),
    ('Customisation carrosserie', 4, TO_DATE('2023-08-11', 'YYYY-MM-DD'), 23, 1),
    ('Installation audio haut de gamme', 4, TO_DATE('2021-09-16', 'YYYY-MM-DD'), 24, 1),
    ('Blindage de véhicule', 6, TO_DATE('2022-02-21', 'YYYY-MM-DD'), 25, 1),
    ('Aménagement intérieur personnalisé', 5, TO_DATE('2023-04-11', 'YYYY-MM-DD'), 26, 1),
    ('Calibrage de système de navigation', 3, TO_DATE('2020-12-06', 'YYYY-MM-DD'), 27, 1),
    ('Optimisation de performance moteur', 7, TO_DATE('2019-03-23', 'YYYY-MM-DD'), 28, 1),
    ('Réparation moteur', 3, TO_DATE('2021-07-15', 'YYYY-MM-DD'), 29, 1),
    ('Changement de freins', 4, TO_DATE('2020-09-20', 'YYYY-MM-DD'), 30, 1),
    ('Diagnostic électronique', 6, TO_DATE('2022-01-25', 'YYYY-MM-DD'), 31, 1),
    ('Changement de pneus', 2, TO_DATE('2022-05-15', 'YYYY-MM-DD'), 32, 1),
    ('Entretien climatisation', 3, TO_DATE('2019-10-20', 'YYYY-MM-DD'), 33, 1),
    ('Révision générale', 5, TO_DATE('2021-02-25', 'YYYY-MM-DD'), 34, 1),
    ('Révision générale', 9, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 5, 1);

--pieces

INSERT INTO pieces (nom_piece, prix_unitaire_piece, no_type_piece, no_intervention)
VALUES 
   
    ('Plaquette de frein avant', 40, 4,3),
    ('Porte avant gauche', 150, 12, 6),
    ('Filtre à air universel', 15, 7,7),
    ('Batterie standard', 60, 8, 8),
    ('Transmission automatique', 400, 3, 9),
    ('Pneu été', 80, 9,10),
    ('Piston', 50, 1,12),
    ('Plaquette de frein arrière', 40, 4,13),
    ('Porte avant gauche', 150, 12, 16),
    ('Filtre à air spécifique', 20,7, 17),
    ('Batterie standard', 60, 8, 18),
    ('Transmission automatique', 400, 3, 19),
    ('Pneu hiver', 100, 9,20),
    ('Joint de culasse', 35, 1, 22),
    ('Plaquette de frein arrière', 40, 4,23),
    ('Porte avant gauche', 150, 12, 29),
    ('Pare-brise', 100, 12, 26),
    ('Peinture', 200, 12, 27),
    ('Module électronique GPS', 120, 2, 28),
    ('Caisson de basse', 120, 2, 31),
    ('Vitre blindée', 150, 12, 32),
    ('Piston', 40, 1,36),
    ('Plaquette de frein arrière', 40, 4,37),
    ('Pneu été', 80, 9,39),
    ('Filtre à air spécifique', 20, 7,40),
    ('Huile', 20, 1, 1);
