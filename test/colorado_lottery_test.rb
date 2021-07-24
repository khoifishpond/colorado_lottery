require 'minitest/autorun'
require './lib/colorado_lottery'
require './lib/contest'
require './lib/game'

class ColoradoLotteryTest < Minitest::Test
  def test_it_exists
    lottery = ColoradoLottery.new

    assert_instance_of(ColoradoLottery, lottery)
  end
end