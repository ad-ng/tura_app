allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

subprojects {
    // Set a custom build directory for each subproject (if needed)
    val newSubprojectBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get().dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Ensure `:app` is evaluated first
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
