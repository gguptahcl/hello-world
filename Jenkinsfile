pipeline {
    agent any

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
                waitForQualityGate (webhookSecretId: 'yourSecretID')  abortPipeline: false
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}