node('jenkins-slave') {
    pipeline{
        stage('Initialize') {
            echo 'Initializing...'
            def node = tool name: 'node-js', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
            env.PATH = "${node}/bin:${env.PATH}"
        }

        stage('Checkout') {
            echo 'Getting source code...'
            checkout scm
        }

        stage('Build') {
            echo 'Building dependencies...'
            sh 'npm i'
        }

        stage('Test') {
            echo 'Testing...'
            sh 'npm test'
        }

        stage('Bundle') {
            sh 'npm run-script build'
        }

        stage('Deploy') {
            echo 'Publishing Test Coverage...'
            sh 'docker build . -t jenkins-test'
            sh 'docker-compose up -d'
        }
    }
}
