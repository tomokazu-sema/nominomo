require 'rails_helper'

RSpec.describe EventPlace, type: :model do
  before do
    @event_place = FactoryBot.build(:event_place)
  end

  describe '日程調整ページ開催場所' do
    context '新規作成できる場合' do
      it 'event、place、url、commentが存在する場合は作成できる' do
        expect(@event_place).to be_valid
      end
      it 'urlが存在しなくても作成できる' do
        @event_place.url = ''
        expect(@event_place).to be_valid
      end
      it 'commentが空でも作成できる' do
        @event_place.comment = ''
        expect(@event_place).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @event_place.event = nil
        @event_place.valid?
        expect(@event_place.errors.full_messages).to include('Event must exist')
      end
      it 'placeが空では作成できない' do
        @event_place.place = ''
        @event_place.valid?
        expect(@event_place.errors.full_messages).to include("Place can't be blank")
      end
    end
  end
end
