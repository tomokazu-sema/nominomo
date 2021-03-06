require 'rails_helper'

RSpec.describe Attendance, type: :model do
  before do
    @attendance = FactoryBot.build(:attendance)
  end

  describe '日程調整ページ出欠' do
    context '新規作成できる場合' do
      it 'possible_date、guest、answer_idが存在する場合は作成できる' do
        expect(@attendance).to be_valid
      end
      it 'answer_idが1(初期値)でも作成できる' do
        @attendance.answer_id = 1
        expect(@attendance).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'possible_dateに紐付いていないと作成できない' do
        @attendance.possible_date = nil
        @attendance.valid?
        expect(@attendance.errors.full_messages).to include('Possible dateを入力してください')
      end
      it 'guestに紐付いていないと作成できない' do
        @attendance.guest = nil
        @attendance.valid?
        expect(@attendance.errors.full_messages).to include('Guestを入力してください')
      end
      it 'answer_idが1以上(4以下)でなければ作成できない' do
        @attendance.answer_id = 0
        @attendance.valid?
        expect(@attendance.errors.full_messages).to include('Answerは1以上の値にしてください')
      end
      it 'answer_idが4以下(1以上)でなければ作成できない' do
        @attendance.answer_id = 5
        @attendance.valid?
        expect(@attendance.errors.full_messages).to include('Answerは4以下の値にしてください')
      end
      it 'answer_idが整数でなければ作成できない' do
        tests = [0.1, 1.1, 3.9, 4.9]
        tests.each do |test|
          @attendance.answer_id = test
          @attendance.valid?
          expect(@attendance.errors.full_messages).to include('Answerは整数で入力してください')
        end
      end
    end
  end
end
