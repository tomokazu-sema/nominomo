class QuestionsController < ApplicationController
  before_action :set_event
  before_action :set_question, only: %i[edit update]

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to event_path(@event) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@event), status: :see_other }
    end
  end

  private

  def set_event
    @event = Event.find_by(uid: params[:event_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :content).merge(event_id: @event.id)
  end
end
