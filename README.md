# 🚀 LearningDockerCompose : Projet Pédagogique Docker & Docker Compose

Bienvenue dans mon petit laboratoire Docker ! Ce projet a été conçu pour m’initier et expérimenter différentes fonctionnalités de Docker et Docker Compose, tout en créant un environnement full-stack fonctionnel et modulaire.  

L’idée principale ? Monter un petit écosystème avec :  
- une base de données MySQL avec PHPMyAdmin,  
- deux versions d’une API `devops` derrière un reverse-proxy Nginx,  
- un système de backups automatisé,  
- SonarQube pour l’analyse de la qualité du code.  

Le tout orchestré avec Docker Compose pour simplifier le lancement, la gestion et la destruction de l’environnement.

---

## 🎯 Objectifs pédagogiques

- Découvrir le fonctionnement des volumes, réseaux, healthchecks, builds personnalisés.  
- Comprendre comment gérer des dépendances entre services (depends_on et condition: service_healthy).  
- Expérimenter l’exposition de ports, le reverse-proxy et la communication inter-conteneurs.  
- Tester des stratégies de persistance et de sauvegarde de données (bind mount, volumes persistants).  
- Intégrer un outil de qualité de code (SonarQube) pour un projet full-stack complet.

---

## 🛠️ Features Docker testées

- Docker Networks : api, data, sonar pour séparer les communications et sécuriser les services.  
- Volumes persistants :  
  - data-persist pour MySQL,  
  - data-backups pour les sauvegardes,  
  - data-sonar-bd et data-sonar-app pour SonarQube.  
- Healthchecks pour assurer que chaque service est prêt avant de lancer ses dépendants.  
- Multi-service orchestration avec depends_on et conditions de santé.  
- Builds personnalisés pour les images devops-v1, devops-v2 et backups.  
- Reverse-proxy Nginx pour router les API et permettre un accès unifié.  
- Exposition des ports pour PHPMyAdmin (8080) et SonarQube (9000).  

---

## ⚡ Exécution du projet

1. Se positionner dans le répertoire infrastructure.
```
cd infrastructure
```
2. Lancer tous les services avec Docker Compose.
```
docker compose up
```
3. Pour stopper temporairement les conteneurs.
```
docker compose stop
```
4. Pour détruire l’ensemble du projet et les volumes associés.
```
docker compose down -v
```

---

## 💡 Choix de développement et ergonomie

Dans ce projet, chaque décision a été pensée pour faciliter l’interaction, la maintenance et la portabilité. Voici les points principaux :  

### 1️⃣ Séparation des réseaux
- Réseaux dédiés (api, data, sonar) : chaque type de trafic est isolé.  
  - api pour les services exposés au reverse-proxy,  
  - data pour les bases de données et backups,  
  - sonar pour SonarQube.  
- Avantage : sécurité accrue, meilleure organisation et réduction du risque de conflit ou de fuite d’information entre services.  

### 2️⃣ Volumes persistants
- Persistance des données critiques : MySQL, SonarQube et les backups ont leurs propres volumes (data-persist, data-sonar-bd, data-sonar-app, data-backups).  
- Avantage : possibilité d’arrêter et de relancer les conteneurs sans perdre les données. Les backups montés via bind mount permettent également de tester des stratégies de récupération.

### 3️⃣ Healthchecks
- Chaque service critique dispose d’un healthcheck : MySQL ping, API devops accessible, SonarQube prêt.  
- Avantage : assure que les dépendances sont prêtes avant de lancer un service qui en dépend, réduisant les erreurs et rendant l’environnement plus stable.

### 4️⃣ Dépendances explicites (depends_on + condition)
- Les services comme devops-v1, devops-v2 et backups ne se lancent que lorsque MySQL est opérationnel.  
- Avantage : simplifie le déploiement et rend le comportement reproductible, crucial pour l’interaction côté client ou pour un déploiement en production simulé.

### 5️⃣ Reverse-proxy Nginx
- Centralise l’accès aux différentes versions de l’API.  
- Permet de tester facilement plusieurs versions (v1, v2) sans modifier les configurations côté client.  
- Avantage : ergonomie maximale pour l’utilisateur/testeur et démonstration claire des différentes versions d’un service.

### 6️⃣ Builds personnalisés
- Les images devops et backups sont construites à partir de Dockerfiles spécifiques.  
- Avantage : contrôle total de l’environnement, facilité de modification et portabilité. Toute personne récupérant le projet peut reconstruire exactement les mêmes services.

### 7️⃣ Exposition des ports et interface utilisateur
- PHPMyAdmin accessible sur 8080, SonarQube sur 9000.  
- Avantage : permet un accès direct aux outils pour inspection, analyse et tests, sans configuration complexe côté client.  

### 8️⃣ Modularité et maintenance
- Chaque service est indépendant et modulaire, ce qui permet de mettre à jour, remplacer ou tester un composant sans impacter le reste.  
- Avantage : facilite les expériences pédagogiques et montre une approche professionnelle de l’orchestration Docker.

---