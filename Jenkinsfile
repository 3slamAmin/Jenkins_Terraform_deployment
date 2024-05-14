pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY    = credentials('aws_secret_access_key')
        AWS_SESSION_TOKEN = credentials('aws_session_token')
    }

    stages {
        // stage('Checkout') {
        //     steps {
        //         git branch: 'main', url: 'https://github.com/3slamAmin/Github-CICD'
        //     }
        // }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage("terrascan"){
            steps{
                 sh "terrascan scan -o junit-xml -d terraform/aws > terrascan.xml || true"
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        
    }
    post {
                always {
                    junit 'terrascan.xml'
                }
            }
            
}