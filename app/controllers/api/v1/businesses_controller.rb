class Api::V1::BusinessesController < Api::V1::BaseController

  def create
  	@business = Business.new(params[:business])
  	if @business.create_new_for(current_user)
  		render 'create'
  	else
  		render_api_response({ :errors => @business.errors.full_messages })
  	end
  end

end