require 'rails_helper'

RSpec.describe Notice, type: :model do
  before do
    @notice = FactoryBot.build(:notice)
  end

  describe '日程調整ページお知らせ' do
    context '新規作成できる場合' do
      it 'event、messageが存在する場合は作成できる' do
        expect(@notice).to be_valid
      end
      it 'messageが空でも作成できる' do
        @notice.message = ''
        expect(@notice).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventに紐付いていないと作成できない' do
        @notice.event = nil
        @notice.valid?
        expect(@notice.errors.full_messages).to include('Eventを入力してください')
      end
    end
  end
end
