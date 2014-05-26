require 'spec_helper'

describe Char do

  describe "delegate_to and undelegate" do
    it "delegates and undelegates" do
      user = create :user
      char = build_stubbed :char
      expect{ char.delegate_to user}.to change{char.users.size}.by(1)
      expect{ char.undelegate user}.to change{char.users.size}.by(-1)
    end

    it "makes the user an owner" do
      user = create :user
      char = create :char
      expect{ char.delegate_to user, owner:1}.to change{char.char_delegations.where(owner:1).size}.by(1)
    end
  end

end
