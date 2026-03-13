plugins {
    kotlin("jvm") version "2.1.21"
    id("com.isycat.ktox.lua") version "0.1.0"
}

repositories {
    mavenCentral()
}

kotlinToLua {
    // Strip "com.example" from all paths so generated Lua sits at the project root
    rootNamespace = "com.example"
    // Entry point executed by `./gradlew runLua`
    luaEntryPoint = "Main.lua"
    // Output directory for generated Lua (committed to source control)
    outputDirectory = layout.projectDirectory.dir("outputDir/vscripts")
}
