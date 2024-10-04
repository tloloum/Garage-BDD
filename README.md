# Projet de SGBD : Entretien de véhicules (Garage)

L’objectif du projet est de mettre en œuvre, sur un cas pratique, les notions et les méthodes vues dans le module SGBD. Le projet démarre par une modélisation des données, et aboutit à la création d’une base de données relationnelle et à l’implémentation d’un certain nombre d’opérations (consultations, mises à jour, etc.).

## Pour commencer

L'arborescence se compose très simplement :

- d'un dossier /sql contenant les fichiers .sql
- d'un dossier /src contenant les fichiers .php, .css et autres images
- du rapport de projet en .pdf
- de ce README.md

Au sein du dossier /sql vous retrouverez :

- create.sql pour la création des tables, les contraintes, les triggers
- insert.sql pour remplir les tables
- select.sql avec les requetes de consultations et de statistiques
- update.sql avec les requetes de mise à jour
- drop.sql pour relacher les tables

### Pré-requis

- PostgreSQL
- PSQL

### Installation

A l'aide de psql :

1- CREATE DATABASE garage;

Dans un deuxième temps :

2- psql -d garage

Dans psql:

3- \i sql/create.sql

4- \i sql/insert.sql

### Visualisation de la page web

La page web est hébergée sur le serveur tloloum.zzz.bordeaux-inp.fr.

Pensez à vous connecter au wifi Bordeaux INP pour y accéder.

Si jamais le serveur ne fonctionne pas :

- php -S localhost:8000 (dans le dossier src après avoir inscrit ses indentifiants dans le "src/connect_pg.php")

## Fabriqué avec

- [PostgreSQL] - Système de gestion de base de données
- [PHP] - Interaction avec la BDD
- [HTML/CSS] - Page web

## Auteurs

- **Théophane Loloum**
- **Sam Gubernator**
- **Quentin Chavigny--Turbé**
- **Arthur Hermitte**
