require 'rails_helper'

RSpec.describe Guest, type: :model do
  before do
    @guest = FactoryBot.build(:guest)
  end

  describe '日程調整ページ参加者' do
    context '新規作成できる場合' do
      it 'event、name、commentが存在する場合は作成できる' do
        expect(@guest).to be_valid
      end
      it 'commentが空でも作成できる' do
        @guest.comment = ''
        expect(@guest).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @guest.event = nil
        @guest.valid?
        expect(@guest.errors.full_messages).to include('Eventを入力してください')
      end
      it 'nameが空では作成できない' do
        @guest.name = ''
        @guest.valid?
        expect(@guest.errors.full_messages).to include('名前を入力してください')
      end
    end
  end
end
