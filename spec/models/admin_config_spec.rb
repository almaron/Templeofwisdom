require 'rails_helper'

describe AdminConfig do
  it "should assemble configuration" do
    create :admin_config
    create :int_config
    config = AdminConfig.to_hash
    expect(config).to eq({string: "value", int: 12345})
  end

end
