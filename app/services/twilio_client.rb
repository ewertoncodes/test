# frozen_string_literal: true

class TwilioClient
  attr_reader :client

  def initialize
    @client = ::Twilio::REST::Client.new account_sid, auth_token
  end

  def send_text(user, message)
    client.api.account.messages.create(
      to: user.phone,
      from: phone_number,
      body: message
    )
  end

  private

  def account_sid
    ENV['TWILIO_ACCOUNT_SID']
  end

  def auth_token
    ENV['TWILIO_AUTH_TOKEN']
  end

  def phone_number
    ENV['TWILIO_PHONE_NUMBER']
  end
end
