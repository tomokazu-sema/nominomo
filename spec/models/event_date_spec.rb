require 'rails_helper'

RSpec.describe EventDate, type: :model do
  before do
    @event_date = FactoryBot.build(:event_date)
  end

  describe '日程調整ページ開催日' do
    context '新規作成できる場合' do
      it 'event、possible_dateが存在する場合は作成できる' do
        expect(@event_date).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @event_date.event = nil
        @event_date.valid?
        expect(@event_date.errors.full_messages).to include('Eventを入力してください')
      end
      it 'possible_dateに紐付いていないと作成できない' do
        @event_date.possible_date = nil
        @event_date.valid?
        expect(@event_date.errors.full_messages).to include('Possible dateを入力してください')
      end
    end
  end
end
