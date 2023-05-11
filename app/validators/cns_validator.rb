class CnsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    return if value.size == 15 && value.match?(/^\d{15}$/)

    record.errors.add(attribute, "must have 15 digits")
  end
end
