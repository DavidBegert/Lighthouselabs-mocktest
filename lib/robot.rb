class Robot
  attr_reader :position, :items, :health, :shield
  attr_accessor :equipped_weapon

  @@robots = []

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
    @shield = 50
    @@robots << self
  end

  class << self

    def robots
      @@robots
    end

    def in_position(x,y)
      @@robots.select do |robot|
        robot.position == [x,y]
      end
    end

    def reset_robots
      @@robots = []
    end

  end
  

  def move_left
    @position[0] -= 1
  end

  def move_right
    @position[0] += 1
  end

  def move_up
    @position[1] += 1
  end

  def move_down
    @position[1] -= 1
  end

  def pick_up(item)
    if item.is_a?(BoxOfBolts) && health <= 80 && items_weight + item.weight <= 250
      item.feed(self)
    elsif item.is_a?(Battery) && shield <= 30 && items_weight + item.weight <= 250
      item.recharge(self)
    else
      if items_weight + item.weight <= 250
        self.equipped_weapon = item if item.is_a?(Weapon)
        @items << item
      end
    end
  end

  def items_weight
    items.reduce(0) do |sum, item|
      sum + item.weight
    end
  end

  def wound(dmg)
    if shield > dmg 
      @shield -= dmg
    else #shield <= dmg
      leftover_dmg = dmg - shield
      @shield = 0
      if health - leftover_dmg > 0
        @health -= leftover_dmg
      else
        @health = 0
      end
    end
  end

  def heal(amount)
    if health + amount < 100
      @health += amount
    else
      @health = 100
    end
  end

  def charge(amount)
    if shield + amount < 50
      @shield += amount
    else
      @shield = 50
    end
  end

  def heal!(amount)
    raise RobotAlreadyDeadError if health == 0
    if health + amount < 100
      @health += amount
    else
      @health = 100
    end

  end

  def can_hit_x?(other_robot)
    if equipped_weapon.is_a?(Grenade)
      (other_robot.position[0] - self.position[0]).abs <= 2 && (other_robot.position[1] == self.position[1])  #would be able to do equipped_weapon.range but some weapons dont have range yet
    else
      (other_robot.position[0] - self.position[0]).abs <= 1 && (other_robot.position[1] == self.position[1]) #y do i even need self. here?
    end
  end

  def can_hit_y?(other_robot)
    if equipped_weapon.is_a?(Grenade)
      (other_robot.position[1] - self.position[1]).abs <= 2 && (other_robot.position[0] == self.position[0])
    else
      (other_robot.position[1] - self.position[1]).abs <= 1 && (other_robot.position[0] == self.position[0])
    end
  end

  def attack(enemy_robot)
    if can_hit_x?(enemy_robot) || can_hit_y?(enemy_robot)
      if equipped_weapon.is_a?(Weapon)      #could just be equipped_weapon but this is clearer
        equipped_weapon.hit(enemy_robot)
        self.equipped_weapon = nil
      else
        enemy_robot.wound(5)
      end
    end
  end

  def attack!(enemy)
    raise UnattackableEnemyError unless enemy.is_a?(Robot)
    if equipped_weapon.is_a?(Weapon)     
      equipped_weapon.hit(enemy)
    else
      enemy.wound(5)
    end
  end

  def scan
    @@robots.select do |robot|
      ( (robot.position[0] - self.position[0]).abs == 1 && (robot.position[1] == self.position[1]) ) ||
      ( (robot.position[1] - self.position[1]).abs == 1 && (robot.position[0] == self.position[0]) )
    end
  end

  def destroy_shields
    @shield = 0
  end

  def xplode(dmg)
    arr_of_robots_hit = self.scan << self
    arr_of_robots_hit.each do |robot|
      robot.destroy_shields
      robot.wound(dmg)
    end
  end



end
