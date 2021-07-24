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

  
end