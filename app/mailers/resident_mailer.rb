# frozen_string_literal: true

class ResidentMailer < ApplicationMailer
  default from: 'noreply@company.com'

  def notify(resident)
    @full_name = resident.full_name

    mail to: resident.email, subject: 'resident'
  end
end