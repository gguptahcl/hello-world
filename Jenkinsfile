pipeline {
    agent any

	environment { 
	   VERSION = "${env.BUILD_NUMBER}"
	}
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                }
        }
        stage('Test') {
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
                    bat 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=admin1234'
                }
            }
        }
        stage("Quality gate") {
            steps {
                waitForQualityGate  abortPipeline: false
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                bat 'docker info'
                echo "The build number is ${env.BUILD_NUMBER}"
                bat  'docker build -t jenkins-demo .' 
    		   bat 'docker tag jenkins-demo:${VERSION} jenkins-demo:latest'
			   bat 'docker images'
            }
        }
    }
}