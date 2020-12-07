pipeline {
    environment {
        dockerRepo = "yuvaraju1729/docker-demo"
        registryCredential = 'uv-docker-hub-creds'
        dockerImage = ''
    }
    agent any
    stages {
        stage('Docker Build') {
            steps {
                script {
                    
                        def dockerHome = tool 'docker-runner'
                        env.PATH = "${dockerHome}/bin:${env.PATH}"
                        dockerImage = docker.build dockerRepo+":${BUILD_NUMBER}"
                }              
            }
        } 
        stage('Uploading Image') {
          steps{    
               script {
                      docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                      }
               }
          }
        }
        stage('Deploying Image'){
            steps{
                	
                //withCredentials([usernamePassword(credentialsId: 'uv-docker-hub-creds', passwordVariable: 'pwd', usernameVariable: 'user')]) {
                                            //docker login --username "${user}" --password "${pwd}" 'https://index.docker.io/v1/'
                script { 
                    try{
                        docker.withRegistry( '', registryCredential ) {    
                            sh './deployscript.sh' 'appnode' "${dockerRep}" "${BUILD_NUMBER}"
                        }
                    }
                    catch(Exception err){
                        echo "problem in deployment, error is:"+err.toString()
                    }
                }
            }
        }
    }
}
