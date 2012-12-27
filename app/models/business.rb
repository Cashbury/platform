class Business < ActiveRecord::Base
  # attr_accessible :billing_address_id, :country_id, :currency_id, :description, :featured, :legal_name, :logo, :mailing_address_id, :name, :notes, :state

  validates_presence_of :legal_name, :description, :name, :state

end