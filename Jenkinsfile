pipeline {
    agent any
        tools {
        // maven tool name and config
        maven 'maven' 
        // java tool name and config
        jdk 'oracle_jdk'
    }
    stages {
        stage('Checkout') {
                steps {
                    // clone project git to workspace
                    echo 'Checkout'
    				git 'https://github.com/zivkashtan/course.git'
                }
            }
            
        stage('Build') {
            steps {
                //build
                echo 'Clean Build'
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                //test
                echo 'Testing'
                sh 'mvn test'
            }
        }
        
        stage('JaCoCo') {
            steps {
                // jacoco overall coverage summary
                echo 'Code Coverage'
                jacoco()
            }
        }
        
        stage('Package') {
            steps {
                echo 'Packaging'
                sh 'mvn package -DskipTests'
            } 
        }
        
        stage ('SonarQube Analysis'){
            steps{
                // running sonarqube test with pre defined server 
            dir("."){
            withSonarQubeEnv('SonarQube server') {
            sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.2:sonar'
            }
            }
            }
            }
        
        stage('Deploy') {
            steps {
                // deploy war file to nexus
                            echo 'deploy war to artifactory'
                            sh 'mvn deploy:deploy-file' +
             ' -DgeneratePom=false -DrepositoryId=nexus' +
             ' -Durl=http://localhost:8081/repository/maven-releases/' +
             ' -Dpackaging=war -DgroupId=com.automateit -Dversion=1.0' +
            ' -DpomFile=pom.xml -Dfile=web/target/time-tracker-web-0.3.1.war'
 
            }
        }
        
        stage('Checkout scm') {
            steps {
                // Checkout scm in order to get dockerfile
                echo 'Test'
                checkout scm
            }
        }
        
       stage('Docker Build') {
          steps {
              //build docker image , login to nexus server , tag and push
             sh "docker build -t autoimage ."
             sh "docker tag autoimage localhost:8123/autoimage:1"
            sh "docker push localhost:8123/autoimage:1"
      }
      }
                
    }
// post action 
    post {
        always {
            echo 'JENKINS PIPELINE'
        }
        success {
            echo 'JENKINS PIPELINE SUCCESSFUL'
        }
        failure {
            echo 'JENKINS PIPELINE FAILED'
        }
        unstable {
            echo 'JENKINS PIPELINE WAS MARKED AS UNSTABLE'
        }
        changed {
            echo 'JENKINS PIPELINE STATUS HAS CHANGED SINCE LAST EXECUTION'
        }
    }
}
