class ContactShare < ActiveRecord::Base
  validates :contact_id, :user_id, presence: true

  belongs_to :recipient,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :contact

end
