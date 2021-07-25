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
    interested_and_18?(contestant, game) && (contestant.out_of_state? == false || game.national_drawing?)
  end

  def register_contestant(contestant, game)
    if can_register?(contestant, game)
      @registered_contestants[game.name] ||= []
      @registered_contestants[game.name] << contestant
    end
  end

  def eligible_contestants(game)
    @registered_contestants[game.name].select do |contestant|
      contestant.spending_money >= game.cost
    end
  end

  def charge_contestants(game)
    eligible_contestants(game).each do |contestant|
      contestant.charge(game)
      @current_contestants[game] ||= []
      @current_contestants[game] << contestant.full_name
    end
  end

  def draw_winners
    # idk just cuz
    "2020-04-07"
  end

  def draw_month_day
    draw_winners.split('-')
  end

  def game_selection(game_name)
    @current_contestants.keys.select do |game|
      game.name == game_name
    end.first
  end

  def announce_winner(game_name)
    winner = {}
    name = @current_contestants[game_selection(game_name)].sample
    winner[name] = game_name
    @winners << winner

    "#{name} won the #{game_name} on #{draw_month_day[1]}/#{draw_month_day[2]}"
  end
end