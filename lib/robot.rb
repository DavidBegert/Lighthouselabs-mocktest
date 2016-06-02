class Robot
  attr_reader :position, :items, :health
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
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
    else
      if items_weight + item.weight <= 250
        @equipped_weapon = item if item.is_a?(Weapon)
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
    if health - dmg > 0
      @health -= dmg
    else
      @health = 0
    end
  end 

  def heal(amount)
    if @health + amount < 100
      @health += amount
    else
      @health = 100
    end
  end

  def heal!(amount)
    raise RobotAlreadyDeadError if health == 0
    if @health + amount < 100
      @health += amount
    else
      @health = 100
    end

  end

  def nearbyx?(other_robot)
    if equipped_weapon.is_a?(Grenade)
      (other_robot.position[0] - self.position[0]).abs == 2 && (other_robot.position[1] == self.position[1])  #would be able to do equipped_weapon.range but some weapons dont have range yet
    else
      (other_robot.position[0] - self.position[0]).abs == 2 && (other_robot.position[1] == self.position[1]) #y do i even need self. here?
    end
  end

  def nearbyy?(other_robot)
    if equipped_weapon.is_a?(Grenade)
      (other_robot.position[1] - self.position[1]).abs == 2 && (other_robot.position[0] == self.position[0])
    else
      (other_robot.position[1] - self.position[1]).abs == 1 && (other_robot.position[0] == self.position[0])
    end
  end

  def attack(enemy_robot)
    if nearbyx?(enemy_robot) || nearbyy?(enemy_robot)
      if equipped_weapon.is_a?(Weapon)      #could just be equipped_weapon but this is clearer
        equipped_weapon.hit(enemy_robot)
        @equipped_weapon = nil
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


end
