require_relative 'spec_helper'

describe Robot do 
  before :each do 
    @robot = Robot.new
    @up_robot = Robot.new
    @up_robot.move_up
    @down_robot = Robot.new
    @down_robot.move_down
    @left_robot = Robot.new
    @left_robot.move_left
  end

  describe "#scan" do
    it "should return an array of robots nearby" do
      expect(@robot.scan).to eq([@up_robot, @down_robot, @left_robot])
    end
  end

  describe "#xplode" do
    it "should hit everyone around, killing shields and doing 30 hp damage" do
      attacker_robot = Robot.new
      bomb = Bomb.new
      attacker_robot.pick_up(bomb)
      attacker_robot.attack(@robot)
      expect(@robot.health).to eq(70)
      expect(@robot.shield).to eq(0)
      expect(@up_robot.health).to eq(70)
      expect(@up_robot.shield).to eq(0)
      expect(@left_robot.health).to eq(70)
    end
  end


end

