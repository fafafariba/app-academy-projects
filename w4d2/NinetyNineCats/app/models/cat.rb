class Cat < ApplicationRecord
  COLORS = %w(black white orange brown)

  validates :birth_date, :name, :color, :sex, presence: true
  validates :sex, inclusion: { in: %w(m f), message: "%{value} is not valid" }
  validates :color, inclusion: { in: COLORS, message: "%{value} is not valid" }

  validate :valid_birth_date

  has_many :cat_rental_requests, dependent: :destroy



  def valid_birth_date
    if self.birth_date > Date.today
      self.errors[:birth_date] << "must be before today"
    end
  end

  def age
    ((Date.today - self.birth_date) / 365.25).to_i
  end
end
