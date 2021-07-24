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
end