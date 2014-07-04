require "buildr/scala"

repositories.remote << "http://repo1.maven.org/maven2"

define "root" do
	project.group = "pl.geeksoft.px"
	project.version = "1.0-SNAPSHOT"

	compile.using :source => "1.7", :target => "1.7"

	SCALA = "org.scala-lang:scala-library:jar:2.10.4"

	define "model" do
		compile.with SCALA

		package :jar, :file => _("target/model.jar")
	end

	define "service" do
		DROPWIZARD = [
			"ch.qos.logback:logback-classic:jar:1.1.2",
			"ch.qos.logback:logback-core:jar:1.1.2",
			"com.codahale.metrics:metrics-annotation:jar:3.0.2",
			"com.codahale.metrics:metrics-core:jar:3.0.2",
			"com.codahale.metrics:metrics-healthchecks:jar:3.0.2",
			"com.codahale.metrics:metrics-jersey:jar:3.0.2",
			"com.codahale.metrics:metrics-jetty9:jar:3.0.2",
			"com.codahale.metrics:metrics-json:jar:3.0.2",
			"com.codahale.metrics:metrics-jvm:jar:3.0.2",
			"com.codahale.metrics:metrics-logback:jar:3.0.2",
			"com.codahale.metrics:metrics-servlets:jar:3.0.2",
			"com.fasterxml.jackson.core:jackson-annotations:jar:2.3.0",
			"com.fasterxml.jackson.core:jackson-core:jar:2.3.3",
			"com.fasterxml.jackson.core:jackson-databind:jar:2.3.3",
			"com.fasterxml.jackson.dataformat:jackson-dataformat-yaml:jar:2.3.3",
			"com.fasterxml.jackson.datatype:jackson-datatype-guava:jar:2.3.3",
			"com.fasterxml.jackson.datatype:jackson-datatype-joda:jar:2.3.3",
			"com.fasterxml.jackson.jaxrs:jackson-jaxrs-base:jar:2.3.3",
			"com.fasterxml.jackson.jaxrs:jackson-jaxrs-json-provider:jar:2.3.3",
			"com.fasterxml.jackson.module:jackson-module-afterburner:jar:2.3.3",
			"com.fasterxml.jackson.module:jackson-module-jaxb-annotations:jar:2.3.3",
			"com.fasterxml:classmate:jar:1.0.0",
			"com.google.code.findbugs:jsr305:jar:2.0.3",
			"com.google.guava:guava:jar:17.0",
			"com.sun.jersey:jersey-core:jar:1.18.1",
			"com.sun.jersey:jersey-server:jar:1.18.1",
			"com.sun.jersey:jersey-servlet:jar:1.18.1",
			"commons-lang:commons-lang:jar:2.6",
			"io.dropwizard:dropwizard-configuration:jar:0.7.1",
			"io.dropwizard:dropwizard-core:jar:0.7.1",
			"io.dropwizard:dropwizard-jackson:jar:0.7.1",
			"io.dropwizard:dropwizard-jersey:jar:0.7.1",
			"io.dropwizard:dropwizard-jetty:jar:0.7.1",
			"io.dropwizard:dropwizard-lifecycle:jar:0.7.1",
			"io.dropwizard:dropwizard-logging:jar:0.7.1",
			"io.dropwizard:dropwizard-metrics:jar:0.7.1",
			"io.dropwizard:dropwizard-servlets:jar:0.7.1",
			"io.dropwizard:dropwizard-util:jar:0.7.1",
			"io.dropwizard:dropwizard-validation:jar:0.7.1",
			"javax.el:javax.el-api:jar:2.2.5",
			"javax.validation:validation-api:jar:1.1.0.Final",
			"joda-time:joda-time:jar:2.3",
			"net.sourceforge.argparse4j:argparse4j:jar:0.4.3",
			"org.eclipse.jetty.orbit:javax.servlet:jar:3.0.0.v201112011016",
			"org.eclipse.jetty.toolchain.setuid:jetty-setuid-java:jar:1.0.2",
			"org.eclipse.jetty:jetty-continuation:jar:9.0.7.v20131107",
			"org.eclipse.jetty:jetty-http:jar:9.0.7.v20131107",
			"org.eclipse.jetty:jetty-io:jar:9.0.7.v20131107",
			"org.eclipse.jetty:jetty-security:jar:9.0.7.v20131107",
			"org.eclipse.jetty:jetty-server:jar:9.0.7.v20131107",
			"org.eclipse.jetty:jetty-servlet:jar:9.0.7.v20131107",
			"org.eclipse.jetty:jetty-servlets:jar:9.0.7.v20131107",
			"org.eclipse.jetty:jetty-util:jar:9.0.7.v20131107",
			"org.glassfish.web:javax.el:jar:2.2.6",
			"org.hibernate:hibernate-validator:jar:5.1.1.Final",
			"org.jboss.logging:jboss-logging:jar:3.1.3.GA",
			"org.slf4j:jcl-over-slf4j:jar:1.7.6",
			"org.slf4j:jul-to-slf4j:jar:1.7.6",
			"org.slf4j:log4j-over-slf4j:jar:1.7.6",
			"org.slf4j:slf4j-api:jar:1.7.6"
		]
		SWAGGER = [
			"com.fasterxml.jackson.module:jackson-module-jsonSchema:jar:2.1.0",
			"com.fasterxml.jackson.module:jackson-module-scala_2.10:jar:2.1.5",
			"com.thoughtworks.paranamer:paranamer:jar:2.3",
			"com.wordnik:swagger-annotations:jar:1.3.6",
			"com.wordnik:swagger-core_2.10:jar:1.3.6",
			"com.wordnik:swagger-jaxrs_2.10:jar:1.3.6",
			"dom4j:dom4j:jar:1.6.1",
			"org.javassist:javassist:jar:3.16.1-GA",
			"org.joda:joda-convert:jar:1.2",
			"org.json4s:json4s-ast_2.10:jar:3.2.5",
			"org.json4s:json4s-core_2.10:jar:3.2.5",
			"org.json4s:json4s-ext_2.10:jar:3.2.5",
			"org.json4s:json4s-jackson_2.10:jar:3.2.5",
			"org.json4s:json4s-native_2.10:jar:3.2.5",
			"org.reflections:reflections:jar:0.9.9-RC1",
			"xml-apis:xml-apis:jar:1.0.b2"
		]

		compile.with projects("model"), SCALA, DROPWIZARD, SWAGGER

		# package
		manifest["Main-Class"] = "pl.geeksoft.px.service.ServiceRunner"
		package :jar, :file => _("target/service.jar")
		package(:jar, :file => _("target/service-bundle.jar")).merge(compile.dependencies).exclude("META-INF/*.SF", "META-INF/*.DSA", "META-INF/*.RSA")
	end

end