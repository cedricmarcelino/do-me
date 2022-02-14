class Task < ApplicationRecord
  belongs_to :user_id
  belongs_to :category
  validates :name, presence: true
end
