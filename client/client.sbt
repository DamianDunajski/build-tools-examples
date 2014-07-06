lazy val client = project.in(file("."))
  .enablePlugins(PlayScala)
  .settings(buildSettings: _*)
  .settings(playAssetsSettings: _*)

lazy val buildSettings = Seq(
  version := "1.0-SNAPSHOT",
  scalaVersion := "2.10.4",
  sbtVersion := "0.13.5"
)

lazy val playAssetsSettings = Seq(
  includeFilter in(Assets, LessKeys.less) := "*.less",
  excludeFilter in(Assets, LessKeys.less) := "_*.less"
)