# frozen_string_literal: true

class Resident < ApplicationRecord
  has_one :address, dependent: :destroy

  has_one_attached :photo

  accepts_nested_attributes_for :address

  validates :full_name, presence: true
  validates :cpf, presence: true, uniqueness: true, cpf: true
  validates :cns, presence: true, uniqueness: true, cns: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :birth_date, presence: true, cns_birth_date: true
  validates :phone, presence: true, phone: true
  validates :photo, presence: true
  enum status: %i[inactive active]
  validates :status, inclusion: { in: Resident.statuses.keys }

  include PgSearch::Model
  pg_search_scope :search_by_full_name, against: [:full_name]
end
