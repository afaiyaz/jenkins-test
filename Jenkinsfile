node('jenkins-slave') {
    try{
        notifyStarted()
        stage('Initialize') {
            echo 'Initializing...'
            def node = tool name: 'node-js', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'
            env.PATH = "${node}/bin:${env.PATH}"
        }

        stage('Checkout') {
            echo 'Getting source code...'
            checkout scm
        }

        stage('Install Dependencies') {
            echo 'Building dependencies...'
            sh 'yarn install'
        }

        stage('Test') {
            echo 'Testing...'
            sh 'yarn test'
        }

        stage('Bundle') {
            sh 'yarn build'
        }

        stage('Build Image') {
            echo 'Publishing Test Coverage...'
            sh 'docker build . -t jenkins-test'
        }

        stage('Start Container') {
            echo 'Publishing Test Coverage...'
            sh 'docker build . -t jenkins-test'
            sh 'docker-compose up -d'
        }
    } catch(e){
        currentBuild.result = "FAILED"
        notifyFailed()
    }

    def notifyFailed() {
        slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }

    def notifyStarted() {
        slackSend (color: '#FFFF00', message: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
    }
}
