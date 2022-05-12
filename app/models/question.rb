class Question < ApplicationRecord
  # バリデーション
  validates :title, presence: true

  # アソシエーション
  belongs_to :event
  has_many   :question_answers, dependent: :destroy

  # アンケート用 引数guestのselfアンケートのquestion_answerモデルを返す
  def question_answer(guest)
    question_answers.each do |question_answer|
      return question_answer if question_answer.guest_id == guest.id
    end
    nil
  end
end
