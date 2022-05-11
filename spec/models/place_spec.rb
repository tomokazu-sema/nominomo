require 'rails_helper'

RSpec.describe EventPlace, type: :model do
  before do
    @place = FactoryBot.build(:place)
  end

  describe '日程調整ページ開催場所' do
    context '新規作成できる場合' do
      it 'event、place、url、commentが存在する場合は作成できる' do
        expect(@place).to be_valid
      end
      it 'urlが存在しなくても作成できる' do
        @place.url = ''
        expect(@place).to be_valid
      end
      it 'commentが空でも作成できる' do
        @place.comment = ''
        expect(@place).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @place.event = nil
        @place.valid?
        expect(@place.errors.full_messages).to include('Event must exist')
      end
      it 'placceが空では作成できない' do
        @place.place = ''
        @place.valid?
        expect(@place.errors.full_messages).to include("Place can't be blank")
      end
    end
  end
end
