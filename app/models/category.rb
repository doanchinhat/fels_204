class Category < ApplicationRecord
  has_many :words
  has_many :lessons

  scope :alphabet, ->{order :name}

  validates :name, presence: true, length: {maximum: 200}
end
