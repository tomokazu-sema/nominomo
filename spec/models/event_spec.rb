require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end

  describe '日程調整ページ作成' do
    context '新規作成できる場合' do
      it 'user、title、password_digestが存在する場合は作成できる' do
        expect(@event).to be_valid
      end
      it 'userが存在しなくても作成できる' do
        @event.user = nil
        expect(@event).to be_valid
      end
      it 'password_digestが空でも作成できる' do
        @event.password_digest = ''
        expect(@event).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'titleが空では作成できない' do
        @event.title = ''
        @event.valid?
        expect(@event.errors.full_messages).to include('イベント名を入力してください')
      end
    end
  end
end
