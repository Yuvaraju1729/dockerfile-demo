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
            steps {
                sh '''
                    docker --version
                    dockerImage = docker build -t "yuvaraju1729/build:$BUILD_NUMBER" .
                '''
            }
        }       
    }
}
