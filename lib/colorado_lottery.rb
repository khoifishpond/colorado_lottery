class ColoradoLottery
  attr_reader :registered_contestants,
              :winners

  def initialize
    @registered_contestants = {}
    @winners = []
  end
end