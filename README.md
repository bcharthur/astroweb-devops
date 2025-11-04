# astroweb DevOps bootstrap

Repo de bootstrap pour un environnement DevOps complet (Docker, Jenkins, Jira)
pour l'équipe **astroweb**.

## Usage rapide

```bash
# Cloner ce repo
git clone https://github.com/bcharthur/astroweb-test.git
cd astroweb-test

# Construire l'image "faux VPS"
docker build -t astroweb-devops:latest .

# Lancer le conteneur "VPS" en local
# Si ton repo GitHub est privé, passe ton user + un token en variables d'env :
docker run -it --rm   --name astroweb-devops   --privileged   -e GITHUB_USER=bcharthur   -e GITHUB_TOKEN=ghp_xxx_ton_token_personnel   -v /var/run/docker.sock:/var/run/docker.sock   -v astroweb-devops-data:/opt/devops   astroweb-devops:latest

# Si le repo est public, tu peux omettre GITHUB_USER / GITHUB_TOKEN.
```

À la fin du bootstrap, tu auras :
- Jenkins dispo sur `http://<IP_HOST>:8080`
- Jira dispo sur `http://<IP_HOST>:8085`
- Une arbo `/opt/devops/apps/demo-app/{dev,recette,prod}`
