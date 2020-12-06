def dockerImage=''
pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                step([$class: 'WsCleanup'])
                checkout scm
            }
        }
        stage('Docker Build') {
            dockerImage = "yuvaraju1729/build:$BUILD_NUMBER"
            steps {
                sh '''
                    docker --version
                    docker build -t "${dockerImage}" .
                '''
            }
        }       
    }
}
