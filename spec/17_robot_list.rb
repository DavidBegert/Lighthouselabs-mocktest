require_relative 'spec_helper'


describe Robot do 
  before :each do 
    @robot = Robot.new
  end

  it "should keep track of robots instantiated" do
    Robot.new
    Robot.new
    expect(Robot.robots.size).to eq(3)
  end

end 