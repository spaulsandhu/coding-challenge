import { Controller } from "stimulus"

export default class PostsController extends Controller {
  static targets = [ "form" ]

  insertPostForm(event) {
    const [data, status, xhr] = event.detail
    this.formTarget.innerHTML = xhr.response
  }
}