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
                // adding testing comment
                script { 
                    try{
                        docker.withRegistry( '', registryCredential ) {    
                            sh '''
                                if [ $(docker ps -aqf "name=appnode") ]
                                then
                                    echo "from if block"
                                    docker kill appnode && docker rm appnode
                                    docker run -d -p 4321:8080 --name appnode "${dockerRepo}:${BUILD_NUMBER}"
                                    docker ps
                                else
                                    echo "from else block"
                                    docker run -d -p 4321:8080 --name appnode "${dockerRepo}:${BUILD_NUMBER}"
                                    docker ps
                                fi
                            '''
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
