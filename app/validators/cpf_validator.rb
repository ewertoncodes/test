require "cpf_cnpj"

class CpfValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if CPF.valid?(value)

    record.errors.add(attribute, 'is invalid')
  end
end