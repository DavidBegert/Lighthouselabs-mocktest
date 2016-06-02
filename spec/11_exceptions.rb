require_relative 'spec_helper'

describe Robot do 
  before :each do
    @robot = Robot.new
  end


  describe "#heal!" do
    it "should raise an error if hp is 0" do
      @robot.wound(100)
      expect { @robot.heal!(100) }.to raise_error(RobotAlreadyDeadError)
    end

    it "should still heal if hp is above 0" do
      @robot.wound(80)
      @robot.heal!(60)
      expect(@robot.health).to eq(80)
    end
  end

  describe "#attack!" do
    it "should raise an error if given anything other than a robot" do
      item = Laser.new
      expect { @robot.attack!(item) }.to raise_error(UnattackableEnemyError)
    end
    it "should still attack robots" do
      new_robo = Robot.new
      expect(@robot.attack!(new_robo)).to be_truthy
    end
  end



end
