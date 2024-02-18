pipeline {
    agent any

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }

    stages {
        stage('Compile') {
            steps {
                script {
                    echo "Compiling"
                    sh "mvn compile"
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    echo "Executing TCs"
                    sh "mvn test"
                }
            }
        }
        stage('Package') {
            steps {
                script {
                    echo "Packaging"
                    sh "mvn package"
                }
            }
        }
    }
    
}
