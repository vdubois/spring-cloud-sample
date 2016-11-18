node('master') {
  def dataContainer = "SPRING-CLOUD-SAMPLE-MVN-DATA-CONTAINER"
  sh "rm -rf *"
  try {
    sh "docker create -v /home/developer/.m2/repository/ --name ${dataContainer} busybox /bin/true"
    stage concurrency: 1, name: 'BUILD' {
      buildModule('spring-cloud-sample-config-server')
      buildModule('spring-cloud-sample-eureka-server')
    }
  } finally {
    stage concurrency: 1, name: 'CLEAN' {
      sh "docker stop ${dataContainer}|true"
      sh "docker rm -v -f ${dataContainer}|true"
    }
  }

  def buildModule(moduleName) {
    dir(moduleName) {
      git url: "https://github.com/vdubois/${moduleName}"
      sh "docker run --rm -v ${env.WORKSPACE_DIRECTORY}/spring-cloud-sample/${moduleName}:/tmp -v /var/run/docker.sock:/var/run/docker.sock -w /tmp --volumes-from=${dataContainer} vdubois/maven:3.3.9-jdk8 mvn clean package docker:build"
    }
  }
}
