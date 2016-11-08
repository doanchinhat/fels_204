class Word < ApplicationRecord
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results

  validate :check_answers
  validates :content, uniqueness: true, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true

  before_create :create_categories

  scope :random, ->{order "RANDOM()"}
  scope :alphabet, ->{order :content}
  scope :search_by, ->condition do
    where "content LIKE ?", "%#{condition}%" if (condition.present? or condition.to_s.titleize.present?)
  end

  scope :filter_category, ->category_id do
    where category_id: category_id if category_id.present?
  end

  scope :not_learned, ->user_id do
    where "id NOT IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = ?))", user_id
  end
  scope :learned_correct, ->user_id do
    where "id IN ( SELECT r.word_id FROM results r INNER JOIN answers a
      ON r.answer_id = a.id WHERE lesson_id IN (SELECT id FROM lessons
        WHERE user_id = ?) and a.is_correct = ?)", user_id, true
  end

  def create_categories
    categories = Category.all.alphabet
  end

  private
  def check_answers
    errors.add :answers, I18n.t(:warning_number_answer) if
      answers.select{|answer| !answer._destroy}.count <
        Settings.number_answer
    errors.add :answers, I18n.t(:warning_correct_answer) if
      answers.detect{|answer| answer.is_correct? && !answer._destroy}.nil?
  end
end
