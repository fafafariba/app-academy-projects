class CatRentalRequest < ApplicationRecord
  STATUSES = %w(pending approved denied)

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: STATUSES, message: "%{value} is not valid" }
  validate :end_date_later_than_start
  validate :cat_overlap

  belongs_to :cat

  def approve!
    if self.status = "pending"
      self.transaction do
        begin
          self.status = "approved"
          self.save
        rescue
          self.deny!
        end
      end
    end
  end

  def deny!
    transaction do
      self.status = "denied"
      self.save
    end
    self.errors.full_messages
  end



  def end_date_later_than_start
    if self.end_date < self.start_date
      self.errors[:end_date] << "must be later than start date"
    end
  end

  def cat_overlap
    date_range = self.start_date..self.end_date
    bookings = CatRentalRequest.where(cat_id: self.cat_id, status: "approved")
                               .where.not(id: self.id)
                               .where("start_date IN (?) OR end_date IN (?)", date_range, date_range)
    unless bookings.empty?
      self.errors[:overlap] << "in dates"
    end
  end
end
