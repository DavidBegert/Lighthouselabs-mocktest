require_relative 'spec_helper'

describe Robot do 

  before :each do 
    @robot = Robot.new
  end

  it "should start with 50 shield points" do
    expect(@robot.shield).to eq(50)
  end

  describe "#wound" do
    it "should not lose any health if there is shield, only should lose shield" do
      @robot.wound(50)
      expect(@robot.health).to eq(100)
      expect(@robot.shield).to eq(0)
    end

    it "should lose health if there is no shield" do
      @robot.wound(50)
      @robot.wound(50)
      expect(@robot.health).to eq(50)
      expect(@robot.shield).to eq(0)
    end

    it "should lose remaining shield and then health when damaged by more than the remaining shield" do
      @robot.wound(100)
      expect(@robot.health).to eq(50)
      expect(@robot.shield).to eq(0)
    end

  end



end