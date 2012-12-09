class Consumption < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :sequence_number, :value

  validates_presence_of :sequence_number, :value

  def interval
    "#{bill.singularized_time_unit} #{sequence_number}"
  end

  def interval_value
    "#{interval} (#{value} #{bill.consumption_unit})"
  end
end
