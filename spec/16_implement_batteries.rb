require_relative 'spec_helper'

describe Battery do
  before :each do 
    @battery = Battery.new
  end

  it "should be an item" do
    expect(@battery.is_a?(Item)).to be true
  end

  it "should recharge a robot's shields by 20" do 
    robot = Robot.new
    robot.wound(30)
    expect(robot.shield).to eq(20)
    @battery.recharge(robot)
    expect(robot.shield).to eq(40)
  end

  it "should automatically recharge when picked up and shields at or below 30" do
    robot = Robot.new
    robot.wound(30)
    robot.pick_up(@battery)
    expect(robot.shield).to eq(40)
  end


end