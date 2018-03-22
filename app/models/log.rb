class Log < ApplicationRecord
	attr_accessor :sdate, :edate

	belongs_to :user
	belongs_to :project
	default_scope -> { order(created_at: :desc) }
	validates :user_id, presence: true
	validates :duration, presence: true,  numericality: { only_integer: true, greater_than_or_equal_to: 0}
	validates :remarks, presence: true
	validates :startdate, presence: true

	def Log.get_total_hours(logs)
    	logs.inject(0) { |sum, l| sum + l.duration }
	end

	def Log.filter_dates(current_user, startdate, enddate)
		current_user.logs.where("startdate >= ? AND startdate <= ?", startdate, enddate)
	end
end
