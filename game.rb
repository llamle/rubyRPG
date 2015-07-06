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

    def pick_heroes
      puts <<-SELECT_HEROES
      Greetings Hero! Please select 3 of the following characters to add to your party:
          1. "Gimli"
          2. "Gandalf"
          3. "Legolas"
          4. "Aragorn"
          5. "Boromir"
      Please enter all three at once separated by a space.
      SELECT_HEROES
    end

    def gets_heroes
      def get_heroes
        resp = gets.chomp.split(" ")

        resp.each do |chosen_hero|

          if chosen_hero == "Gimli" || chosen_hero == "1"
            if current_heroes.length < 4
              current_heroes << gimli
            else
              puts "Your party is full."
            end

          elsif chosen_hero == "Gandalf" || chosen_hero == "2"
            if current_heroes.length < 4
              current_heroes << gandalf
            else
              puts "Your party is full."
            end

          elsif chosen_hero == "Legolas" || chosen_hero == "3"
            if current_heroes.length < 4
              current_heroes << legolas
            else
              puts "Your party is full."
            end

          elsif chosen_hero == "Aragorn" || chosen_hero == "4"
            if current_heroes.length < 4
              current_heroes << aragorn
            else
              puts "Your party is full."
            end

          elsif chosen_hero == "Boromir" || chosen_hero == "5"
            if current_heroes.length < 4
              current_heroes << boromir
            else
              puts "Your party is full."
            end

          else
            get_heroes
          end
        end
      end
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

gimli = Hero.new({
  name: "Gimli",
  hp: 50,
  weapon: Weapon.new({
    name: "Battle Axe",
    damage: 9,
    price: 25
  })
})

gandalf = Hero.new({
  name: "Gandalf",
  hp: 80,
  weapon: Weapon.new({
    name: "Magic Staff",
    damage: 5,
    price: 50
  })
})

legolas = Hero.new({
  name: "Legolas",
  hp: 25,
  weapon: Weapon.new({
    name: "Longbow",
    damage: 9,
    price: 25
  })
})

aragorn = Hero.new({
  name: "Aragorn",
  hp: 25,
  weapon: Weapon.new({
    name: "Longsword",
    damage: 12,
    price: 25
  })
})

boromir = Hero.new({
  name: "Boromir",
  hp: 20,
  weapon: Weapon.new({
    name: "Sword",
    damage: 5,
    price: 25
  })
})

goblin = Monster.new({
  name: "Goblin",
  hp: 19,
  weapon: Weapon.new({
    name: "Axe",
    damage: 7,
    price: 10
  }),
  xp: 7,
  gold: 10
})

troll = Monster.new({
  name: "Troll",
  hp: 29,
  weapon: Weapon.new({
    name: "Club",
    damage: 10,
    price: 15
  }),
  xp: 20,
  gold: 37
})

urukhai = Monster.new({
  name: "Uruk-Hai",
  hp: 75,
  weapon: Weapon.new({
    name: "Broad Sword",
    damage: 15,
    price: 150
  }),
  xp: 50,
  gold: 87
})

current_monsters = [troll, goblin, urukhai]
current_heroes = []
current_fighters = [current_heroes[0], current_monsters[0]]
attacker = current_fighters.shift
attackee = current_fighters.shift

if current_heroes.length == 3
  while attackee.is_alive?
    attacker.attack(attackee)

    puts "#{attacker} attacks #{attackee} with his #{attacker.weapon} for #{attacker.weapon.damage}.  #{attackee} now has #{attackee.current_hp} HP left."

    attacker, attackee = attackee, attacker unless attackee.is_dead?
  end
end

puts "#{attackee} is now dead..." end

g = Game.new
g.enlist_heroes
