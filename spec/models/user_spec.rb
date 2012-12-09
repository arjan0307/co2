require 'spec_helper'
require 'cancan/matchers'

describe User do
  describe "abilities" do
    subject { ability }
    let(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is a manager" do
      let(:user){ FactoryGirl.create(:user) }

      it{ should be_able_to(:read, Bill) }
    end
  end
end
