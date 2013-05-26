class Business < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  resourcify

  attr_accessible :billing_address_id, :country_id, :currency_id, :description, :featured, :legal_name, :logo, :mailing_address_id, :name, :notes, :state, :subdomain, :master_pin

  has_many :locations
  has_many :campaigns, class_name: 'Marketing::Campaign'
  has_many :prizes, through: :campaigns, :include => :prizeable
  has_many :paylines, through: :prizes, source: :payline
  belongs_to :game

  validates_presence_of :legal_name, :description, :name, :state, :subdomain
  validates :legal_name, :length => {minimum: 2, :maximum => 50}
  validates :name, :length => {minimum: 2, maximum: 50}
  validates :master_pin, :length => { :is => 4 },
                         :numericality  => {:only_integer => true }
  validates :subdomain, :length => { :minimum => 3, :maximum => 16 },
                        :uniqueness => true
  validates_format_of :subdomain, :with => /^[a-zA-Z\d]*$/, :message => 'format is invalid, only alphabets and digits are allowed'

  before_save :downcase_subdomain

  class << self

    def api_pin_update(params, user)
      business = Business.find(params[:id]) rescue nil
      return { errors: ['The business does not exist'] } if business.blank?
      return { errors: ['User is not authorized to update PIN for this business'] } unless user.has_role?(:admin, business)
      
      if business.update_attributes(master_pin: params[:business][:master_pin])
        { success: :ok, object: business }
      else
        { errors: business.errors.full_messages }
      end
    end
    
  end

  # UNTESTED!!
  def available_paylines
    game.paylines.business.order(:probability)
  end


  def auto_assign_prizes
    available_paylines.each do |payline|
      prizes.sort_by(&:value).reverse!.each do |prize|
        prize.assign_to_payline(payline)
      end
    end
  end

  def downcase_subdomain
    subdomain.downcase
  end

  def create_new_for(user)    
    if self.save
      self.transaction do
        user.add_role :admin, self
      end
    end
  end

end