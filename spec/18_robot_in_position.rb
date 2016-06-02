require_relative 'spec_helper'


describe Robot do 
  before :each do 
    @robot = Robot.new
  end

  it "should return array of all robots at certain position given" do
    @robot.move_left
    new_robot = Robot.new
    new_robot.move_left
    origin_robot = Robot.new
    expect(Robot.in_position(-1,0)).to eq([@robot, new_robot])
  end

end