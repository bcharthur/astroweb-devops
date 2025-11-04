pipeline {
  agent any

  environment {
    APP_NAME = "demo-app"
    ENV      = "dev"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build & Tests') {
      steps {
        sh 'echo TODO: lancer tests unitaires et lint ici'
      }
    }

    stage('Deploy') {
      steps {
        script {
          def composeFile = "/opt/devops/apps/${env.APP_NAME}/${env.ENV}/docker-compose.yml"
          echo "[+] Deploiement ${env.APP_NAME} sur ${env.ENV}..."
          sh "docker compose -f ${composeFile} pull || true"
          sh "docker compose -f ${composeFile} up -d --build"
        }
      }
    }
  }
}
