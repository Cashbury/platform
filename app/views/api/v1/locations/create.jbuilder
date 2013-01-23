json.id              @location.id
json.name            @location.name 
json.street_address  @location.street_address
json.city            @location.city
json.state           @location.state
json.country         @location.country
json.postal_code     @location.postal_code
json.description     @location.description 
json.featured_image  @location.featured_image
json.created_at      @location.created_at 
json.updated_at      @location.updated_at
json.latitude        @location.latitude
json.longitude       @location.longitude
json.business do
  json.partial!        'api/v1/businesses/business', business: @location.business
end