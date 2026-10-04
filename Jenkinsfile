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
        sh '''
            /Applications/Docker.app/Contents/Resources/bin/docker build -t rohitmch/week12-cicd-app:latest .
        '''
    }

    stage('Docker Push') {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-credentials',
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_PASSWORD'
        )]) {
            sh '''
                echo "$DOCKER_PASSWORD" | /Applications/Docker.app/Contents/Resources/bin/docker login -u "$DOCKER_USERNAME" --password-stdin
                /Applications/Docker.app/Contents/Resources/bin/docker push rohitmch/week12-cicd-app:latest
                /Applications/Docker.app/Contents/Resources/bin/docker logout
            '''
        }
    }
}
