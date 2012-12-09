require 'spec_helper'

describe "Bills" do
  describe "GET /bills" do
    it "displays bills" do
      sign_in_as_a_valid_user
      visit bills_path
      page.should have_content('Bills')
    end
  end
end
