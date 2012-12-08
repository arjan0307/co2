class Consumption < ActiveRecord::Base
  belongs_to :bill
  attr_accessible :sequence_number, :value
end
