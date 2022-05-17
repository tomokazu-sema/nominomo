require 'rails_helper'

RSpec.describe PaymentManagement, type: :model do
  before do
    @payment_management = FactoryBot.build(:payment_management)
  end

  describe '日程調整ページ会費管理' do
    context '新規作成できる場合' do
      it 'eventが存在する場合は作成できる' do
        expect(@payment_management).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @payment_management.event = nil
        @payment_management.valid?
        expect(@payment_management.errors.full_messages).to include('Eventを入力してください')
      end
    end
  end
end
