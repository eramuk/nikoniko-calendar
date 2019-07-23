module FormHelper
  def form_error(model, field)
    return if model.errors.messages[field.to_sym].blank?
    "#{field.capitalize} #{model.errors.messages[field.to_sym].first}"
  end

  def form_validate(model, field)
    model.errors.messages[field.to_sym].blank? ? "valid" : "invalid"
  end
end