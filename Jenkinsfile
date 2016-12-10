node('master') {
  def dataContainer = "SPRING-CLOUD-SAMPLE-MVN-DATA-CONTAINER"
  sh "rm -rf *"
  try {
    sh "docker create -v /home/developer/.m2/repository/ --name ${dataContainer} busybox /bin/true"
    stage 'BUILD' 
      buildModule("${moduleToBuild}")
  } finally {
    stage 'CLEAN'
      sh "docker stop ${dataContainer}|true"
      sh "docker rm -v -f ${dataContainer}|true"
  }
}
def buildModule(moduleName) {
  def jenkinsWorkspace = "/var/jenkins_home/workspace"
  dir(moduleName) {
    git url: "https://github.com/vdubois/${moduleName}"
    stage 'BUILD_JAR'
      sh "docker run --rm -v ${env.WORKSPACE_DIRECTORY}/spring-cloud-sample/${moduleName}:/tmp -v /var/run/docker.sock:/var/run/docker.sock -w /tmp --volumes-from=SPRING-CLOUD-SAMPLE-MVN-DATA-CONTAINER vdubois/maven:3.3.9-jdk8 mvn clean package docker:build -Dmaven.test.skip=true"
    stage 'BUILD_DOCKER_IMAGE'
      def pom = readMavenPom file: "${jenkinsWorkspace}/spring-cloud-sample/${moduleName}/pom.xml"
      sh "cp ${env.WORKSPACE_DIRECTORY}/spring-cloud-sample/${moduleName}/target/*.jar module.jar"
      sh "docker build -t vdubois/${moduleName}:${pom.version} ."
    stage 'PUSH_DOCKER_IMAGE'
      sh "docker push vdubois/${moduleName}:${pom.version}"
  }
}
