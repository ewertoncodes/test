# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:zip_code) }
    it { is_expected.to validate_presence_of(:street) }
    it { is_expected.to validate_presence_of(:neighborhood) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to belong_to(:resident) }

    it 'should allow blank complement and ibge_code' do
      address = FactoryBot.build(:address, complement: '', ibge_code: '')
      expect(address).to be_valid
    end
  end
end
