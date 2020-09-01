class Category < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :title, presence: true, length: {minimum: 6, maximum: 30}
  validates :description, length: {minimum: 30, maximum: 100}
end