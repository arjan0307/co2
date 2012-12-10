require 'spec_helper'

describe "Bills" do
  describe "GET /bills" do
    it "displays bills" do
      sign_in_as_a_valid_user(FactoryGirl.create(:secretary)) 
      visit bills_path
      page.should have_content('Bills')
    end
  end

  describe "The new bill process" do
    it 'creates a new bill' do
      sign_in_as_a_valid_user(FactoryGirl.create(:secretary)) 
      visit new_bill_path
      fill_in "Name", :with => 'My bill'
      select 'January', :from => 'bill_period_start_2i'
      select 'December', :from => 'bill_period_stop_2i'
      fill_in "Consumption unit", :with => 'kWh'
      choose 'Months'
      click_button "Create Bill"
      page.should have_content('Bill succesfully added')
    end
  end

  describe "The checking a bill process" do
    it 'checks a bill' do
      sign_in_as_a_valid_user(FactoryGirl.create(:manager))
      bill = FactoryGirl.create(:bill_with_consumptions)
      visit bill_path(bill)
      check 'Month 1'
      check 'Month 2'
      click_button "Check bill"
      page.should have_content('Bill succesfully checked')
    end
  end
end
