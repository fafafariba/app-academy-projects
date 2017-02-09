# == Schema Information
#
# Table name: visits
#
#  id               :integer          not null, primary key
#  shortened_url_id :integer          not null
#  visitor_id       :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Visit < ActiveRecord::Base
  validates :shortened_url_id, presence: true # ShortenedUrl.id
  validates :visitor_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(
    shortened_url_id: shortened_url.id,
    visitor_id: user.id
    )
  end


end
