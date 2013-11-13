class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :start_date, :end_date, :status

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ['PENDING', 'APPROVED', 'DENIED'] }
  validate :overlapping_approved_requests?


  belongs_to(
    :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id
  )

  def overlapping_requests
    query = "
      SELECT crr.*
      FROM cat_rental_requests crr
      WHERE crr.cat_id = ?
      AND (? BETWEEN crr.start_date AND crr.end_date)
    "

    self.class.find_by_sql([query, self.cat_id, self.start_date])
  end

  def overlapping_approved_requests?
    conflict = overlapping_requests.any? { |r| r.status == "APPROVED" }
    errors[:base] << "Time conflict" if conflict && self.status == "PENDING"
  end

  def approve!
    self.class.transaction do
      self.status = "APPROVED"
      self.save!
      overlapping_requests.each do |r|
        r.deny! unless r.id == self.id
      end
    end
  end

  def deny!
    self.status = "DENIED"
    self.save!
  end

end
