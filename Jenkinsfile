// App Gradle - Java demo app showing standardPipeline's Build stage using a
// Jenkins-managed Gradle installation via gradleToolName. Unlike app-maven
// (which uses mavenToolName) this project has no committed Gradle Wrapper
// (gradlew/gradlew.bat) - gradleToolName resolves a Gradle installation
// configured under Manage Jenkins > Tools and puts it on PATH for this
// stage only, so buildCommand can call 'gradle' directly.
//
// buildCommand is a single command - 'gradle clean build' - and it is the
// COMPLETE build: Gradle's 'build' task depends on 'check' (runs tests)
// and 'assemble' (produces the jar), so this one command compiles,
// tests, and packages, the same way 'mvn clean package' is a single
// complete command for app-maven. There's no need for a multi-line
// buildCommand here the way app-node needs one for its separate
// lint/test/build npm scripts.

@Library('jenkins-shared-library') _

standardPipeline(
    sonarProjectKey: 'app-gradle',
    gradleToolName: 'Gradle',
    buildCommand: 'gradle clean build',
    sonarScannerToolName: 'sonar-scanner',
    sonarScanCommand: '''
    gradle compileJava
    "%SONAR_SCANNER_HOME%\\bin\\sonar-scanner.bat" -Dsonar.projectKey=app-gradle -Dsonar.sources=src/main/java -Dsonar.java.binaries=build/classes/java/main
    ''',
    envMap: [
        'main': 'prod',
        'release/*': 'staging',
        'develop': 'dev'
    ],
    defaultEnv: 'dev',
    deploySteps: { deployEnv ->
        echo "Would deploy to environment: ${deployEnv} (image pulled from Nexus)"
    },
    dockerImage: { deployEnv -> "app-gradle:${deployEnv}" }
)
