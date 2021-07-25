require 'minitest/autorun'
require 'minitest/pride'
require './lib/colorado_lottery'
require './lib/contestant'
require './lib/game'

class ColoradoLotteryTest < Minitest::Test
  def test_it_exists
    lottery = ColoradoLottery.new

    assert_instance_of(ColoradoLottery, lottery)
  end

  def test_it_starts_with_no_registered_contestants
    lottery = ColoradoLottery.new

    assert_empty(lottery.registered_contestants)
    assert_kind_of(Hash, lottery.registered_contestants)
  end

  def test_it_starts_with_no_winners
    lottery = ColoradoLottery.new

    assert_empty(lottery.registered_contestants)
    assert_kind_of(Array, lottery.winners)
  end

  def test_it_starts_with_no_current_contestants
    lottery = ColoradoLottery.new

    assert_empty(lottery.current_contestants)
    assert_kind_of(Hash, lottery.current_contestants)
  end

  def test_it_checks_interest_and_18_or_older
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })
    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100
    })
    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglas',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20
    })
    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5
    })
    alexander.add_game_interests('Pick 4')
    alexander.add_game_interests('Mega Millions')
    frederick.add_game_interests('Mega Millions')
    winston.add_game_interests('Cash 5')
    winston.add_game_interests('Mega Millions')
    benjamin.add_game_interests('Mega Millions')

    assert(lottery.interested_and_18?(alexander, pick_4))
    refute(lottery.interested_and_18?(benjamin, mega_millions))
    refute(lottery.interested_and_18?(alexander, cash_5))
  end

  def test_if_contestants_can_register
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })
    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100
    })
    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglas',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20
    })
    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5
    })
    alexander.add_game_interests('Pick 4')
    alexander.add_game_interests('Mega Millions')
    frederick.add_game_interests('Mega Millions')
    winston.add_game_interests('Cash 5')
    winston.add_game_interests('Mega Millions')
    benjamin.add_game_interests('Mega Millions')

    assert(lottery.can_register?(alexander, pick_4))
    refute(lottery.can_register?(alexander, cash_5))
    assert(lottery.can_register?(frederick, mega_millions))
    refute(lottery.can_register?(benjamin, mega_millions))
    refute(lottery.can_register?(frederick, cash_5))
  end

  def test_it_can_register_contestants
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })
    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100
    })
    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglas',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20
    })
    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5
    })
    alexander.add_game_interests('Pick 4')
    alexander.add_game_interests('Mega Millions')
    frederick.add_game_interests('Mega Millions')
    winston.add_game_interests('Cash 5')
    winston.add_game_interests('Mega Millions')
    benjamin.add_game_interests('Mega Millions')

    lottery.register_contestant(alexander, pick_4)

    assert_equal({"Pick 4" => [alexander]}, lottery.registered_contestants)

    lottery.register_contestant(alexander, mega_millions)

    assert_equal({"Pick 4" => [alexander], "Mega Millions" => [alexander]},
      lottery.registered_contestants
    )

    lottery.register_contestant(frederick, mega_millions)
    lottery.register_contestant(winston, cash_5)
    lottery.register_contestant(winston, mega_millions)

    assert_equal({
      "Pick 4" => [alexander],
      "Mega Millions" => [alexander, frederick, winston],
      "Cash 5" => [winston]
      },
      lottery.registered_contestants
    )

    grace = Contestant.new({
      first_name: 'Grace',
      last_name: 'Hopper',
      age: 20,
      state_of_residence: 'CO',
      spending_money: 20
    })
    grace.add_game_interests('Mega Millions')
    grace.add_game_interests('Cash 5')
    grace.add_game_interests('Pick 4')
    lottery.register_contestant(grace, mega_millions)
    lottery.register_contestant(grace, cash_5)
    lottery.register_contestant(grace, pick_4)

    assert_equal({
      "Pick 4" => [alexander, grace],
      "Mega Millions" => [alexander, frederick, winston, grace],
      "Cash 5" => [winston, grace]
      },
      lottery.registered_contestants
    )
  end

  def test_it_can_list_eligible_contestants_for_each_game
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })
    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100
    })
    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglas',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20
    })
    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5
    })
    grace = Contestant.new({
      first_name: 'Grace',
      last_name: 'Hopper',
      age: 20,
      state_of_residence: 'CO',
      spending_money: 20
    })
    alexander.add_game_interests('Pick 4')
    alexander.add_game_interests('Mega Millions')
    frederick.add_game_interests('Mega Millions')
    winston.add_game_interests('Cash 5')
    winston.add_game_interests('Mega Millions')
    benjamin.add_game_interests('Mega Millions')
    grace.add_game_interests('Mega Millions')
    grace.add_game_interests('Cash 5')
    grace.add_game_interests('Pick 4')
    lottery.register_contestant(alexander, pick_4)
    lottery.register_contestant(alexander, mega_millions)
    lottery.register_contestant(frederick, mega_millions)
    lottery.register_contestant(winston, cash_5)
    lottery.register_contestant(winston, mega_millions)
    lottery.register_contestant(grace, mega_millions)
    lottery.register_contestant(grace, cash_5)
    lottery.register_contestant(grace, pick_4)

    assert_equal([alexander, grace], lottery.eligible_contestants(pick_4))
    assert_equal([winston, grace], lottery.eligible_contestants(cash_5))
    assert_equal(
      [alexander, frederick, winston, grace],
      lottery.eligible_contestants(mega_millions)
    )
  end

  def test_it_can_charge_contestants
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })
    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100
    })
    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglas',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20
    })
    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5
    })
    grace = Contestant.new({
      first_name: 'Grace',
      last_name: 'Hopper',
      age: 20,
      state_of_residence: 'CO',
      spending_money: 20
    })
    alexander.add_game_interests('Pick 4')
    alexander.add_game_interests('Mega Millions')
    frederick.add_game_interests('Mega Millions')
    winston.add_game_interests('Cash 5')
    winston.add_game_interests('Mega Millions')
    benjamin.add_game_interests('Mega Millions')
    grace.add_game_interests('Mega Millions')
    grace.add_game_interests('Cash 5')
    grace.add_game_interests('Pick 4')
    lottery.register_contestant(alexander, pick_4)
    lottery.register_contestant(alexander, mega_millions)
    lottery.register_contestant(frederick, mega_millions)
    lottery.register_contestant(winston, cash_5)
    lottery.register_contestant(winston, mega_millions)
    lottery.register_contestant(grace, mega_millions)
    lottery.register_contestant(grace, cash_5)
    lottery.register_contestant(grace, pick_4)

    lottery.charge_contestants(cash_5)

    assert_equal(19, grace.spending_money)
    assert_equal(4, winston.spending_money)
  end

  def test_it_can_add_to_current_contestants_after_charge
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })
    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100
    })
    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglas',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20
    })
    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5
    })
    grace = Contestant.new({
      first_name: 'Grace',
      last_name: 'Hopper',
      age: 20,
      state_of_residence: 'CO',
      spending_money: 20
    })
    alexander.add_game_interests('Pick 4')
    alexander.add_game_interests('Mega Millions')
    frederick.add_game_interests('Mega Millions')
    winston.add_game_interests('Cash 5')
    winston.add_game_interests('Mega Millions')
    benjamin.add_game_interests('Mega Millions')
    grace.add_game_interests('Mega Millions')
    grace.add_game_interests('Cash 5')
    grace.add_game_interests('Pick 4')
    lottery.register_contestant(alexander, pick_4)
    lottery.register_contestant(alexander, mega_millions)
    lottery.register_contestant(frederick, mega_millions)
    lottery.register_contestant(winston, cash_5)
    lottery.register_contestant(winston, mega_millions)
    lottery.register_contestant(grace, mega_millions)
    lottery.register_contestant(grace, cash_5)
    lottery.register_contestant(grace, pick_4)
    
    lottery.charge_contestants(cash_5)

    assert_equal(
      {cash_5 => ["Winston Churchill", "Grace Hopper"]},
      lottery.current_contestants
    )

    lottery.charge_contestants(mega_millions)

    assert_equal(
      {
        cash_5 => ["Winston Churchill", "Grace Hopper"],
        mega_millions => ["Alexander Aigades", "Frederick Douglas", "Grace Hopper"]
      },
      lottery.current_contestants
    )
    assert_equal(14, grace.spending_money)
    assert_equal(4, winston.spending_money)
    assert_equal(5, alexander.spending_money)
    assert_equal(15, frederick.spending_money)

    lottery.charge_contestants(pick_4)

    assert_equal(
      {
        cash_5 => ["Winston Churchill", "Grace Hopper"],
        mega_millions => ["Alexander Aigades", "Frederick Douglas", "Grace Hopper"],
        pick_4 => ["Alexander Aigades", "Grace Hopper"]
      },
      lottery.current_contestants
    )
  end

  def test_it_can_draw_winners
    lottery = ColoradoLottery.new

    assert_equal("2020-04-07", lottery.draw_winners)
  end

  def test_it_can_store_winners
    lottery = ColoradoLottery.new
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)
    cash_5 = Game.new('Cash 5', 1)
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })
    benjamin = Contestant.new({
      first_name: 'Benjamin',
      last_name: 'Franklin',
      age: 17,
      state_of_residence: 'PA',
      spending_money: 100
    })
    frederick = Contestant.new({
      first_name:  'Frederick',
      last_name: 'Douglas',
      age: 55,
      state_of_residence: 'NY',
      spending_money: 20
    })
    winston = Contestant.new({
      first_name: 'Winston',
      last_name: 'Churchill',
      age: 18,
      state_of_residence: 'CO',
      spending_money: 5
    })
    grace = Contestant.new({
      first_name: 'Grace',
      last_name: 'Hopper',
      age: 20,
      state_of_residence: 'CO',
      spending_money: 20
    })
    alexander.add_game_interests('Pick 4')
    alexander.add_game_interests('Mega Millions')
    frederick.add_game_interests('Mega Millions')
    winston.add_game_interests('Cash 5')
    winston.add_game_interests('Mega Millions')
    benjamin.add_game_interests('Mega Millions')
    grace.add_game_interests('Mega Millions')
    grace.add_game_interests('Cash 5')
    grace.add_game_interests('Pick 4')
    lottery.register_contestant(alexander, pick_4)
    lottery.register_contestant(alexander, mega_millions)
    lottery.register_contestant(frederick, mega_millions)
    lottery.register_contestant(winston, cash_5)
    lottery.register_contestant(winston, mega_millions)
    lottery.register_contestant(grace, mega_millions)
    lottery.register_contestant(grace, cash_5)
    lottery.register_contestant(grace, pick_4)
    lottery.charge_contestants(cash_5)
    lottery.charge_contestants(mega_millions)
    lottery.charge_contestants(pick_4)

    lottery.announce_winner("Pick 4")
    lottery.announce_winner("Cash 5")
    lottery.announce_winner("Mega Millions")
    
    assert_kind_of(Array, lottery.winners)
    assert_kind_of(Hash, lottery.winners.first)
    assert_kind_of(Hash, lottery.winners.last)
    assert_equal(3, lottery.winners.length)
  end
end