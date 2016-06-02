class Battery < Item

  def initialize
    super("Battery", 25)
  end

  def recharge(robot)
    robot.charge(20)
  end

end
