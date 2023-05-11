class CnsBirthDateValidator < ActiveModel::EachValidator
  MINIMUM_AGE = 1
  MAXIMUM_AGE = 130

  def validate_each(record, attribute, value)
    unless value.is_a?(Date)
      record.errors.add(attribute, 'deve ser uma data')
      return
    end

    unless value <= Date.today - MINIMUM_AGE.year
      record.errors.add(attribute, "deve ser pelo menos #{MINIMUM_AGE} ano(s) atrás")
    end

    unless value >= Date.today - MAXIMUM_AGE.year
      record.errors.add(attribute, "não pode ser mais antiga que #{MAXIMUM_AGE} anos")
    end
  end
end
