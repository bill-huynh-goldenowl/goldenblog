class Post < ApplicationRecord
  has_and_belongs_to_many :categories
  belongs_to :user

  enum status: [:awaiting_approval, :approval, :disapproval]
end
