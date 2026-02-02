pipeline {
    agent any

    tools {
        jdk 'Java21'
        maven 'Maven3'
    }

    options {
        timeout(time: 15, unit: 'MINUTES')
    }

      environment {
        JAVA_HOME = '/usr/lib/jvm/java-21-openjdk-amd64'
        PATH = "${JAVA_HOME}/bin:${PATH}"
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
