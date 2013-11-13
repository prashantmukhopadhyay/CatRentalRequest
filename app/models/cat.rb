class Cat < ActiveRecord::Base
  COLORS = [
    "White",
    "Black",
    "Black and White",
    "Redish",
    "Brown",
    "Orange",
    "Yellow"
  ]

  attr_accessible :name, :color, :birthday, :age, :sex

  validates :name, :color, :age, :sex, presence: true
  validates :age, numericality: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: ["F", "M"] }

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy
  )


end
