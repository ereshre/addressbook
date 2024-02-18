pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            agent any
            steps {
                script {
                    echo "Compiling"
                    sh "mvn compile"
                }
            }
        }
        stage('Test') {
            agent any
            steps {
                script {
                    echo "Executing TCs"
                    sh "mvn test"
                }
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        stage('Package') {
            agent {label 'linux_slave'}
            steps {
                script {
                    echo "Packaging"
                    sh "mvn package"
                }
            }
        }
    }
    
}
