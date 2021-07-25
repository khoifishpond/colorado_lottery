class ColoradoLottery
  attr_reader :registered_contestants,
              :winners,
              :current_contestants

  def initialize
    @registered_contestants = {}
    @winners = []
    @current_contestants = {}
  end

  def interested_and_18?(contestant, game)
    contestant.age >= 18 && contestant.game_interests.include?(game.name)
  end

  def can_register?(contestant, game)
    interested_and_18?(contestant, game)
  end

  def register_contestant(contestant, game)
    if can_register?(contestant, game)
      @registered_contestants[game.name] ||= []
      @registered_contestants[game.name] << contestant
    end
  end

  def eligible_contestants(game)
    @registered_contestants[game.name]
  end

  def charge_contestants(game)
    eligible_contestants(game).each do |contestant|
      if contestant.spending_money >= game.cost
        contestant.charge(game)
        @current_contestants[game] ||= []
        @current_contestants[game] << contestant.full_name
      end
    end
  end
end