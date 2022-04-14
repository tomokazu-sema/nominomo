require 'rails_helper'

RSpec.describe Event, type: :model do
  before do
    @event = FactoryBot.build(:event)
  end

  describe '日程調整ページ作成' do
    context '新規作成できる場合' do
      it 'user、title、password_digestが存在する場合は登録できる' do
        expect(@event).to be_valid
      end
      it 'userが存在しなくても登録できる' do
        @event.user = nil
        expect(@event).to be_valid
      end
      it 'password_digestが空でも登録できる' do
        @event.password_digest = ''
        expect(@event).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'titleが空では登録できない' do
        @event.title = ''
        @event.valid?
        expect(@event.errors.full_messages).to include("Title can't be blank")
      end
    end
  end
end
