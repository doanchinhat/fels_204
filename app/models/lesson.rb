class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :results
  has_many :answers, through: :results
  has_many :words, through: :results

  accepts_nested_attributes_for :results

  before_create :create_results
  after_save :update_lesson_activity
  delegate :name, to: :category, allow_nil: true

  def point
    answers.correct.size
  end

  private
  def create_results
    self.category.words.random.limit(Settings.number_question).each do |word|
      self.results.build word_id: word.id
    end
  end

 def update_lesson_activity
    lesson = Activity.find_by(target_id: id,
      action_type: Activity.action_types[:create_lesson])
    if lesson.nil?
      Activity.create user_id: user_id, target_id: id,
        action_type: :create_lesson
    else
      Activity.create user_id: user_id, target_id: id,
        action_type: :update_lesson
    end
  end
end
