pipeline {
    agent any

    tools {
        jdk 'Java21'
        maven 'Maven3'
    }

    options {
        timeout(time: 15, unit: 'MINUTES')
    }

    stages {
        stage('Build Spring Boot JAR') {
            steps {
                sh 'mvn clean package -DskipTests -B'
            }
        }
    }

    post {
        success {
            echo '✅ Spring Boot JAR built successfully'
        }
        failure {
            echo '❌ Build failed'
        }
    }
}
