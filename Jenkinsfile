pipeline {
    agent any
    environment {
        DOCKER_HOST="unix://\$(pwd)/docker.sock"
        STAGE_INSTANCE="root@35.180.21.14"
    }
    stages {
        stage('Setup SSH tunnel') {
            steps {
                script {
                    sh "ssh -i /var/lib/jenkins/jenkins -nNT -L \$(pwd)/docker.sock:/var/run/docker.sock ${STAGE_INSTANCE} & echo \$! > /tmp/tunnel.pid"
                    sleep 5
                }
            }
        }
        stage('1-Build') {
            steps {
                echo '---Build start---'
                sh 'echo "Build by Jenkins Build number: ${BUILD_ID}" >> index.html'
                sh 'echo "Host_port: ${HOST_PORT}" >> index.html'
                sh "DOCKER_HOST=${DOCKER_HOST} docker ps -a"
                sh "DOCKER_HOST=${DOCKER_HOST} docker build -t ${IMAGE_NAME} ."   
            }
        }
        stage('2-Test') {
            steps {
                echo '---TEST---'
                sh "DOCKER_HOST=${DOCKER_HOST} docker images | grep ${IMAGE_NAME}"
            }
        }
        stage('3-Deploy') {
            steps {
                echo '---Deploy---'
                sh "DOCKER_HOST=${DOCKER_HOST} docker stop ${CONTAINER_NAME} || sleep 2"
                sh "DOCKER_HOST=${DOCKER_HOST} docker run -d --rm --name ${CONTAINER_NAME} -p $HOST_PORT:5000 ${IMAGE_NAME}"
                sh "rm \$(pwd)/docker.sock"
            }
        }
    }
    post {
        always {
            script {
                sh "pkill -F /tmp/tunnel.pid"
                sh "rm /tmp/tunnel.pid"
           }
       }
    }
}

