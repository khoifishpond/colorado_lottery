require 'minitest/autorun'
require 'minitest/pride'
require './lib/contestant'

class ContestantTest < Minitest::Test
  def test_it_exists
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigiades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })

    assert_instance_of(Contestant, alexander)
  end

  def test_has_a_full_name
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigiades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })

    assert_equal('Alexander Aigiades', alexander.full_name)
  end

  def test_has_an_age
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigiades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })

    assert_equal(28, alexander.age)
  end
  
  def test_has_a_state_of_residence
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigiades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })

    assert_equal('CO', alexander.state_of_residence)
  end

  def test_spends_money
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigiades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })

    assert_equal(10, alexander.spending_money)
  end

  def test_is_out_of_state
    alexander = Contestant.new({
      first_name: 'Alexander',
      last_name: 'Aigiades',
      age: 28,
      state_of_residence: 'CO',
      spending_money: 10
    })

    refute(alexander.state_of_residence)
  end
end