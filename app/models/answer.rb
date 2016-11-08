class Answer < ApplicationRecord
  belongs_to :word, required: false
  has_many :results

  scope :correct, ->{where is_correct: true}
  scope :alphabet, ->{order :content}

  validates :content, presence: true
end
