import { Controller } from "stimulus"

export default class FlashController extends Controller {
  static targets = [ "alert" ]

  closeFlash() {
    this.alertTarget.classList.add("hidden")
  }
}
