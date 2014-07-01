package services

import models.RegistrationData
import pl.geeksoft.px.model.RegistrationResult
import play.api.Logger
import play.api.Play.current
import play.api.http.Status
import play.api.libs.functional.syntax._
import play.api.libs.json.{JsPath, Reads}
import play.api.libs.ws.WS

import scala.concurrent.Future

object RegistrationService {

  implicit val context = play.api.libs.concurrent.Execution.Implicits.defaultContext

  implicit val reads: Reads[RegistrationResult] = (
    (JsPath \ "email").read[String] and
      (JsPath \ "voucher").read[String]
    )(RegistrationResult.apply _)

  private val path: String = "http://localhost:8080/user/register"

  def register(data: RegistrationData): Future[Either[Int, RegistrationResult]] = {
    WS.url(path).post(serialize(data)) map {
      response => response.status match {
        case Status.OK => Right(response.json.as[RegistrationResult])
        case other => Left(other)
      }
    } recover {
      case error => {
        Logger.error("Error occurred: " + error.getMessage, error)
        Left(Status.INTERNAL_SERVER_ERROR)
      }
    }
  }

  private def serialize(data: RegistrationData) = Map(
    "email" -> Seq(data.email),
    "password" -> Seq(data.password)
  )

}
