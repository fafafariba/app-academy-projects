# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :submitted_urls,
    primary_key: :id, # User.id
    foreign_key: :submitter_id,
    class_name: :ShortenedUrl

  has_many :visited_urls,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: :Visit
end
