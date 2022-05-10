require 'rails_helper'

RSpec.describe PossibleDate, type: :model do
  before do
    @possible_date = FactoryBot.build(:possible_date)
  end

  describe '日程調整ページ候補日' do
    context '新規作成できる場合' do
      it 'event、datetimeが存在する場合は作成できる' do
        expect(@possible_date).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @possible_date.event = nil
        @possible_date.valid?
        expect(@possible_date.errors.full_messages).to include('Event must exist')
      end
      it 'datetimeが空では作成できない' do
        @possible_date.datetime = ''
        @possible_date.valid?
        expect(@possible_date.errors.full_messages).to include("Datetime can't be blank")
      end
    end
  end
end
