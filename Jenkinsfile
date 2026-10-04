node {
    stage('SCM') {
        checkout scm
    }

    stage('Build & Test') {
        sh 'python3 -m unittest discover -v'
    }

    stage('SonarQube Analysis') {
        def scannerHome = tool 'SonarScanner'
        withSonarQubeEnv() {
            sh "${scannerHome}/bin/sonar-scanner"
        }
    }

    stage('Docker Build') {
        sh 'docker build -t rohitmch/week12-cicd-app:latest .'
    }
}
