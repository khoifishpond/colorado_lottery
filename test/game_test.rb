require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def test_it_exists
    pick_4 = Game.new('Pick 4', 2)
    mega_millions = Game.new('Mega Millions', 5, true)

    assert_instance_of(Game, pick_4)
    assert_instance_of(Game, mega_millions)
  end

  def test_it_has_a_name
    mega_millions = Game.new('Mega Millions', 5, true)

    assert_equal('Mega Millions', mega_millions.name)
  end
end