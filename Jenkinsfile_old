pipeline {
    agent any

    stages {
        stage('1-Build') {
            steps {
                echo '---Build start---'
                sh 'echo "Build by Jenkins Build number: ${BUILD_ID}" >> index.html'
                sh 'echo "Host_port: ${HOST_PORT}" >> index.html'
                sh "docker build -t ${IMAGE_NAME} ."   
            }
        }
        stage('2-Test') {
            steps {
                echo '---TEST---'
                sh "docker images | grep ${IMAGE_NAME}"
            }
        }
        stage('3-Deploy') {
            steps {
                echo '---Deploy---'
                sh "docker stop ${CONTAINER_NAME} || sleep 2"
                sh "docker run -d --rm --name ${CONTAINER_NAME} -p $HOST_PORT:5000 ${IMAGE_NAME}"
            }
        }
    }
}
