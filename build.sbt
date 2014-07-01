import play._
import play.PlayImport._
import sbt.Keys._
import sbtassembly.Plugin._
import com.typesafe.sbt.web._
import com.typesafe.sbt.web.Import._
import com.typesafe.sbt.less.Import._

lazy val root = project.in(file(".")).aggregate(model, client, service)

lazy val model = project.in(file("model"))
  .settings(buildSettings: _*)
  .settings(assemblySettings: _*)

lazy val client = project.in(file("client")).enablePlugins(PlayScala).enablePlugins(SbtWeb).dependsOn(model)
  .settings(buildSettings: _*)
  .settings(assemblySettings: _*)
  .settings(
    libraryDependencies ++= Seq(
      ws
    ),
    includeFilter in (Assets, LessKeys.less) := "*.less",
    excludeFilter in (Assets, LessKeys.less) := "_*.less"
  )

lazy val service = project.in(file("service")).dependsOn(model)
  .settings(buildSettings: _*)
  .settings(assemblySettings: _*)
  .settings(
    libraryDependencies ++= Seq(
      "io.dropwizard" % "dropwizard-core" % "0.7.1",
      "com.wordnik" % "swagger-jaxrs_2.10" % "1.3.6" exclude("javax.ws.rs", "jsr311-api")
    ),
    mainClass := Some("pl.geeksoft.px.service.ServiceRunner")
)

lazy val buildSettings = Seq(
  version := Commons.version,
  organization := Commons.organisation,
  scalaVersion := "2.10.4",
  sbtVersion := "0.13.5"
)