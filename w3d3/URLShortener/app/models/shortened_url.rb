# require 'secure_random'

# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  short_url    :string
#  long_url     :string           not null
#  submitter_id :integer          not null
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true
  validates :long_url, presence: true
  validates :submitter_id, presence: true

  def self.random_code
    begin
      url = SecureRandom.urlsafe_base64(16)
      raise "already in database" if ShortenedUrl.exists?(short_url: url)
    rescue
      retry
    end
    url
  end

  def self.create_shortened_url(user, long_url)
    ShortenedUrl.create!(
      submitter_id: user.id,
      short_url: ShortenedUrl.random_code,
      long_url: long_url
    )
  end

  has_many :visitors,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Visit

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :User

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors.select(:visitor_id).uniq.count
  end

  def num_recent_uniques

  end
end
