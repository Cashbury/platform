class Game < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :paylines, class_name: 'Game::Payline', :dependent => :destroy
  has_many :icons,    class_name: 'Game::Icon',    :dependent => :destroy
  has_many :businesses

  validates :max_national_prizes, :numericality => { :greater_than => 0 }
  validates :max_merchant_prizes, :numericality => { :greater_than => 0 }

  # validation to support lowest probability 
  # base

  # NOTHING TESTED HERE
  def total_possible_combinations
    icons.repeated_permutation(3).to_a
  end

  def winning_combinations
    paylines.map(&:icons)
  end

  def loosing_combinations
    total_possible_combinations - winning_combinations
  end

  def winning_stops
    Hash[paylines.map {|payline| [payline, Integer(payline.probability * virtual_stops)] }]
  end

  def loosing_stops_counts
    virtual_stops - total_winning_stops
  end

  def base
    32
  end

  def virtual_stops
    base ** 3
  end

  def total_paylines
    paylines.size
  end

  def total_winning_stops
    winning_stops.values.sum
  end

  def build_winning_reel
    winning_stops.each do |winning_payline, icon_count|
      (1..icon_count).each do |num|
        puts "setting up #{num} instance (of #{icon_count} total) instances of #{winning_payline.humanized_icons}..."
        $redis.hmset 'reel', 'size', num 
        $redis.hmset num, 'win', true
        $redis.hmset num, 'payline', winning_payline.humanized_icons
        $redis.hmset num, 'payline_id', winning_payline.id
      end
    end
  end

  def build_loosing_reel
    num_to_start = $redis.hmget('reel', 'size').first.to_i
    (num_to_start..virtual_stops).each do |num|
      loosing_combo = loosing_combinations.sample.map(&:internal_name).join('-')
      puts "setting up #{num} instance (of #{virtual_stops} total) instances of #{loosing_combo}..."
      $redis.hincrby 'reel', 'size', 1
      $redis.hmset num, 'win', false
      $redis.hmset num, 'payline', loosing_combo
      $redis.hmset num, 'payline_id', nil
    end
  end

  def play(token)
    stop = SecureRandom.random_number(virtual_stops)
    response = query_redis_stop(stop)
    ActiveRecord::Base.transaction do 
      puts "actual ->> #{response}"
      token.play
      user = token.user
      business = token.business
      if response[:payline_id].present?
        payline = Game::Payline.find(response[:payline_id])
        prize = payline.prize_for(business)
      end
      if response[:win] == "true" && prize && prize.quantity_available
        prize.unlock_for(user)
      else
        response[:win] == "false"
        response[:result] == loosing_combinations.sample.map(&:internal_name).join('-')
      end
      response
    end
  end

  def query_redis_stop(stop)
    { 
      index: stop, 
      win: $redis.hmget(stop, 'win').first, 
      result: $redis.hmget(stop, 'payline').first,
      payline_id: $redis.hmget(stop, 'payline_id').first
    }
  end

  def output_reel
    wins = 0
    (1..virtual_stops).each do |num|
      win = $redis.hmget(num, 'win').first
      result = $redis.hmget num, 'payline'
      puts "INDEX: #{num}, win: #{win}, result: #{result}"
      wins += 1 if win == "true"
    end
    puts wins
  end

  def simulate(n)
    wins = 0
    losses = 0
    (1..n).each do |num|
      if play[:win] == "true"
        wins += 1
      else
        losses += 1
      end
    end
    puts "total wins = #{wins}"
    puts "total losses = #{losses}"
  end

end
