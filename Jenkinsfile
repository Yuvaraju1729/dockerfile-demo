pipeline {
    environment {
        dockerRepo = "yuvaraju1729/docker-demo"
        registryCredential = 'uv-docker-hub-creds'
        dockerImage = ''
    }
    agent any
    stages {
        /*stage('Clone') {
            steps {
                step([$class: 'WsCleanup'])
                checkout scm
            }
        }
        */
        stage('Docker Build') {
            steps {
                script {
                    def dockerHome = tool 'docker-runner'
                    env.PATH = "${dockerHome}/bin:${env.PATH}"
                    dockerImage = docker.build dockerRepo+":${BUILD_NUMBER}"
                }              
            }
        }       
    }
}
