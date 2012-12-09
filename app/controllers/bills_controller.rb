class BillsController < ApplicationController

  respond_to :html

  authorize_resource

  def index
    @bills = Bill.all
    respond_with @bills
  end

  def new
    @bill = Bill.new
    respond_with(@bill)
  end

  def create
    @bill = Bill.new(params[:bill])
    @bill.author = current_user 
    if @bill.save
      flash[:notice] = "Bill succesfully added"
    end
    respond_with(@bill, :location => bills_url)
  end


end
