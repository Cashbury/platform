class PrizeBoard

  attr_accessor :paylines

  def initialize(token)
    @token = token
    @paylines = []
    @paylines << load_national_paylines + load_business_paylines
  end

  def load_business_paylines
    @token.business.paylines
  end

  def load_national_paylines
    Game::Payline.national
  end

  def paylines
    @paylines.flatten
  end

end
