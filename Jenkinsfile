pipeline {
    agent any
    environment{
	PATH = "/usr/local/bin/terraform:$PATH"
	SECRET_FILE_ID = credentials('tfsecret')
	}
    tools {
        terraform 'Terraform'
    }
    stages {
        stage ('SCM Checkout'){
            steps {
				script {
                // remove folder if already exist
                sh 'rm -rf $PWD/terraformflask'

                // clone the repository from github
                sh 'git clone https://github.com/srinanpravij/learn-terraform-deploy-nginx-kubernetes-provider.git $PWD/terraformflask'
				}
			}
		}
		stage('Terraform Init'){
            steps {
                // Initialize terraform with all the required plugin
				sh 'pwd'
                script{
					dir('terraformflask'){
						sh 'terraform init'
						}
				}
                
            }
        }
		stage('Terraform apply'){
            steps {
                // Initialize terraform with all the required plugin
				sh 'env'
                script{
					dir('terraformflask'){
						//sh 'terraform apply --auto-approve'
						sh 'terraform apply -var-file=${SECRET_FILE_ID} --auto-approve'
						}
				}
                
            }
        }
        
    }
    
}
