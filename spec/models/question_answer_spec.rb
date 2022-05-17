require 'rails_helper'

RSpec.describe QuestionAnswer, type: :model do
  before do
    @question_answer = FactoryBot.build(:question_answer)
  end

  describe '日程調整ページアンケート回答' do
    context '新規作成できる場合' do
      it 'guest、question、answerが存在する場合は作成できる' do
        expect(@question_answer).to be_valid
      end
      it 'answerが空でも作成できる' do
        @question_answer.answer = ''
        expect(@question_answer).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'guestに紐付いていないと作成できない' do
        @question_answer.guest = nil
        @question_answer.valid?
        expect(@question_answer.errors.full_messages).to include('Guestを入力してください')
      end
      it 'questionに紐付いていないと作成できない' do
        @question_answer.question = nil
        @question_answer.valid?
        expect(@question_answer.errors.full_messages).to include('Questionを入力してください')
      end
    end
  end
end
