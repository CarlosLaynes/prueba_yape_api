@Library('devops-selenium-functional-tests@feature/api_test')
import sharedlib.JenkinsfileUtil

this.projectType = 'api'
this.testsPath = 'src/test/java/com/belcorp/apirest/basetemplate'

def util = new JenkinsfileUtil(this)

try{
    node('selenium-web-spot'){
        stage("Preparation") {
            step([$class: 'WsCleanup'])
            checkout scm
            util.preparation()
        }
        stage("Starting Test") {
            util.runTest()
        }
        stage("Sending Report") {
            util.sendReport()
        }
    }
} catch (Exception e){
    node('selenium-web-spot'){
        util.deleteContainer()
        // send errors
        util.sendReport()
        echo '[ERROR]: sending test report errors'
        //utils.notifyByMail('FAIL', recipients) //Generar esta funcion
        sh 'echo THERE WAS AN ERROR, REPORT TO DEVOPS TEAM!'
        throw e
    }
}