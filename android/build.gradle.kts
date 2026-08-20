allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    if (project.state.executed) {
        project.extensions.findByName("android")?.let { android ->
            try {
                val namespace = android.javaClass.getMethod("getNamespace").invoke(android)
                if (namespace == null) {
                    val groupStr = project.group.toString()
                    val newNamespace = if (groupStr.isNotEmpty()) groupStr else "com.example." + project.name.replace("-", "_")
                    android.javaClass.getMethod("setNamespace", String::class.java).invoke(android, newNamespace)
                }
                android.javaClass.getMethod("compileSdkVersion", Int::class.java).invoke(android, 34)
            } catch (e: Exception) {}
        }
    } else {
        project.afterEvaluate {
            project.extensions.findByName("android")?.let { android ->
                try {
                    val namespace = android.javaClass.getMethod("getNamespace").invoke(android)
                    if (namespace == null) {
                        val groupStr = project.group.toString()
                        val newNamespace = if (groupStr.isNotEmpty()) groupStr else "com.example." + project.name.replace("-", "_")
                        android.javaClass.getMethod("setNamespace", String::class.java).invoke(android, newNamespace)
                    }
                    android.javaClass.getMethod("compileSdkVersion", Int::class.java).invoke(android, 34)
                } catch (e: Exception) {}
            }
        }
    }
}
