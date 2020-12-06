def dockerImage="yuvaraju1729/build:$BUILD_NUMBER"
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
            steps {
                sh '''
                    docker --version
                    docker build -t "${dockerImage}" .
                '''
            }
        }       
    }
}
