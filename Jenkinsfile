node('jenkins-slave') {
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
  dir(moduleName) {
    git url: "https://github.com/vdubois/${moduleName}"
    stage 'BUILD_JAR'
      sh "docker run --rm -v ${pwd()}:/tmp -v /var/run/docker.sock:/var/run/docker.sock -w /tmp --volumes-from=SPRING-CLOUD-SAMPLE-MVN-DATA-CONTAINER vdubois/maven:3.3.9-jdk8 mvn clean package"
      sh "cp target/*.jar ../module.jar"
  }
  stage 'BUILD_DOCKER_IMAGE'
    def pom = readMavenPom file: "pom.xml"
    sh "docker build -t vdubois/${moduleName}:${pom.version} ."
  stage 'PUSH_DOCKER_IMAGE'
    sh "docker push vdubois/${moduleName}:${pom.version}"
}
