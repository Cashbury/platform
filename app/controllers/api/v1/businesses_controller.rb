class Api::V1::BusinessesController < Api::V1::BaseController

  def create
  	@business = Business.new(params[:business])
  	if @business.save
  		render 'create'
  	else
  		render_api_response({ :errors => @business.errors.full_messages })
  	end
  end

  def index
  	@businesses = Business.all
  end

end