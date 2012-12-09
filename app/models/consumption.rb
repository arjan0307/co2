class Consumption < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :sequence_number, :value

  validates_presence_of :sequence_number, :value
end
