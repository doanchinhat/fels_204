class Activity < ApplicationRecord
  belongs_to :user

  scope :desc_date, -> {order(created_at: :desc)}

  validates :user, presence: true

  enum action_type: [:follow, :unfollow, :create_lesson, :update_lesson]

  def load_activity
    case action_type
      when "follow", "unfollow"
        target_user = find_follow_or_unfollow_user
        "#{user.name} #{I18n.t action_type} #{target_user.name}
          #{create_time}"
      when "create_lesson"
        target_lesson = find_lesson
        "#{user.name} #{I18n.t "create_lesson"} \"#{target_lesson.category.name}\"
          #{create_time}"
      when "update_lesson"
        target_lesson = find_lesson
        "#{user.name} #{I18n.t "finish_lesson"} \"#{target_lesson.category.name}\"
          #{I18n.t "with_result"} #{target_lesson.score}
          #{I18n.t "symbol"} #{Settings.number_question}
          #{create_time}"
    end
  end

  def create_time
    "(#{created_at.strftime(I18n.t "time.formats.default")})"
  end

  def find_lesson
    user.lessons.find_by id: target_id
  end

  def find_follow_or_unfollow_user
    User.find_by id: target_id
  end
end
