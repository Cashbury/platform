class Api::V1::BusinessesController < Api::V1::BaseController

  def create
  	@business = Business.new(params[:business])
  	if @business.save
  		
  	else
  		render :create_error
  	end
  end

end