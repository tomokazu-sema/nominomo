class Answer < ActiveHash::Base
  self.data = [
    { id: 1, answer: '-' },
    { id: 2, answer: '◯' },
    { id: 3, answer: '△' },
    { id: 4, answer: '×' }
  ]

  include ActiveHash::Associations
  has_many :attendances
end
