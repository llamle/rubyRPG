require 'colored'
require 'pry'

require_relative 'hero'
require_relative 'monster'
require_relative 'party'

class Game  
  def initialize
    @heroes = enlist_heroes
  end

  def enlist_heroes
    # Display choices for heroes
    # Prompt (gets) the user for choices e.g. 2, 6
    # Create a part with those heroes in it and return it
  end

  def enter_forest

  end

  def enter_shop

  end

  def town_message
    puts <<-PLAY_MESSAGE
    Your heroes are ready for action,
    should they...
    1. Enter the forest?
    2. Go shopping for wares?
    PLAY_MESSAGE
  end

  def get_location
    resp = gets.chomp

    if resp == "1"
      return :forest
    else
      return :shop
    end
  end

  def play
    town_message
    case get_location
    when :forest
      enter_forest
    when :shop
      enter_shop
    end
  end
end

artemis = Hero.new({
  name: "Artemis",
  hp: 20,
  weapon: Weapon.new({
    name: "longbow",
    damage: 6,
    price: 25
  })
})

goblin = Monster.new({
  name: "Goblin, father of 7",
  hp: 9,
  weapon: Weapon.new({
    name: "his wife's rusty last kitchen knife",
    damage: 1,
    price: 1
  }),
  xp: 2,
  gold: 1
})

current_fighters = [artemis, goblin]
attacker = current_fighters.shift
attackee = current_fighters.shift

while attackee.is_alive?
  attacker.attack(attackee)

  puts "#{attacker} attacks #{attackee} with his #{attacker.weapon} for #{attacker.weapon.damage}.  #{attackee} now has #{attackee.current_hp} HP left."

  attacker, attackee = attackee, attacker unless attackee.is_dead?
end

puts "#{attackee} is now dead..."

Pry.start(binding)
