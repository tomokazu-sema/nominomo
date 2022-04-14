require 'rails_helper'

RSpec.describe Host, type: :model do
  before do
    @host = FactoryBot.build(:host)
  end

  describe '主催者ページ作成' do
    context '新規作成できる場合' do
      it 'eventが存在する場合は作成できる' do
        expect(@host).to be_valid
      end
    end

    context '新規作成できない場合' do
      it 'eventが存在しない場合は作成できない' do
        @host.event = nil
        @host.valid?
        expect(@host.errors.full_messages).to include('Event must exist')
      end
    end
  end
end
