pipeline {
    agent any
    parameters {
        string(name: 'RELEASE_URL', defaultValue: 'https://github.com/3slamAmin/Github-CICD/releases/latest/download/dist.tar.gz', description: 'Release url to deploy')
    }

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws_access_key_id')
        AWS_SECRET_ACCESS_KEY    = credentials('aws_secret_access_key')
        AWS_SESSION_TOKEN = credentials('aws_session_token')
        AWS_REGION= "us-east-1"
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
                 sh "terrascan scan -o junit-xml > terrascan.xml || true"
            }
        }
        stage('Terraform apply') {
            environment{
                TF_VAR_artifact_url = "${params.RELEASE_URL}"
            }
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