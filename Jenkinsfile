pipeline {
    agent any

	/*
		Set ENV Variables
		Run mvn package
		checkstyle scan and report generation
		SonarQube Analysis
		Install Jenkins WAR , .msi did not work due to user account issues
		Install GIT on laptop , add GIT.exe path in Global Tools configuration   (https://www.guru99.com/jenkins-github-integration.html)
		Install maven 
		SonarQube Scanner plugin for Jenkins
		Install docker Pipeline Plugin 
		SonarQube credentials set up in Jenkins  ,LOCAL_SONARQUBE  - is the name of Local Sonar Server in Jenkins                 
		DockerHub credentials set up in Jenkins (under global credentials)and used that ID as 'registryCredential' 
	*/
	environment { 
	   VERSION = "${env.BUILD_NUMBER}"
	   registry = "ggupta0109/hello-world-docker" 
       registryCredential = 'docker_id' 
       dockerImage = '' 
	}
    stages {
        stage('Build') {
            steps {
            	echo 'test 1....'
                bat 'mvn package'
                echo 'test 2....'
                bat 'mvn checkstyle:checkstyle'
                recordIssues(tools: [checkStyle(reportEncoding: 'UTF-8')])
            }
        }
         stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('LOCAL_SONARQUBE') {
                   // bat 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=admin1234'
                   bat 'mvn sonar:sonar'
                }
            }
        }
        
        stage("Quality gate") {
            steps {
                // for this to work had to Server authentication token SonarQube servers (under configuration)
                waitForQualityGate  abortPipeline: false
            }
        }
        stage('Deploy to Local Docker') {
            steps {
                echo 'Deploying....'
                bat 'docker info'
                echo "The build number is ${env.BUILD_NUMBER}"
                bat  "docker build -t jenkins-demo:${VERSION} ." 
                bat "docker tag jenkins-demo:${VERSION} jenkins-demo:latest"
			    bat 'docker images'
            }
        }
        stage('Docker Pipeline - Build Image') { 
		steps { 
                script { 
                    dockerImage = docker.build registry + ":${VERSION}" 
                    
                    echo "dockerImage is " + dockerImage
                }
            } 
        }
        stage('Docker Pipeline - Push Image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push() 
                    }
                } 
            }
        } 
   
    }
}