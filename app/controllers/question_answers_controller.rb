class QuestionAnswersController < ApplicationController
  before_action :set_event
  before_action :move_to_event_show_noturbo, only: [:new, :edit]

  before_action :set_guest, only: %i[new edit]
  before_action :set_question, only: %i[new edit]
  before_action :set_question_answer, only: %i[edit update]

  def new
    @question_answer = QuestionAnswer.new
  end

  def create
    @question_answer = QuestionAnswer.new(question_answer_params)
    respond_to do |format|
      if @question_answer.save
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @question_answer.update(question_answer_params)
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_guest
    @guest = Guest.find(params[:guest_id])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_question_answer
    @question_answer = QuestionAnswer.find(params[:id])
  end

  def question_answer_params
    params.require(:question_answer).permit(:guest_id, :answer).merge(question_id: params[:question_id])
  end
end
