pipeline{
    agent any
    
    tools {
        terraform 'Terraform'
    }
    
    stages{
         stage('Git Checkout'){
            steps {
                git branch: 'main', credentialsId: '60c696b5-f4bf-46d0-9c3d-c1d939676612', url: 'https://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@github.com/nigel-sys/Terraform.git'
            }
        }
        stage('Terraform Init'){
            steps{
                sh 'terraform init'
            }
        }
        
        stage('Terraform apply'){
            steps{
                sh 'terraform apply --auto-approve'
            }
        }
    }
}