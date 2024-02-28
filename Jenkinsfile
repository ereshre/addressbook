pipeline {
    agent none

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "mymaven"
    }
    environment{
        BUILD_SERVER='ec2-user@172.31.2.221'
        DEPLOY_SERVER='ec2-user@172.31.10.201'
        IMAGE_NAME='ereshre/java-mvn-privaterepo'
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
            //agent {label 'linux_slave'}
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
        stage('Containerise+push the image to registry') {
            agent any
            steps {
                script {
                    sshagent(['slave2']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                            echo "Containerise and push the image to registry"
                            sh "scp -o StrictHostKeyChecking=no server-config.sh ${BUILD_SERVER}:/home/ec2-user"
                            sh "ssh -o StrictHostKeyChecking=no ${BUILD_SERVER} 'bash server-config.sh' ${IMAGE_NAME} ${BUILD_NUMBER}"
                            sh "ssh ${BUILD_SERVER} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                            sh "ssh ${BUILD_SERVER} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                        }
                    }
                }
            }
        }

        stage('Deploy docker container') {
            agent any
            steps {
                script {
                    sshagent(['slave2']) {
                        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                            echo "Run the docker container"
                            sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} sudo yum install docker"
                            sh "ssh -o StrictHostKeyChecking=no ${DEPLOY_SERVER} sudo systemctl start docker"
                            sh "ssh ${DEPLOY_SERVER} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                            sh "ssh ${DEPLOY_SERVER} sudo docker run -itd -P ${IMAGE_NAME}:${BUILD_NUMBER}"
                        }
                    }
                        
                }
            }

        }
    }
    
}
