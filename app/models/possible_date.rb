class PossibleDate < ApplicationRecord
  # バリデーション
  validates :datetime, presence: true

  # アソシエーション
  belongs_to :event
  has_one    :event_date
  has_many   :attendances, dependent: :destroy

  # 日程調整用 引数guestのself候補日のattendanceモデルを返す
  def attendance(guest)
    attendances.each do |attendance|
      return attendance if attendance.guest_id == guest.id
    end
    nil
  end

  # 日程調整用 引数guestのself候補日の出欠回答を返す
  def attendance_answer(guest)
    attendances.each do |attendance|
      return attendance.answer.answer if attendance.guest_id == guest.id
    end
    '-'
  end

  # 日程調整用 self候補日の引数answer_idで指定した出欠回答の数を返す
  def count_attendance_answer(answer_id)
    count = 0
    attendances.each do |attendance|
      count += 1 if attendance.answer_id == answer_id
    end
    count
  end
end
