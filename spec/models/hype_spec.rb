require 'spec_helper'

describe Hype do
	
	  let(:knocker) { FactoryGirl.create(:knocker) }
	  before { @hype = knocker.hypes.build(content: "Some Hype!") }

	subject { @hype }

	it { should respond_to(:content) }
	it { should respond_to(:knocker_id) }
	it { should respond_to(:knocker) }
	its(:knocker) { should eq knocker }

	it { should be_valid }

	describe "when knocker_id is not present" do
		before { @hype.knocker_id = nil }
		it { should_not be_valid }
	end

	describe "with blank content" do
		before { @hype.content = " " }
		it { should_not be_valid }
	end

	describe "with content that is too long" do
		before { @hype.content = "a" * 141 }
		it { should_not be_valid }
	end
end