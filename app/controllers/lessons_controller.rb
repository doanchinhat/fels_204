class LessonsController < ApplicationController
  before_action :signed_in_user
  before_action :start_lesson, only: [:edit, :update, :show]
  before_action :check_user, only: :edit

  def show
    @results = @lesson.results
  end

  def edit
    @words = @lesson.words
  end

  def update
    if @lesson.update_attributes lesson_params
      @lesson.score = @lesson.point
      @lesson.update_attributes lesson_params
      flash[:success] = t :lesson_finish
      redirect_to category_lesson_path
    else
      render :edit
    end
  end

  def create
    category = Category.find_by id: params[:category_id]
    @lesson = current_user.lessons.build lesson_params
    if (@lesson.category.words.size >= Settings.number_question)
      if @lesson.save
        flash[:success] = t :lesson_start_success
        redirect_to edit_category_lesson_path category, @lesson
      else
        flash[:danger] = t :lesson_start_fail
        redirect_to categories_path
      end
    else
      flash[:danger] = t :lesson_start_fail
      redirect_to categories_path
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, :result,
      results_attributes: [:id, :word_id, :answer_id]
  end

  def start_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t :lesson_not_found
      redirect_to categories_path
    end
  end

  def check_user
    redirect_to categories_path unless @lesson.score.nil?
  end
end
