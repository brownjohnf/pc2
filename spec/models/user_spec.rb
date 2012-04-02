require 'spec_helper'

describe User do
  describe 'abilities' do
    subject { ability }
    let(:ability){ Ability.new(user) }

    context 'when it is a user' do
      let(:user){ Factory(:user) }

      it{ should be_able_to(:read, Page) }
    end
  end
end
