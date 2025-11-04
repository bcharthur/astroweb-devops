pipeline {
    agent any

    environment {
        APP_NAME = "demo-app"
        BASE_DIR = "/opt/devops/apps"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Tests') {
            steps {
                sh 'echo "TODO: lancer tests unitaires et lint ici"'
            }
        }

        stage('Deploy') {
            when {
                anyOf {
                    branch 'dev'
                    branch 'recette'
                    branch 'prod'
                }
            }
            steps {
                script {
                    def envName = ""
                    if (env.BRANCH_NAME == "dev")      envName = "dev"
                    if (env.BRANCH_NAME == "recette")  envName = "recette"
                    if (env.BRANCH_NAME == "prod")     envName = "prod"

                    def composeFile = "${BASE_DIR}/${APP_NAME}/${envName}/docker-compose.yml"

                    sh """
                      echo '[+] Deploiement ${APP_NAME} sur ${envName}...'
                      docker compose -f ${composeFile} pull || true
                      docker compose -f ${composeFile} up -d --build
                    """

                    // Option : MAJ Jira si la clé est dans le dernier commit
                    def jiraKey = sh(
                      script: "git log -1 --pretty=%B | grep -oE '[A-Z]+-[0-9]+' | head -n1 || true",
                      returnStdout: true
                    ).trim()

                    if (jiraKey) {
                        def status = envName.toUpperCase() + "_DEPLOYE"
                        sh "/opt/devops-bootstrap/scripts/jira-transition.sh ${jiraKey} ${envName} ${status} || true"
                    }
                }
            }
        }
    }
}
