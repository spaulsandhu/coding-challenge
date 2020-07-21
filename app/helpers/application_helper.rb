# frozen_string_literal: true

module ApplicationHelper
  def formatted_date(date)
    date.strftime("%A, %B #{date.day.ordinalize} %Y")
  end

  def display_inline_form_errors(model, field)
    if model.errors[field].any?
      model.errors.full_messages_for(field).collect do |error|
        content_tag(:p, error.html_safe, class: 'error-text')
      end
    else
      []
    end.join.html_safe
  end

  def add_or_edit(object)
    object.persisted? ? "Edit" : "Add"
  end
end
