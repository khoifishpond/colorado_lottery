class Contestant
  attr_reader :first_name,
              :last_name,
              :age,
              :state_of_residence,
              :spending_money,
              :game_interests

  def initialize(params)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @age = params[:age]
    @state_of_residence = params[:state_of_residence]
    @spending_money = params[:spending_money]
    @game_interests = []
  end

  def full_name
    @first_name + " " + @last_name
  end

  def out_of_state?
    @state_of_residence != 'CO'
  end
end