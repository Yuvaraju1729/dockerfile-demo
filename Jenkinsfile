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
                   
                    sudo systemctl start docker
                    sudo service docker start
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
                    docker.withRegistry( '', registryCredential ) {    
                        sh '''
                            if [ $(docker ps -qf "name=appnode") ]
                            then
                                echo "from if block"
                                docker kill appnode && docker rm appnode
                                docker run -d -p 4321:8080 --name application "${dockerRepo}:${BUILD_NUMBER}"
                                docker ps
                            else
                                echo "from else block"
                                docker run -d -p 4321:8080 --name appnode "${dockerRepo}:${BUILD_NUMBER}"
                                docker ps
                            fi
                        '''
                    }
                    sudo systemctl start docker
                    sudo service docker start
                }
            }
        }
    }
}
