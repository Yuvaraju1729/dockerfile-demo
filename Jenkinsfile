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
                sh '''
                    docker login -u 'yuvaraju1729' -p 'Yuvaraju@333143' 'https://index.docker.io/v1/'
                    if [ $(docker ps -qf "name=appnode") ]
                    then
                        echo "from if block"
                        docker kill appnode && docker rm appnode
                        docker run -d -p 4321:8080 --name application "${registry}"
                        docker ps
                    else
                        echo "from else block"
                        docker run -d -p 4321:8080 --name appnode "${registry}"
                        docker ps
                    fi
                '''
            }
        }
    }
}
