class Location < ActiveRecord::Base
  attr_accessible :is_mobile, :name, :street_address, :city, :state, :country, :postal_code, :phone_number, :description, :featured_image, :business_id
  belongs_to :business

  validates :street_address, presence: true
  validates :city,           presence: true
  validates :country,        presence: true
  validates :state,          presence: true
  validates :postal_code,    presence: true

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    #4 Boake Street, Toronto, ON, M3J0B6, Canada
    addr = [:street_address, :city, :state, :postal_code, :country].map { |elem| self.send(elem) }
    addr.compact.join(', ')
  end

  class << self

    def api_create(params, user)
      business = Business.find(params[:location][:business_id]) rescue nil
      return { :errors => ['Business with provided business id does not exist'] } if business.blank?
      return { :errors => ['You are not authorized to make updates for the requested business']} unless user.has_role?(:admin, business)
      location = business.locations.build(params[:location])

      if location.save
        { success: :ok, object: location }
      else
        { errors: location.errors.full_messages }
      end
    end

  end

end