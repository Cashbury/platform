class Prize::MarketingMoney < ActiveRecord::Base
  self.table_name = 'prize_marketing_money'

  validates :prize_name, :presence => true
  validates :description, :presence => true
  validates :picture, :presence => true
  validates :redemption_method, :presence => true
  validates :quantity_available, :presence => true, :numericality => true
  
end