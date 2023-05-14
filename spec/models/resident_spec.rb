# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resident, type: :model do
  describe 'validations' do
    subject { build(:resident) }

    it { is_expected.to validate_presence_of(:full_name) }

    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it { is_expected.to allow_value('611.595.380-42').for(:cpf) }
    it { is_expected.to_not allow_value('123.456.789-99').for(:cpf) }

    it { is_expected.to validate_presence_of(:cns) }
    it { is_expected.to validate_uniqueness_of(:cns).case_insensitive }
    it { is_expected.to_not allow_value('789 1234 5678 9012').for(:cns) }
    it { is_expected.to allow_value('123456789012345').for(:cns) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.to_not allow_value('userexample.com').for(:email) }

    it { is_expected.to validate_presence_of(:birth_date) }
    it { is_expected.to allow_value(30.years.ago).for(:birth_date) }
    it { is_expected.to_not allow_value(Date.tomorrow).for(:birth_date) }
    it { is_expected.to_not allow_value(2000.years.ago).for(:birth_date) }

    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to allow_value(ENV['PHONE_NUMBER']).for(:phone) }

    it { is_expected.to validate_presence_of(:photo) }
    it { is_expected.to define_enum_for(:status).with_values(inactive: 0, active: 1) }
  end

  describe 'search_by_full_name' do
    let!(:resident_1) { create(:resident, full_name: 'John Doe') }
    let!(:resident_2) { create(:resident, full_name: 'Jane Smith') }
    let!(:resident_3) { create(:resident, full_name: 'James Brown') }

    it 'returns residents with matching full name' do
      expect(Resident.search_by_full_name('John')).to include(resident_1)
      expect(Resident.search_by_full_name('Jane')).to include(resident_2)
      expect(Resident.search_by_full_name('James')).to include(resident_3)
    end

    it 'does not return residents with non-matching full name' do
      expect(Resident.search_by_full_name('Bob')).to be_empty
    end
  end
end
