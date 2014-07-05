package models

case class RegistrationData(email: String, password: String, termsAccepted: Boolean) {

  def this() = this(null, null, true)

}
