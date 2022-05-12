require 'rails_helper'

RSpec.describe Payment, type: :model do
  before do
    @payment = FactoryBot.build(:payment)
  end

  describe '日程調整ページ会費状況' do
    context '新規作成できる場合' do
      it 'guest、payment_management、price、status_idが存在する場合は作成できる' do
        expect(@payment).to be_valid
      end
      it 'priceが空でも作成できる' do
        @payment.price = ''
        expect(@payment).to be_valid
      end
      it 'status_idが1(初期値)でも作成できる' do
        @payment.status_id = 1
        expect(@payment).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'guestに紐付いていないと作成できない' do
        @payment.guest = nil
        @payment.valid?
        expect(@payment.errors.full_messages).to include('Guest must exist')
      end
      it 'payment_managementに紐付いていないと作成できない' do
        @payment.payment_management = nil
        @payment.valid?
        expect(@payment.errors.full_messages).to include('Payment management must exist')
      end
      it 'status_idが1以上(2以下)でなければ作成できない' do
        @payment.status_id = 0
        @payment.valid?
        expect(@payment.errors.full_messages).to include('Status must be greater than or equal to 1')
      end
      it 'status_idが2以下(1以上)でなければ作成できない' do
        @payment.status_id = 3
        @payment.valid?
        expect(@payment.errors.full_messages).to include('Status must be less than or equal to 2')
      end
      it 'status_idが整数でなければ作成できない' do
        tests = [0.1, 1.1, 1.9, 2.9]
        tests.each do |test|
          @payment.status_id = test
          @payment.valid?
          expect(@payment.errors.full_messages).to include('Status must be an integer')
        end
      end
    end
  end
end
