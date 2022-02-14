class Task < ApplicationRecord
  belongs_to :user_id
  belongs_to :category
end
