class Game::Payline < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :game
  belongs_to :icon1, class_name: 'Game::Icon'
  belongs_to :icon2, class_name: 'Game::Icon'
  belongs_to :icon3, class_name: 'Game::Icon'
  has_many :business_prizes, class_name: 'Marketing::Prize'

  validates_inclusion_of :group, :in => ['national', 'business']

  scope :national, lambda { where(group: 'national') }
  scope :business, lambda { where(group: 'business') }

  def icons
    [icon1, icon2, icon3]
  end

  def humanized_icons
    icons.map(&:internal_name).join('-')
  end

  def prize_for(business)
    business.prizes.where(payline_id: self.id).first
  end

end
