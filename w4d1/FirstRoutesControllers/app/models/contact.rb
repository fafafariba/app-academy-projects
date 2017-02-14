class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :email, uniqueness: {scope: :user_id}
  # validate :no_duplicate_email

  belongs_to :owner,
  class_name: :User,
  foreign_key: :user_id

  has_many :contact_shares

  has_many :recipients,
  through: :contact_shares,
  source: :recipient

  # def no_duplicate_email
  #   if Contact.exists?(user_id: self.user_id, email: self.email)
  #     self.errors[:email] << "already exists"
  #   end
  # end
end
