# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResidentMailer, type: :mailer do
  subject { create(:resident) }

  it 'notify an email' do
    expect { subject.notify }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
