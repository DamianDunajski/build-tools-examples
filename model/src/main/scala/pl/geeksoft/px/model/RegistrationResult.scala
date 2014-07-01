package pl.geeksoft.px.model

import scala.beans.BeanProperty

case class RegistrationResult(@BeanProperty email: String, @BeanProperty var voucher: String) {

  def this(email: String) = this(email, null)

}
