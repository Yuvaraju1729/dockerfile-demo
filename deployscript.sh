if [ $(docker ps -aqf "name=$3") ]
then
    docker kill appnode && docker rm appnode
    docker run -d -p 4321:8080 --name appnode "$1:$2"
    docker ps
else
    docker run -d -p 4321:8080 --name appnode "$1:$2"
    docker ps
fi
