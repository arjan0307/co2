class BillsController < ApplicationController

  respond_to :html

  def index
    @bills = Bill.all
    respond_with @bills
  end
end
