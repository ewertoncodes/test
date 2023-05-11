class Resident < ApplicationRecord
  has_one_attached :photo

  validates :full_name, presence: true
  validates :cpf, presence: true, uniqueness: true, cpf: true
  validates :cns, presence: true, uniqueness: true, cns: true
  validates :email, presence: true, uniqueness: true, email: true
  validates :birth_date, presence: true, cns_birth_date: true
  validates :phone, presence: true, phone: true
  validates :photo, presence: true
  enum status: [:inactive, :active]
  validates :status, inclusion: { in: [:inactive, :active] }
end