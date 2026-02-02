pipeline {
    agent any

    options {
        timeout(time: 15, unit: 'MINUTES')
    }

    environment {
        JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
        PATH = "${JAVA_HOME}/bin:${PATH}"
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
