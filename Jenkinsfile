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

      stage('Build APK Dev') {
	      when { 
          anyOf { 
            branch 'developer'; 
          } 
        }       
        steps {
          withCredentials([
            file(credentialsId: 'google-service-dev', variable: 'GOOGLEJSONDEV'),
            file(credentialsId: 'app-config-dev', variable: 'APPCONFIGDEV'),
          ]) {
            sh 'mkdir config && cp $APPCONFIGDEV config/app_config.json'
            sh 'cp $GOOGLEJSONDEV android/app/google-services.json'
            sh 'flutter pub get && flutter build apk'
          }
        }
      }

      stage('Build APK Hom') {
	      when { 
          anyOf { 
            branch 'release' 
          } 
        }       
        steps {
          withCredentials([
            file(credentialsId: 'google-service-hom', variable: 'GOOGLEJSONHOM'),
            file(credentialsId: 'app-config-hom', variable: 'APPCONFIGHOM'),
          ]) {
            sh 'mkdir config && cp $APPCONFIGHOM config/app_config.json'
            sh 'cp $GOOGLEJSONHOM android/app/google-services.json'
            sh 'flutter pub get && flutter build apk'
          }
        }
      }
	    
      stage('Build APK Prod') {
        when {
          branch 'master'
        }
        steps {
          withCredentials([
            file(credentialsId: 'google-service-prod', variable: 'GOOGLEJSONPROD'),
            file(credentialsId: 'app-config-prod', variable: 'APPCONFIGPROD'),
            file(credentialsId: 'app-key-jks', variable: 'APPKEYJKS'),
            file(credentialsId: 'app-key-properties', variable: 'APPKEYPROPERTIES'),
          ]) {
            sh 'cp ${APPKEYJKS} ~/key.jks && cp ${APPKEYPROPERTIES} android/key.properties'
            sh 'mkdir config && cp $APPCONFIGPROD config/app_config.json'
	          sh 'cp ${GOOGLEJSONPROD} android/app/google-services.json'
            sh 'flutter clean && flutter pub get && flutter build apk --release'
	        }
        }
      }

      stage('sign apk') {
        steps {
          step([
            $class: 'SignApksBuilder', 
            apksToSign: '**/*.apk', 
            keyAlias: '', 
            keyStoreId: '77b8ac0b-5b0e-4664-8882-3f70e1338484', 
            skipZipalign: true
          ])
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
