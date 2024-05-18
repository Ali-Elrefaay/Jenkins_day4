pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials("aws_access_key_id")
        AWS_SECRET_ACCESS_KEY = credentials("aws_secret_access_key")}
    stages {
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    script {

                            sh 'terraform init'
                            sh 'terraform apply -auto-approve'
                        
                    }
                }
            }
        }


        stage('Run Ansible Playbook') {
            steps {
                dir('ansible') {
                    script {
                        sh 'ansible-playbook playbook.yml'
                        }
                    }
                }
            }
        }
    }


