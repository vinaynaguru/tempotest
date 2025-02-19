pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access')  // Replace with your Jenkins credential ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret')  // Replace with your Jenkins credential ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/vinaynaguru/tempotest.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }

        stage('Update Ansible Inventory') {
            steps {
                script {
                    def ip = sh(script: "terraform output -raw public_ip", returnStdout: true).trim()
                    sh "echo '[webserver]' > inventory"
                    sh "echo '${ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa' >> inventory"
                }
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i inventory playbook.yml'
            }
        }
    }
}
