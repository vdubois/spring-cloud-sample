node('master') {
  def dataContainer = "SPRING-CLOUD-SAMPLE-MVN-DATA-CONTAINER"
  sh "rm -rf *"
  try {
    sh "docker create -v /home/developer/.m2/repository/ --name ${dataContainer} busybox /bin/true"
    dir('spring-cloud-sample-config-server') {
      git url: "https://github.com/vdubois/spring-cloud-sample-config-server.git"
      sh "docker run --rm -v ${env.WORKSPACE}/spring-cloud-sample-config-server:/tmp -w /tmp --volumes-from=${dataContainer} vdubois/maven:3.3.9-jdk8 mvn clean package docker:build"
    }
    //git url: "https://github.com/vdubois/spring-cloud-sample-eureka-server.git"
    //sh "docker run --rm -v ${pwd()}/spring-cloud-sample-eureka-server:/tmp -w /tmp --volumes-from=${dataContainer} vdubois/maven:3.3.9-jdk8 mvn clean package docker:build"
  } finally {
    sh "docker stop ${dataContainer}|true"
    sh "docker rm -v -f ${dataContainer}|true"
  }
}
