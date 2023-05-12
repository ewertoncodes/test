# frozen_string_literal: true

class CnsBirthDateValidator < ActiveModel::EachValidator
  MAXIMUM_AGE = 130

  def validate_each(record, attribute, value)
    unless value.is_a?(Date)
      record.errors.add(attribute, 'deve ser uma data')
      return
    end

    unless value < Date.today
      record.errors.add(attribute, "deve ser pelo menos que o dia atual")
    end

    return if value >= Date.today - MAXIMUM_AGE.year

    record.errors.add(attribute, "não pode ser mais antiga que #{MAXIMUM_AGE} anos")
  end
end
