class BillsController < ApplicationController

  respond_to :html

  before_filter :load_bill, :except => [:index, :create, :new]
  authorize_resource


  def index
    @bills = Bill.order('checker_id DESC, created_at ASC')
    respond_with @bills
  end

  def show
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
      location = new_consumptions_bill_url(@bill)
    end
    respond_with(@bill, :location => location)
  end

  def edit
    respond_with(@bill)
  end

  def update
    if(@bill.update_attributes(params[:bill]))
       flash[:notice] = "Successfully edited bill"
    end
    respond_with(@bill, :location => bills_url)
  end

  def new_consumptions
    if @bill.consumptions.empty?
      1.upto(@bill.num_intervals) do |counter|
        @bill.consumptions.build(:sequence_number => counter)
      end
    end
    respond_with(@bill)
  end

  def create_consumptions
    respond_with(@bill) do |format|
      if @bill.update_attributes(params[:bill])
        flash[:notice] = 'Successfully stored consumptions'
        format.html { redirect_to bills_path }
      else
        format.html { render action: "new_consumptions" }
      end
    end
  end

  def check_consumptions
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

  private

  def load_bill
    @bill = Bill.find(params[:id])
  end
end
