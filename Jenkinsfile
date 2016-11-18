node('master') {
  def dataContainer = "SPRING-CLOUD-SAMPLE-MVN-DATA-CONTAINER"
  sh "rm -rf *"
  try {
    sh "docker create -v /home/developer/.m2/repository/ --name ${dataContainer} busybox /bin/true"
    stage 'BUILD' 
      buildModule('spring-cloud-sample-config-server')
      buildModule('spring-cloud-sample-eureka-server')
      buildModule('spring-cloud-sample-books-service')
      buildModule('spring-cloud-sample-comments-service')
      buildModule('spring-cloud-sample-recommendations-service')
      buildModule('spring-cloud-sample-amazin-client')
      buildModule('spring-cloud-sample-hystrix-dashboard')
      buildModule('spring-cloud-sample-turbine')
  } finally {
    stage 'CLEAN'
      sh "docker stop ${dataContainer}|true"
      sh "docker rm -v -f ${dataContainer}|true"
  }
}
def buildModule(moduleName) {
  dir(moduleName) {
    git url: "https://github.com/vdubois/${moduleName}"
    sh "docker run --rm -v ${env.WORKSPACE_DIRECTORY}/spring-cloud-sample/${moduleName}:/tmp -v /var/run/docker.sock:/var/run/docker.sock -w /tmp --volumes-from=SPRING-CLOUD-SAMPLE-MVN-DATA-CONTAINER vdubois/maven:3.3.9-jdk8 mvn clean package docker:build -Dmaven.test.skip=true"
  }
}
