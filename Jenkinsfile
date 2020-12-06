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
                sh 'docker --version'
            }
        }
    }
}
