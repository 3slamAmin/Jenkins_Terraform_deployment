pipeline {
    agent any

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