class Address < ApplicationRecord
  belongs_to :resident

  validates :zip_code, :street, :neighborhood, :city, :state, presence: true
end
