class Category < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :lessons

  scope :alphabet, ->{order :name}

  validates :name, presence: true,uniqueness: true, length: {maximum: 200}
end
