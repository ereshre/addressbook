pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    environment{
        BUILD_SERVER='ec2-user@172.31.7.226'
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
            agent {label 'linux_slave'}
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
            agent any
            steps {
                script {
                    sshagent(['slave2']) {
                        echo "Packaging"
                        sh "scp -o StrictHostKeyChecking=no server-config.sh $BUILD_SERVER:/home/ec2-user"
                        sh "ssh -o StrictHostKeyChecking=no $ BUILD_SERVER 'bash server-config.sh'"
                    }
                }
            }
        }
    }
    
}
