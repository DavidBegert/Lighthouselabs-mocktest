class Bomb < Weapon

  attr_reader :range

  def initialize
    super("Bomb", 25, 30)
    @range = 1
  end

  def hit(enemy_robot)
    enemy_robot.xplode(damage)
  end
end