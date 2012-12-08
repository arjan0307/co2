require 'spec_helper'

describe "Bills" do
  describe "GET /bills" do
    it "displays bills" do
      visit bills_path
      response.status.should be(200)
    end
  end
end
