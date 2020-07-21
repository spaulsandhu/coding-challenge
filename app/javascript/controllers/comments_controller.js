import { Controller } from "stimulus"

export default class CommentsController extends Controller {
  static targets = [ "list", "newComment", "newCommentField" ]

  renderCommentList(event) {
    const [data, status, xhr] = event.detail
    this.listTarget.innerHTML = xhr.response
  }

  onCommentCreate(event) {
    event.stopPropagation()
    const [data, status, xhr] = event.detail
    const target = event.target

    if (!!event.target.parentNode.id) {
      target.parentNode.innerHTML = xhr.response
    } else {
      this.listTarget.innerHTML += xhr.response
      this.newCommentFieldTarget.value = ""
    }

    this.resetFormErrors()
  }

  onCommentError(event) {
    event.stopPropagation()
    const [data, status, xhr] = event.detail
    const target = event.target

    if (!!event.target.parentNode.id) {
      target.parentNode.innerHTML = xhr.response
    } else {
      this.newCommentTarget.innerHTML = xhr.response
    }
  }

  editComment(event) {
    const [data, status, xhr] = event.detail
    const target = event.target
    target.closest("#comment-body").innerHTML = xhr.response
  }

  resetFormErrors() {
    const fieldWithErrors = document.getElementsByClassName("field_with_errors")[0]
    const errorTextNodes = document.querySelectorAll(".error-text")

    if (!!fieldWithErrors) { 
      fieldWithErrors.classList.remove("field_with_errors");
    }

    if (!!errorTextNodes) { 
      errorTextNodes.forEach(errorText => errorText.remove())
    }
  }
}