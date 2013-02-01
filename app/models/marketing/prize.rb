class Marketing::Prize < ActiveRecord::Base
  self.table_name = 'marketing_prizes'

  validates :name, :presence => true

  belongs_to :prizeable, :polymorphic => true
end