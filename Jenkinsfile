pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "dockerayush2001/spring-app"
        DOCKER_TAG   = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: '3c720d67-5ee0-4068-8c34-f6c53ea90662',
                    url: 'https://github.com/trivedi-ayush/Spring.git'
            }
        }

        stage('Verify Java') {
            steps {
                sh 'java -version'
                sh 'mvn -version'
            }
        }

        stage('Build Spring Boot JAR') {
            steps {
                sh 'mvn clean package -DskipTests -B'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                  docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                """
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'fcbe14fb-a6b9-4d4c-a57b-8b3f3b5dfec0',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh """
                      echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                  docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                """
            }
        }
    }
}
