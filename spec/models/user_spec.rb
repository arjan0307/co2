  require 'spec_helper'
  require 'cancan/matchers'

  describe User do
    describe "abilities" do
      subject { ability }
      let(:ability){ Ability.new(user) }
      let(:user){ nil }

      context "when is a manager" do
        let(:user){ FactoryGirl.create(:manager) }

        it{ should be_able_to(:read, Bill) }
        it{ should be_able_to(:check_consumptions, FactoryGirl.create(:bill_with_consumptions, :author_id => FactoryGirl.create(:secretary).id)) }

        it{ should_not be_able_to(:new, Bill) }
        it{ should_not be_able_to(:create, FactoryGirl.build(:bill, :author_id => user.id)) }
        it{ should_not be_able_to(:update, FactoryGirl.create(:bill, :author_id => user.id)) }
        it{ should_not be_able_to(:new_consumptions, FactoryGirl.create(:bill, :author_id => user.id)) }
        it{ should_not be_able_to(:create_consumptions, FactoryGirl.create(:bill, :author_id => user.id)) }

      end

      context "when is a secetary" do
        let(:user) { FactoryGirl.create(:secretary) }

        it{ should be_able_to(:read, Bill) }
        it{ should be_able_to(:new, Bill) }
        it{ should be_able_to(:create, FactoryGirl.build(:bill, :author_id => user.id)) }
        it{ should be_able_to(:update, FactoryGirl.create(:bill, :author_id => user.id)) }
        it{ should be_able_to(:new_consumptions, FactoryGirl.create(:bill, :author_id => user.id)) }
        it{ should be_able_to(:create_consumptions, FactoryGirl.create(:bill, :author_id => user.id)) }

        it{ should_not be_able_to(:check_consumptions, FactoryGirl.create(:bill_with_consumptions, :author_id => FactoryGirl.create(:secretary).id)) }
    end
  end
end
