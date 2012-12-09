class BillsController < ApplicationController

  respond_to :html

  authorize_resource

  def index
    @bills = Bill.order('checker_id DESC, created_at ASC')
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
    respond_with(@bill, :location => new_consumptions_bill_url(@bill))
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

  def check_consumptions
    @bill = Bill.find(params[:id])
    params[:bill][:consumption_ids].pop
    puts params[:bill][:consumption_ids].inspect
    respond_with(@bill) do |format|
      if(@bill.consumption_ids == params[:bill][:consumption_ids].map{|x| x.to_i})
        @bill.checker = current_user
        @bill.save
        flash[:notice] = "Bill succesfully checked"
        format.html { redirect_to bills_path }
      else
        flash[:error] = "All consumptions must be checked in order to check the bill"
        format.html { render action: 'show' }
      end
    end
  end
end
