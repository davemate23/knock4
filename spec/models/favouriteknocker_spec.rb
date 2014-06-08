require 'spec_helper'

describe Favouriteknocker do
  
  let(:favourited) { FactoryGirl.create(:knocker) }
  let(:favourite) { FactoryGirl.create(:knocker) }
  let(:favouriteknocker) { favourited.favouriteknockers.build(favourite_id: favourite.id) }

  subject { favouriteknocker }

  it { should be_valid }

  describe "favourited methods" do
  	it { should respond_to(:favourited) }
  	it { should respond_to(:favourite) }
  	its(:favourited) { should eq favourited }
  	its(:favourite) { should eq favourite }
  end

  describe "when favourite id is not present" do
  	before { favouriteknocker.favourite_id = nil }
  	it { should_not be_valid }
  end

  describe "when favourited id is not present" do
  	before { favouriteknocker.favourited_id = nil }
  	it { should_not be_valid }
  end
end
