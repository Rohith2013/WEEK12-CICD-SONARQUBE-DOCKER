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
            export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
            docker build -t rohithemc/week12-cicd-app:latest .
        '''
    }

    stage('Docker Push') {
        withCredentials([usernamePassword(
            credentialsId: 'dockerhub-credentials',
            usernameVariable: 'DOCKER_USERNAME',
            passwordVariable: 'DOCKER_PASSWORD'
        )]) {
            sh '''
                export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
                echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                docker push rohithemc/week12-cicd-app:latest
                docker logout
            '''
        }
    }

    stage('Deploy') {
        sh '''
            export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
            docker rm -f week12-cicd-app || true
            docker run --name week12-cicd-app --rm rohithemc/week12-cicd-app:latest
        '''
    }
}
