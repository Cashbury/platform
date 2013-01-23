class Business < ActiveRecord::Base
  resourcify

  attr_accessible :billing_address_id, :country_id, :currency_id, :description, :featured, :legal_name, :logo, :mailing_address_id, :name, :notes, :state, :subdomain, :master_pin

  has_many :locations

  validates_presence_of :legal_name, :description, :name, :state, :subdomain
  validates :legal_name, :length => {minimum: 2, :maximum => 50}
  validates :name, :length => {minimum: 2, maximum: 50}
  validates :master_pin, :length => { :is => 4 },
                         :numericality  => {:only_integer => true }
  validates :subdomain, :length => { :minimum => 3, :maximum => 16 },
                        :uniqueness => true
  validates_format_of :subdomain, :with => /^[a-zA-Z\d]*$/, :message => 'format is invalid, only alphabets and digits are allowed'

  before_save :downcase_subdomain

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