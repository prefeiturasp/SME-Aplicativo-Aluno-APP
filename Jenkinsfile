pipeline {
    agent { kubernetes { 
                  label 'flutter3106'
                  defaultContainer 'flutter3106'
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

      stage('Build APK/AAB Dev') {
	      when { 
          anyOf { 
            branch 'developer'; 
          } 
        }       
        steps {
          withCredentials([
            file(credentialsId: 'google-service-dev', variable: 'GOOGLEJSONDEV'),
            file(credentialsId: 'app-config-dev', variable: 'APPCONFIGDEV'),
            file(credentialsId: 'app-key-jks', variable: 'APPKEYJKS'),
            file(credentialsId: 'app-key-properties', variable: 'APPKEYPROPERTIES'),
          ]) {
	    sh 'if [ -d "config" ]; then rm -Rf config; fi'
            sh 'cp ${APPKEYJKS} ~/key.jks && cp ${APPKEYJKS} ${WORKSPACE}/android/app/key.jks && cp ${APPKEYPROPERTIES} ${WORKSPACE}/android/key.properties'
            sh 'mkdir config && cp $APPCONFIGDEV config/app_config.json'
            sh 'cp $GOOGLEJSONDEV android/app/google-services.json'
            sh 'flutter clean && flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs && flutter build apk --release && flutter build appbundle --release'
          }
        }
      }

      stage('Build APK/AAB Hom') {
	      when { 
          anyOf { 
            branch 'release' 
          } 
        }       
        steps {
          withCredentials([
            file(credentialsId: 'google-service-hom', variable: 'GOOGLEJSONHOM'),
            file(credentialsId: 'app-config-hom', variable: 'APPCONFIGHOM'),
	    file(credentialsId: 'app-key-jks', variable: 'APPKEYJKS'),
            file(credentialsId: 'app-key-properties', variable: 'APPKEYPROPERTIES'),
          ]) {
	    sh 'if [ -d "config" ]; then rm -Rf config; fi'
            sh 'cp ${APPKEYJKS} ~/key.jks && cp ${APPKEYJKS} ${WORKSPACE}/android/app/key.jks && cp ${APPKEYPROPERTIES} ${WORKSPACE}/android/key.properties'
            sh 'mkdir config && cp $APPCONFIGHOM config/app_config.json'
            sh 'cp $GOOGLEJSONHOM android/app/google-services.json'
            sh 'flutter clean && flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs && flutter build apk --release && flutter build appbundle --release'
          }
        }
      }

      stage('Build APK/AAB Hom2') {
	      when { 
          anyOf { 
            branch 'release-r2' 
          } 
        }       
        steps {
          withCredentials([
            file(credentialsId: 'google-service-hom2', variable: 'GOOGLEJSONHOM2'),
            file(credentialsId: 'app-config-hom2', variable: 'APPCONFIGHOM2'),
	    file(credentialsId: 'app-key-jks', variable: 'APPKEYJKS'),
            file(credentialsId: 'app-key-properties', variable: 'APPKEYPROPERTIES'),
          ]) {
	    sh 'if [ -d "config" ]; then rm -Rf config; fi'
            sh 'cp ${APPKEYJKS} ~/key.jks && cp ${APPKEYJKS} ${WORKSPACE}/android/app/key.jks && cp ${APPKEYPROPERTIES} ${WORKSPACE}/android/key.properties'
            sh 'mkdir config && cp $APPCONFIGHOM2 config/app_config.json'
            sh 'cp $GOOGLEJSONHOM2 android/app/google-services.json'
            sh 'flutter clean && flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs && flutter build apk --release && flutter build appbundle --release'
          }
        }
      }
	    
      stage('Build APK/AAB Prod') {
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
	    sh 'if [ -d "config" ]; then rm -Rf config; fi'
            sh 'cp ${APPKEYJKS} ~/key.jks && cp ${APPKEYJKS} ${WORKSPACE}/android/app/key.jks && cp ${APPKEYPROPERTIES} ${WORKSPACE}/android/key.properties'
            sh 'cat ${WORKSPACE}/android/key.properties | grep keyPassword | cut -d\'=\' -f2 > ${WORKSPACE}/android/key.pass'
            sh 'cd ${WORKSPACE} && mkdir config && cp $APPCONFIGPROD config/app_config.json'
            sh 'cp ${GOOGLEJSONPROD} android/app/google-services.json'
            sh 'flutter clean && flutter pub get && flutter packages pub run build_runner build --delete-conflicting-outputs && flutter build apk --release && flutter build appbundle --release'
            sh "/opt/android-sdk-linux/build-tools/33.0.2/apksigner sign --ks ~/key.jks --ks-pass file:${WORKSPACE}/android/key.pass ${WORKSPACE}/build/app/outputs/apk/release/app-release.apk"
           }
         }
      }
  }
 
}
