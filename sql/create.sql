CREATE TABLE clients
(
    no_client SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50)  NOT NULL,
    adresse VARCHAR(100) NOT NULL,
    telephone VARCHAR(10) NOT NULL,
    email VARCHAR(50) NOT NULL
);

CREATE TABLE type_vehicule
(
    no_type_vehicule SERIAL PRIMARY KEY,
    modele VARCHAR(50) NOT NULL
);

CREATE TABLE vehicules
(
    no_vehicule SERIAL PRIMARY KEY,
    date_mise_circulation DATE NOT NULL,
    immatriculation VARCHAR(10) NOT NULL,
    no_client INTEGER REFERENCES clients(no_client) NOT NULL,
    no_type_vehicule INTEGER REFERENCES type_vehicule(no_type_vehicule) NOT NULL
);

CREATE TABLE prise_en_charge
(
    no_prise_en_charge SERIAL PRIMARY KEY,
    debut_prise_en_charge DATE NOT NULL,
    fin_prise_en_charge DATE NOT NULL,
    devis_annonce INTEGER NOT NULL
);

CREATE TABLE garage 
(
    no_garage SERIAL PRIMARY KEY,
    nom_garage VARCHAR(50) NOT NULL,
    tarif_horaire INTEGER
);

CREATE TABLE interventions
(
    no_intervention SERIAL PRIMARY KEY,
    nature_intervention VARCHAR(50) NOT NULL,
    duree_intervention INTEGER NOT NULL,
    date_intervention DATE NOT NULL,
    no_vehicule INTEGER REFERENCES vehicules(no_vehicule) NOT NULL,
    garage INTEGER REFERENCES garage(no_garage)
);

CREATE TABLE mettre_au_garage
(
    no_vehicule INTEGER REFERENCES vehicules(no_vehicule) NOT NULL,
    no_prise_en_charge INTEGER REFERENCES prise_en_charge(no_prise_en_charge) NOT NULL,
    kilometrage INTEGER NOT NULL,
    PRIMARY KEY (no_vehicule, no_prise_en_charge)
);

CREATE TABLE type_piece
(
    no_type_piece SERIAL PRIMARY KEY,
    nom_type_piece VARCHAR(50) NOT NULL
);

CREATE TABLE utiliser
(
    no_type_vehicule INTEGER REFERENCES type_vehicule(no_type_vehicule) NOT NULL,
    no_type_piece INTEGER REFERENCES type_piece(no_type_piece) NOT NULL,
    PRIMARY KEY (no_type_vehicule, no_type_piece)
);

CREATE TABLE pieces
(
    no_piece SERIAL PRIMARY KEY,
    nom_piece VARCHAR(50) NOT NULL,
    prix_unitaire_piece INTEGER NOT NULL,
    no_type_piece INTEGER REFERENCES type_piece(no_type_piece) NOT NULL,
    no_intervention INTEGER REFERENCES interventions(no_intervention) NOT NULL
);

-- Et maintenant ... Les contraintes d'intégrité

-- Contraintes de cohérence des dates de prise en charge
CREATE OR REPLACE FUNCTION check_dates_prise_en_charge()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.debut_prise_en_charge >= NEW.fin_prise_en_charge THEN
        RAISE EXCEPTION 'La date de début de prise en charge (%) doit être antérieure à la date de fin de prise en charge (%)', NEW.debut_prise_en_charge, NEW.fin_prise_en_charge;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_dates_prise_en_charge
BEFORE INSERT OR UPDATE ON prise_en_charge
FOR EACH ROW
EXECUTE FUNCTION check_dates_prise_en_charge();



-- Contraintes de cohérence des informations de garage
-- Le tarif horaire ne peut être renseigné que si c'est notre garage
ALTER TABLE garage
ADD CONSTRAINT check_garage
CHECK (
    (no_garage = 1 AND tarif_horaire IS NOT NULL)
    OR
    (no_garage != 1 AND tarif_horaire IS NULL)
);

-- Contrainte vérifiant que la date de mise en circulation est antérieure à la date d'intervention

CREATE OR REPLACE FUNCTION check_date_intervention_cohérente()
RETURNS TRIGGER AS $$
DECLARE
    date_mise_circulation_vehicule DATE;
BEGIN
    SELECT INTO date_mise_circulation_vehicule date_mise_circulation 
    FROM vehicules 
    WHERE no_vehicule = NEW.no_vehicule;

    IF NEW.date_intervention <= date_mise_circulation_vehicule THEN
        RAISE EXCEPTION 'La date d''intervention (%) doit être postérieure à la date de mise en circulation du véhicule (%)', NEW.date_intervention, date_mise_circulation_vehicule;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_date_intervention_cohérente
BEFORE INSERT OR UPDATE ON interventions
FOR EACH ROW
EXECUTE FUNCTION check_date_intervention_cohérente();



-- Contrainte vérifiant que le kilométrage est cohérent
-- (le kilométrage doit être supérieur au kilométrage de la dernière prise en charge)
CREATE OR REPLACE FUNCTION check_kilometrage_cohérent()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.kilometrage <= (
        SELECT MAX(mag.kilometrage)
        FROM mettre_au_garage mag
        WHERE mag.no_vehicule = NEW.no_vehicule
        AND mag.no_prise_en_charge != NEW.no_prise_en_charge
    ) THEN
        RAISE EXCEPTION 'Le kilométrage doit être supérieur au kilométrage de la dernière prise en charge';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_kilometrage_cohérent
BEFORE INSERT OR UPDATE ON mettre_au_garage
FOR EACH ROW
EXECUTE FUNCTION check_kilometrage_cohérent();


-- Contrainte vérifiant que si un véhicule est en base, alors il y a une prise en charge associée

CREATE OR REPLACE FUNCTION check_prise_en_charge_vehicule()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM vehicules
        WHERE no_vehicule = NEW.no_vehicule
    ) THEN
        RAISE EXCEPTION 'La prise en charge doit être associée à un véhicule existant';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_prise_en_charge_vehicule
BEFORE INSERT OR UPDATE ON mettre_au_garage
FOR EACH ROW
EXECUTE FUNCTION check_prise_en_charge_vehicule();



-- Contrainte vérifiant que si un client est en base, alors il y a un véhicule associé

CREATE OR REPLACE FUNCTION check_vehicule_client()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM clients
        WHERE no_client = NEW.no_client
    ) THEN
        RAISE EXCEPTION 'Chaque véhicule doit être associé à un client existant';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_vehicule_client
BEFORE INSERT OR UPDATE ON vehicules
FOR EACH ROW
EXECUTE FUNCTION check_vehicule_client();





