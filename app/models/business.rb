class Business < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection

  resourcify

  attr_accessible :billing_address_id, :country_id, :currency_id, :description, :featured, :legal_name, :logo, :mailing_address_id, :name, :notes, :state, :subdomain, :master_pin

  has_many :locations
  has_many :campaigns, class_name: 'Marketing::Campaign'

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

  def downcase_subdomain
    subdomain.downcase
  end

  def create_new_for(user)    
    if self.save
      # complete the operation as an atomic operation
      self.transaction do
        user.add_role :admin, self
      end
    end
  end

end