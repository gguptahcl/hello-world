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
                publishIssues(tools: [checkStyle(reportEncoding: 'UTF-8')])
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}