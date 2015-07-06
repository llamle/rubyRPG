require 'colored'
require 'pry'

require_relative 'hero'
require_relative 'monster'
require_relative 'party'

class Game
  attr_reader :heroes

  STOCK_HEROES = [ # Can be accessed OUTSIDE OF Game, with Game::STOCK_HEROES
    Hero.new({
      name: "Gimli",
      hp: 50,
      weapon: Weapon.new({
        name: "Battle Axe",
        damage: 9,
        price: 25
      })
    }),

    Hero.new({
      name: "Legolas",
      hp: 25,
      weapon: Weapon.new({
        name: "Longbow",
        damage: 9,
        price: 25
      })
    }),

    Hero.new({
      name: "Gandalf",
      hp: 80,
      weapon: Weapon.new({
        name: "Magic Staff",
        damage: 5,
        price: 50
      })
    }),

    Hero.new({
      name: "Aragorn",
      hp: 25,
      weapon: Weapon.new({
        name: "Longsword",
        damage: 12,
        price: 25
      })
    }),

    Hero.new({
      name: "Boromir",
      hp: 20,
      weapon: Weapon.new({
        name: "Sword",
        damage: 5,
        price: 25
      })
    })
  ]

  STOCK_MONSTERS = [
    Monster.new({
      name: "Goblin",
      hp: 19,
      weapon: Weapon.new({
        name: "Axe",
        damage: 7,
        price: 10
      }),
      xp: 7,
      gold: 10
    }),

    Monster.new({
      name: "Troll",
      hp: 29,
      weapon: Weapon.new({
        name: "Club",
        damage: 10,
        price: 15
      }),
      xp: 20,
      gold: 37
    }),

    Monster.new({
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
  ]

  def initialize
    @heroes = enlist_heroes
  end

  def enlist_heroes
    show_heroes

    return get_heroes
  end

  def show_heroes
    puts "Greetings Hero! Please select 3 of the following characters to add to your party:"

    STOCK_HEROES.each_with_index do |hero, i|
      puts "#{i + 1}. #{hero}"
    end
  end

  def get_heroes
    resp = []

    while resp.count != 3
      puts "Please enter all three at once separated by a space. (example: 1 2 4)"
      print "> "
      resp = gets.chomp.split(" ").uniq.map { |x| x.to_i - 1 }.sort
      resp = [] if resp.first < 0 || resp.last >= STOCK_HEROES.length
    end

    # hero_party vs @hero_party since we don't need it once it's returned
    hero_party = HeroParty.new

    resp.each do |index|
      hero_party.enroll(STOCK_HEROES[index])
    end

    # this is grabbed during initialize later
    puts "#{hero_party.alive[0]}, #{hero_party.alive[1]}, 'and' #{hero_party.alive[2]} have joined your party."

  end

  def enter_forest
    mp_size = rand(1..3)
    monsters = []
    monsters_party = MonstersParty.new

    monsters.each do |index|
      mp_size.times { monsters_party.enroll(STOCK_MONSTERS[index]) }
    end
    return monsters_party

    combatants = [@heroes, monsters]
    attackers, defenders = combatants

    while defenders.any?
      attackers.attack(defenders)
      combatants.rotate
      attackers, defenders = combatants
      if defenders.any?

      end
      puts defenders " are dead..."
    end
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


#
# current_monsters = [troll, goblin, urukhai]
# current_heroes = []
# current_fighters = [current_heroes[0], current_monsters[0]]
# attacker = current_fighters.shift
# attackee = current_fighters.shift
#
# if current_heroes.length == 3
#   while attackee.is_alive?
#     attacker.attack(attackee)
#
#     puts "#{attacker} attacks #{attackee} with his #{attacker.weapon} for #{attacker.weapon.damage}.  #{attackee} now has #{attackee.current_hp} HP left."
#
#     attacker, attackee = attackee, attacker unless attackee.is_dead?
#   end
# end
#
# puts "#{attackee} is now dead..."

g = Game.new

Pry.start(binding)
