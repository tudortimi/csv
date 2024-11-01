import org.gradle.api.*
import org.gradle.api.initialization.*

class SvunitBuildInjectionPlugin implements Plugin<Settings> {
    void apply(Settings settings) {
        settings.gradle.rootProject {
            apply plugin: 'com.verificationgentleman.gradle.hdvl.svunit-build'
        }
    }
}
