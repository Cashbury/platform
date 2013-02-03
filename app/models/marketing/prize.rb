class Marketing::Prize < ActiveRecord::Base
  self.table_name = 'marketing_prizes'

  validates :name, :presence => true
  belongs_to :prizeable, :polymorphic => true

  class << self

    def api_create(params, user)
      prizeable_type = params[:prize].delete(:prizeable_type)
      prizeable      = prizeable_type.constantize.new(params[:prize])
      prize          = Marketing::Prize.new(name: prizeable.prize_name, prizeable: prizeable )
      if prize.valid? && prize.prizeable.valid?
        prize.save
        { success: :ok, object: prizeable }
      else
        prize.prizeable.valid?
        { errors: prize.prizeable.errors.full_messages }
      end
    end

  end
end