require 'spec_helper'

describe "ShowController index" do
  before do
    get "/show"
  end

  it 'is ok' do
    last_response.should be_ok
  end
  it "Contains the correct title" do
    last_response.body.should include("<title>Social Studios TV</title>")
  end
end
