class Bill < ActiveRecord::Base
  attr_accessible :consumption_unit, :name, :period_start, :period_stop, :time_unit

  has_many :consumptions
end
