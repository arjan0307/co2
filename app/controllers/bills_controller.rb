class BillsController < ApplicationController

  respond_to :html

  authorize_resource

  def index
    @bills = Bill.all
    respond_with @bills
  end

  def show
    @bill = Bill.find(params[:id])
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

  def new_consumptions
    @bill = Bill.find(params[:id])
    if @bill.consumptions.empty?
      1.upto(@bill.num_intervals) do |counter|
        @bill.consumptions.build(:sequence_number => counter)
      end
    end
    respond_with(@bill)
  end

  def create_consumptions
    @bill = Bill.find(params[:id])
    respond_with(@bill) do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to bills_path }
      else
        format.html { render action: "new_consumptions" }
      end
    end
  end
end
