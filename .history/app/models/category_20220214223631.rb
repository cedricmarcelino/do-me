class Category < ApplicationRecord
  belongs_to :user
  has_many :task
  validates :name, :description, presence: true
end
