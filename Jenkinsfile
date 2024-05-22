pipeline {
    agent any

    environment {
        // AWS credentials
        AWS_ACCESS_KEY_ID = credentials('my-aws-access-key-id') 
        AWS_SECRET_ACCESS_KEY = credentials('my-aws-secret-access-key') 
    }

    stages {

        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                checkout scm
            }
        }

        // TODO: import state file if exists
        // stage('Importing tfstate if exists') {
        //     steps {
        //         script {
        //             if (fileExists('/var/jenkins_persiste/terraform.tfstate')) {
        //                 echo 'File exists!'
        //                 sh 'cp /var/jenkins_persiste/terraform.tfstate .'
        //             } else {
        //                 echo 'File does not exist!'
        //             }
        //         }
        //     }
        // }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize the Terraform working directory
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                script {
                    // Validate the Terraform configuration files
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate and show an execution plan
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Apply the changes required to reach the desired state of the configuration
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        // MOVE state file to the Persiste folder
        // stage('Move tfstate file') {
        //     steps {
        //         script {
        //             sh 'cp terraform.tfstate /var/jenkins_persiste/'
        //         }
        //     }
        // }

    }
}
