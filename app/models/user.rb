class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ランダム文字列をuidカラムに格納
  uid_num_char = 16
  uid_ranges   = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  generate_public_uid column: :uid, generator: PublicUid::Generators::RangeString.new(uid_num_char, uid_ranges)

  # urlの:idをuidの値に置き換える
  def to_param
    uid
  end

  # バリデーション
  validates :name, presence: true
end
