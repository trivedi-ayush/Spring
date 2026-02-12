pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "dockerayush2001/spring-app"
        DOCKER_TAG   = "latest"
        KUBE_CONFIG  = "$HOME/.kube/config"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: '2fc54ca6-c1a8-4fc8-97d4-4c78ebf29c77',
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
                    credentialsId: 'dockerhub-creds',
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


         stage('Check Minikube') {
            steps {
                sh '''
                  minikube status
                  kubectl cluster-info
                '''
            }
        }

        stage('Deploy to Minikube') {
            steps {
                sh '''
                  kubectl apply -f k8s/deployment.yaml
                  kubectl rollout status deployment/spring-app
                '''
            }
        }

         stage('Verify Deployment') {
            steps {
                sh '''
                  kubectl get pods
                  kubectl get svc
                '''
            }
        }
    }
}
