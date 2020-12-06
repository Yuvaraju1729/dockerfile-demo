pipeline {
    environment {
        image = "yuvaraju1729/build"
        registryCredential = 'uv-docker-hub-creds'
        dockerImage = ''
    }
    agent any
    def app= ''
    stages {
        stage('Clone') {
            steps {
                step([$class: 'WsCleanup'])
                checkout scm
            }
        }
        stage('Docker Build') {
            steps {
                script {   
                    dockerImage = docker.build "yuvaraju1729/build:${BUILD_NUMBER}"
                }              
            }
        }       
    }
}
