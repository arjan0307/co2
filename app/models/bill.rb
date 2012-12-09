class Bill < ActiveRecord::Base
  attr_accessible :consumption_unit, :name, :period_start, :period_stop, :time_unit

  has_many :consumptions
  belongs_to :author, :class_name => 'User'

  @@time_units = {'Days' => 'D', 'Weeks' => 'W', 'Months' => 'M', 'Years' => 'Y'}

  def self.time_units
    @@time_units
  end

  validates_presence_of :name, :period_start, :period_stop, :consumption_unit, :time_unit
  validates_inclusion_of :time_unit, :in => @@time_units.values
end
