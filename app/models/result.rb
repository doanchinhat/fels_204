class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :word
  belongs_to :answer

  scope :count_correct_answer, -> do
    joins(:answer).where(answers: {is_correct: true}).count
  end

  delegate :content, to: :word, prefix: :word, allow_nil: true
end
