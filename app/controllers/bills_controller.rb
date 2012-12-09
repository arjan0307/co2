class BillsController < ApplicationController

  respond_to :html

  authorize_resource

  def index
    @bills = Bill.all
    respond_with @bills
  end
end
