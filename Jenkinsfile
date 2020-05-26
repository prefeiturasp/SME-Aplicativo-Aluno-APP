pipeline {
    agent {
      node { 
        label 'flutter-android'
	    }
    }
    
    options {
      buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
      disableConcurrentBuilds()
      skipDefaultCheckout()  
    }
           
    stages {
       stage('CheckOut') {
        steps {
          checkout scm	
        }
       }

       stage('Build APK') {
        steps {
          withCredentials([file(credentialsId: 'google-service', variable: 'GOOGLEJSON')]) {
	  sh 'cp $GOOGLEJSON android/app/google-services.json'	  
          sh 'flutter pub get && flutter build apk'
	  }
        }
      }
       stage('sign apk') {
         steps{
           step([$class: 'SignApksBuilder', apksToSign: '**/*.apk', keyAlias: '', keyStoreId: '77b8ac0b-5b0e-4664-8882-3f70e1338484', skipZipalign: true])
         }
       } 

             
  } 
  	   
  post {
    always {
      echo 'One way or another, I have finished'
    }
    success {
      telegramSend("${JOB_NAME}...O Build ${BUILD_DISPLAY_NAME} - Esta ok !!!\n Consulte o log para detalhes -> [Job logs](${env.BUILD_URL}console)\n\n Uma nova versão da aplicação esta disponivel!!!")
    }
    unstable {
      telegramSend("O Build ${BUILD_DISPLAY_NAME} <${env.BUILD_URL}> - Esta instavel ...\nConsulte o log para detalhes -> [Job logs](${env.BUILD_URL}console)")
    }
    failure {
      telegramSend("${JOB_NAME}...O Build ${BUILD_DISPLAY_NAME}  - Quebrou. \nConsulte o log para detalhes -> [Job logs](${env.BUILD_URL}console)")
    }
    changed {
      echo 'Things were different before...'
    }
    aborted {
      telegramSend("O Build ${BUILD_DISPLAY_NAME} - Foi abortado.\nConsulte o log para detalhes -> [Job logs](${env.BUILD_URL}console)")
    }
  }
}
