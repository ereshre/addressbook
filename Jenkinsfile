pipeline {
    agent any

    //tools {
    //    // Install the Maven version configured as "M3" and add it to the path.
    //    maven "M3"
    //}

    stages {
        stage('Compile') {
            steps {
                script {
                    echo "Compiling"
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    echo "Executing TCs"
                }
            }
        }
        stage('Package') {
            steps {
                script {
                    echo "Packaging"
                }
            }
        }
    }
    
}
