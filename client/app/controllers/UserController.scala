package controllers

import models.RegistrationData
import play.api.data.Forms._
import play.api.data._
import play.api.data.validation.Constraints._
import play.api.mvc._
import services.RegistrationService

import scala.concurrent.Future

object UserController extends Controller {

  implicit val context = play.api.libs.concurrent.Execution.Implicits.defaultContext

  val registrationForm = Form(
    mapping(
      "email" -> text.verifying(nonEmpty, emailAddress),
      "password" -> text.verifying(nonEmpty, minLength(6)),
      "termsAccepted" -> checked("error.required")
    )(RegistrationData.apply)(RegistrationData.unapply)
  )

  def displayForm() = Action {
    implicit request => {
      Ok(views.html.registrationForm(registrationForm.fill(new RegistrationData())))
    }
  }

  def register() = Action.async {
    implicit request => {
      registrationForm.bindFromRequest.fold(
        formWithErrors => Future(BadRequest(views.html.registrationForm(formWithErrors))),
        registrationData => RegistrationService.register(registrationData) map {
          _ match {
            case Right(registrationResult) => Ok(views.html.registrationSuccessPage(registrationResult))
            case Left(status) => InternalServerError(views.html.registrationForm(registrationForm))
          }
        }
      )
    }
  }

}
