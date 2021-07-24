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

    assert(lottery.can_register?(alexander, pick_4))
  end
end