# astroweb-devops - TP Jenkins + Docker Compose v2

Ce zip contient :
- `jenkins/Dockerfile` : image Jenkins custom qui embarque Docker + docker compose v2
- `jenkins/docker-compose.yml` : stack Jenkins à déployer sur le VPS
- `apps/demo-app/dev/docker-compose.yml` : docker-compose de la demo-app pour l'environnement *dev*
- `Jenkinsfile` : pipeline de déploiement (branche `dev`)

## 1. Installation sur le VPS

```bash
# sur le VPS
sudo mkdir -p /opt/devops
sudo chown -R $(whoami):$(whoami) /opt/devops

# copier le contenu de ce zip dans /opt/devops
# on doit donc avoir :
# /opt/devops/jenkins/...
# /opt/devops/apps/demo-app/dev/docker-compose.yml
```

### Build + run Jenkins

```bash
cd /opt/devops/jenkins
docker-compose build --no-cache
docker-compose up -d
```

Jenkins sera dispo sur `http://<IP_VPS>:8080`.

## 2. Premier démarrage Jenkins

```bash
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Copier ce mot de passe dans l'UI Jenkins pour finir le setup.

## 3. Configuration du job multibranche

- Créer un job *Multibranch Pipeline* `astroweb-devops`
- Configurer le repo GitHub : `https://github.com/bcharthur/astroweb-devops`
- Laisser Jenkins découvrir la branche `dev` (qui contient le `Jenkinsfile` de ce zip)

## 4. Déploiement de la demo-app

Le stage *Deploy* utilise :

```bash
docker compose -f /opt/devops/apps/demo-app/dev/docker-compose.yml pull || true
docker compose -f /opt/devops/apps/demo-app/dev/docker-compose.yml up -d --build
```

Assure-toi que :
- le chemin `/opt/devops/apps/demo-app/dev/docker-compose.yml` existe bien sur le VPS
- le port 8081 n'est pas utilisé (la demo-app est exposée sur `http://<IP_VPS>:8081`)
