class Event < ApplicationRecord
  has_secure_password

  # ランダム文字列をuidカラムに格納
  uid_length = 32
  uid_ranges   = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a
  generate_public_uid column: :uid, generator: PublicUid::Generators::RangeString.new(uid_length, uid_ranges)

  # urlの:idをuidの値に置き換える
  def to_param
    uid
  end

  # バリデーション
  validates :title, presence: true

  # アソシエーション
  belongs_to :user, optional: true
  has_one :host
end
