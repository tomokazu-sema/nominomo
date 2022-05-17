require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.build(:question)
  end

  describe '日程調整ページアンケート' do
    context '新規作成できる場合' do
      it 'event、title、contentが存在する場合は作成できる' do
        expect(@question).to be_valid
      end
      it 'contentが空でも作成できる' do
        @question.content = ''
        expect(@question).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @question.event = nil
        @question.valid?
        expect(@question.errors.full_messages).to include('Eventを入力してください')
      end
      it 'titleが空では作成できない' do
        @question.title = ''
        @question.valid?
        expect(@question.errors.full_messages).to include('アンケート題名を入力してください')
      end
    end
  end
end
