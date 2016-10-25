class Word < ApplicationRecord
  belongs_to :categoty
  has_many :answers, dependent: :destroy
  has_many :results
end
