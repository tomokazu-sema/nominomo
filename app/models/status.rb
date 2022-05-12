class Status < ActiveHash::Base
  self.data = [
    { id: 1, status: '未' },
    { id: 2, status: '済' },
  ]

  include ActiveHash::Associations
  has_many :payments
end
