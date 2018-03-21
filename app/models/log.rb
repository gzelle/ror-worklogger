class Log < ApplicationRecord
  belongs_to :user
  belongs_to :project
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :duration, presence: true,  numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :remarks, presence: true
end
