class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :owned_contacts,
  dependent: :destroy,
  class_name: :Contact

  has_many :received_shares,
  dependent: :destroy,
  class_name: :ContactShare

  has_many :received_contacts,
  through: :received_shares,
  source: :contact


end
