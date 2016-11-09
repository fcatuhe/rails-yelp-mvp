class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :category, inclusion: { in: ["chinese", "italian", "japanese", "french", "belgian"], allow_nil: false }
  validates :address, presence: true

  def stars
    ratings = reviews.map { |review| review.rating}.select { |rating| !rating.nil? }
    rating = ratings.size > 0 ? ratings.sum.fdiv(ratings.size).round : 0
    ('<i class="fa fa-star" aria-hidden="true"></i>' * rating + '<i class="fa fa-star-o" aria-hidden="true"></i>' * (5 - rating)).html_safe
  end
end
