class Bill < ActiveRecord::Base
  attr_accessible :consumption_unit, :name, :period_start, :period_stop, :time_unit, :consumptions_attributes

  has_many :consumptions

  accepts_nested_attributes_for :consumptions

  belongs_to :author, :class_name => 'User'

  belongs_to :checker, :class_name => 'User'

  @@time_units = {'Days' => 'D', 'Weeks' => 'W', 'Months' => 'M', 'Years' => 'Y'}

  before_save :end_of_month

  def self.time_units
    @@time_units
  end

  validates_presence_of :name, :period_start, :period_stop, :consumption_unit, :time_unit
  validates_inclusion_of :time_unit, :in => @@time_units.values
  validates_datetime :period_stop, :on_or_after => :period_start, :after_message => 'Must be after Period start'

  def num_intervals
    case time_unit
    when 'D'
      (period_stop - period_start).to_i
    when 'W'
      ((period_stop - period_start) / 7).ceil.to_i
    when 'M'
      (period_stop.year*12+(period_stop.month + 1)) - (period_start.year*12+period_start.month).to_i
    when 'Y'
      ((period_stop.year + 1) - period_start.year).to_i
    end
  end

  def singularized_time_unit
    @@time_units.invert[time_unit].singularize
  end

  private

  def end_of_month
    self.period_stop = period_stop.end_of_month
  end

end
