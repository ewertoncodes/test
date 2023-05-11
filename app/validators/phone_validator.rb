class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    
    unless value =~ /^\s*\d{11}\s*$/
      record.errors[attribute] << (options[:message] || "is not a valid phone number")
    end
  end
end
