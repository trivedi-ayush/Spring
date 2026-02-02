pipeline {
    agent any

    options {
        timeout(time: 15, unit: 'MINUTES')
    }

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
        PATH = "${JAVA_HOME}/bin:${PATH}"

        DOCKER_IMAGE = "dockerhub_username/spring-boot-app"
        DOCKER_TAG = "latest"
    }

    stages {

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

    post {
        success {
            echo '✅ JAR built, Docker image created & pushed successfully 🚀'
        }
        failure {
            echo '❌ Pipeline failed'
        }
        always {
            sh 'docker logout || true'
        }
    }
}
