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
            export PATH="/Users/rohitm/.docker/bin:$PATH"
            docker build -t rohitmch/week12-cicd-app:latest .
        '''
    }

    stage('Docker Push') {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-credentials',
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_PASSWORD'
        )]) {
            sh '''
                export PATH="/Users/rohitm/.docker/bin:$PATH"
                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                docker push rohitmch/week12-cicd-app:latest
                docker logout
            '''
        }
    }
}
